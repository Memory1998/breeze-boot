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

package com.breeze.boot.message.config;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.breeze.boot.core.base.UserInfoDTO;
import com.breeze.boot.core.enums.ResultCode;
import com.breeze.boot.core.exception.BreezeBizException;
import com.breeze.boot.message.utils.WebSocketSecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;

import java.security.Principal;
import java.util.List;
import java.util.Objects;

/**
 * 通道拦截器适配器
 *
 * @author gaoweixuan
 * @since 2022-11-16
 */
@Slf4j
public class BreezeChannelInterceptorAdapter implements ChannelInterceptor {

    /**
     * 收到之前
     *
     * @param channel 通道
     * @return boolean
     */
    @Override
    public boolean preReceive(@NotNull MessageChannel channel) {
        return true;
    }

    /**
     * 发送前
     *
     * @param message 消息
     * @param channel 通道
     * @return {@link Message}<{@link ?}>
     */
    @Override
    public Message<?> preSend(@NotNull Message<?> message, @NotNull MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
        assert accessor != null;
        String sessionId = accessor.getSessionId();
        StompCommand command = accessor.getCommand();
        log.info("[发送后拦截, 状态: {} 心跳： {}]", command, accessor.getHeartbeat());
        if (StompCommand.CONNECT.equals(accessor.getCommand())) {
            List<String> nativeHeader = accessor.getNativeHeader("username");
            String username = checkUserPermission(nativeHeader);
            log.info("[发送前拦截{}请求]", username);
            Principal principal = () -> username;
            accessor.setUser(principal);

            return message;
        }
        // 检测用户订阅内容（防止用户订阅不合法频道）
        if (StompCommand.SUBSCRIBE.equals(command)) {
            log.debug("[订阅内容]");
        }
        // 检测用户发送内容
        if (StompCommand.SEND.equals(command)) {
            Object simpUser = accessor.getHeader( SimpMessageHeaderAccessor.USER_HEADER);
            assert simpUser != null;
            Principal principal = (Principal) simpUser;
            UserInfoDTO user = WebSocketSecurityUtils.getCurrentUser(principal.getName());
            if (Objects.isNull(user)) {
                throw new BreezeBizException(ResultCode.SYSTEM_EXCEPTION);
            }
            log.debug("[订阅内容] {}", principal.getName());
        }
        return message;
    }

    private static String checkUserPermission(List<String> nativeHeader) {
        if (CollUtil.isEmpty(nativeHeader)) {
            throw new BreezeBizException(ResultCode.SYSTEM_EXCEPTION);
        }
        String username = nativeHeader.get(0);
        if (StrUtil.isAllBlank(username)) {
            throw new BreezeBizException(ResultCode.SYSTEM_EXCEPTION);
        }
        UserInfoDTO user = WebSocketSecurityUtils.getCurrentUser(username);
        if (Objects.isNull(user)) {
            throw new BreezeBizException(ResultCode.SYSTEM_EXCEPTION);
        }
        return username;
    }

    /**
     * 发送完成后
     *
     * @param message 消息
     * @param channel 通道
     * @param sent    发送
     * @param ex      异常
     */
    @Override
    public void afterSendCompletion(@NotNull Message<?> message, @NotNull MessageChannel channel, boolean sent, Exception ex) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
        StompCommand command = accessor.getCommand();
        log.info("[发送后拦截, 状态: {} 心跳： {}]", command, accessor.getHeartbeat());
    }
}
