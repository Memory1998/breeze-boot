/*
 * Copyright (c) 2023, gaoweixuan (breeze-cloud@foxmail.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.breeze.boot.modules.system.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.breeze.boot.core.enums.ResultCode;
import com.breeze.boot.core.exception.SystemServiceException;
import com.breeze.boot.core.utils.BreezeThreadLocal;
import com.breeze.boot.core.utils.Result;
import com.breeze.boot.modules.auth.model.entity.SysUser;
import com.breeze.boot.modules.auth.service.SysUserService;
import com.breeze.boot.modules.system.model.entity.SysMsg;
import com.breeze.boot.modules.system.service.SysMsgService;
import com.breeze.boot.websocket.dto.UserMsgDTO;
import com.breeze.boot.websocket.events.MsgSaveEvent;
import com.breeze.boot.websocket.events.PublisherSaveMsgEvent;
import com.breeze.boot.websocket.params.FlowMsgParam;
import com.breeze.boot.websocket.params.MsgParam;
import com.breeze.boot.websocket.service.WebSocketMsgService;
import com.breeze.boot.websocket.vo.MsgVO;
import com.google.common.collect.Lists;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;
import java.util.Objects;

/**
 * stompJs 消息模块接口impl
 *
 * @author gaoweixuan
 * @since 2022-10-08
 */
@Slf4j
@Service("stompJsMsgService")
@RequiredArgsConstructor
public class StompJsWebSocketMsgServiceImpl extends WebSocketMsgService {

    /**
     * 简单消息模板
     */
    private final SimpMessagingTemplate simpMessagingTemplate;

    /**
     * 保存消息事件
     */
    private final PublisherSaveMsgEvent publisherSaveMsgEvent;

    /**
     * 系统消息服务
     */
    private final SysMsgService sysMsgService;

    /**
     * 系统用户服务
     */
    private final SysUserService sysUserService;

    private static UserMsgDTO.MsgBody buildMsgBody(SysMsg sysMsg, SysUser sysUser) {
        // @formatter:off
        return UserMsgDTO.MsgBody.builder()
                .msgId(sysMsg.getId())
                .code(sysMsg.getCode())
                .title(sysMsg.getTitle())
                .deptId(sysUser.getDeptId())
                .level(sysMsg.getLevel())
                .userId(sysUser.getId())
                .type(sysMsg.getType())
                .content(sysMsg.getContent())
                .build();
        // @formatter:on
    }

    private static MsgVO buildMsgVO(SysMsg sysMsg) {
        // @formatter:off
        return MsgVO.builder()
                .id(sysMsg.getId())
                .title(sysMsg.getTitle())
                .level(sysMsg.getLevel())
                .code(sysMsg.getCode())
                .type(sysMsg.getType())
                .content(sysMsg.getContent())
                .build();
        // @formatter:on
    }

    /**
     * 消息广播
     *
     * @param msgParam 消息参数
     * @return {@link Result}<{@link MsgVO}>
     */
    @Override
    public Result<MsgVO> asyncSendBroadcastMsg(MsgParam msgParam) {
        BreezeThreadLocal.set(msgParam.getTenantId());
        SysMsg sysMsg = this.sysMsgService.getById(msgParam.getMsgId());
        if (Objects.isNull(sysMsg)) {
            log.error("[消息不存在] {}", msgParam.getMsgId());
            return Result.fail("消息不存在");
        }
        this.sendMsgToUser(this.sysUserService.list(), sysMsg);
        BreezeThreadLocal.remove();
        return Result.ok(buildMsgVO(sysMsg));
    }

    /**
     * 发送消息给用户
     *
     * @param principal 主要
     * @param msgParam  消息参数
     * @return {@link Result}<{@link MsgVO}>
     */
    @Override
    public Result<MsgVO> asyncSendMsgToSingleUser(Principal principal, MsgParam msgParam) {
        BreezeThreadLocal.set(msgParam.getTenantId());
        log.debug("[msgId]：{}, [username]： {}", msgParam.getMsgId(), principal.getName());
        SysMsg sysMsg = this.sysMsgService.getById(msgParam);
        if (Objects.isNull(sysMsg)) {
            log.error("[消息不存在]{}", msgParam.getMsgId());
            return Result.fail("消息不存在");
        }
        this.sendMsgToUser(this.sysUserService.listByIds(msgParam.getUserIds()), sysMsg);
        BreezeThreadLocal.remove();
        return Result.ok(buildMsgVO(sysMsg));
    }

    /**
     * 异步发送消息
     *
     * @param msgBodyList 系统用户消息BO列表
     */
    private void asyncSendMsg(List<UserMsgDTO.MsgBody> msgBodyList) {
        UserMsgDTO userMsgDTO = new UserMsgDTO();
        userMsgDTO.setMsgBodyList(msgBodyList);
        this.publisherSaveMsgEvent.publisherEvent(new MsgSaveEvent(userMsgDTO));
    }

    /**
     * 发送消息给指定用户
     *
     * @param msgParam  消息参数
     * @param principal 主要
     */
    @Override
    public void asyncSendMsgToUser(Principal principal, MsgParam msgParam) {
        BreezeThreadLocal.set(msgParam.getTenantId());
        log.debug("[msgId]： {}, [username]： {}", msgParam.getMsgId(), principal.getName());
        SysMsg sysMsg = this.sysMsgService.getById(msgParam.getMsgId());
        if (Objects.isNull(sysMsg)) {
            log.error("[消息不存在]{}", msgParam.getMsgId());
            throw new SystemServiceException(ResultCode.exception("未发现此消息"));
        }
        MsgVO msgVO = MsgVO.builder()
                .id(sysMsg.getId())
                .title(sysMsg.getTitle())
                .code(sysMsg.getCode())
                .type(sysMsg.getType())
                .level(sysMsg.getLevel())
                .content(sysMsg.getContent())
                .build();
        List<UserMsgDTO.MsgBody> sysUserMsgList = sendAndGetMsgBodyList(msgParam.getUserIds(), msgVO, sysMsg);
        BreezeThreadLocal.remove();
        this.asyncSendMsg(sysUserMsgList);
    }

    @Override
    public void asyncSendMsgToUser(FlowMsgParam msgParam) {
        BreezeThreadLocal.set(msgParam.getTenantId());
        SysMsg sysMsg = this.sysMsgService.getOne(Wrappers.<SysMsg>lambdaQuery().eq(SysMsg::getCode, msgParam.getMsgCode()));
        if (Objects.isNull(sysMsg)) {
            log.error("[消息不存在]{}", msgParam.getMsgCode());
            throw new SystemServiceException(ResultCode.exception("未发现此消息"));
        }
        MsgVO msgVO = MsgVO.builder()
                .id(sysMsg.getId())
                .title(sysMsg.getTitle())
                .code(sysMsg.getCode())
                .type(sysMsg.getType())
                .level(sysMsg.getLevel())
                .content(String.format(sysMsg.getContent(), msgParam.getContentMap()))
                .build();
        List<UserMsgDTO.MsgBody> sysUserMsgList = sendAndGetMsgBodyList(msgParam.getUserIds(), msgVO, sysMsg);
        BreezeThreadLocal.remove();
        this.asyncSendMsg(sysUserMsgList);
    }

    @NotNull
    private List<UserMsgDTO.MsgBody> sendAndGetMsgBodyList(List<Long> userIds, MsgVO msgVO, SysMsg sysMsg) {
        List<UserMsgDTO.MsgBody> sysUserMsgList = Lists.newArrayList();
        List<SysUser> sysUserList = this.sysUserService.listByIds(userIds);
        for (SysUser sysUser : sysUserList) {
            // 这里只是使用另一种实现方式
            this.simpMessagingTemplate.convertAndSendToUser(sysUser.getUsername(), "/queue/userMsg", Result.ok(msgVO));
            sysUserMsgList.add(buildMsgBody(sysMsg, sysUser));
        }
        return sysUserMsgList;
    }

    /**
     * 发送消息给部门用户
     *
     * @param principal 主要
     * @param msgParam  消息参数
     * @return {@link Result}<{@link MsgVO}>
     */
    @Override
    public Result<MsgVO> syncSendMsgDeptUser(Principal principal, MsgParam msgParam) {
        BreezeThreadLocal.set(msgParam.getTenantId());
        log.debug("[msgId]：{}, [username]： {}", msgParam, principal.getName());
        SysMsg sysMsg = this.sysMsgService.getById(msgParam.getMsgId());
        if (Objects.isNull(sysMsg)) {
            log.error("[消息不存在]{}", msgParam.getMsgId());
            return Result.fail("消息不存在");
        }
        this.sendMsgToUser(this.sysUserService.listDeptsUser(msgParam.getDeptId()), sysMsg);
        BreezeThreadLocal.remove();
        return Result.ok(buildMsgVO(sysMsg));
    }

    /**
     * 发送消息给指定用户
     *
     * @param sysUserList 系统用户列表
     * @param sysMsg      系统消息
     */
    private void sendMsgToUser(List<SysUser> sysUserList, SysMsg sysMsg) {
        List<UserMsgDTO.MsgBody> msgBodyList = Lists.newArrayList();
        for (SysUser sysUser : sysUserList) {
            log.debug("[msgId]：{}, [username]： {}", sysUser, sysUser.getUsername());
            msgBodyList.add(buildMsgBody(sysMsg, sysUser));
        }
        this.asyncSendMsg(msgBodyList);
    }
}
