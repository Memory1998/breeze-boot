/*
 * Copyright (c) 2021-2022, gaoweixuan (breeze-cloud@foxmail.com).
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

package com.breeze.boot.system.controller;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.boot.core.Result;
import com.breeze.boot.log.annotation.BreezeSysLog;
import com.breeze.boot.log.config.LogType;
import com.breeze.boot.system.domain.SysMenu;
import com.breeze.boot.system.domain.SysPlatform;
import com.breeze.boot.system.dto.PlatformDTO;
import com.breeze.boot.system.service.SysMenuService;
import com.breeze.boot.system.service.SysPlatformService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.List;

/**
 * 系统平台控制器
 *
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@RestController
@AllArgsConstructor
@RequestMapping("/sys/platform")
@Tag(name = "系统平台管理模块", description = "SysPlatformController")
public class SysPlatformController {

    /**
     * 系统平台服务
     */
    private final SysPlatformService sysPlatformService;

    /**
     * 系统菜单服务
     */
    private final SysMenuService sysMenuService;

    /**
     * 列表
     *
     * @param platformDTO 平台dto
     * @return {@link Result}
     */
    @Operation(summary = "列表")
    @PostMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:platform:list')")
    @BreezeSysLog(description = "平台信息列表", type = LogType.LIST)
    public Result<Page<SysPlatform>> list(@Validated @RequestBody PlatformDTO platformDTO) {
        return Result.ok(this.sysPlatformService.listPage(platformDTO));
    }

    /**
     * 信息
     *
     * @param id id
     * @return {@link Result}
     */
    @Operation(summary = "详情")
    @GetMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:platform:info')")
    @BreezeSysLog(description = "平台信息详情", type = LogType.INFO)
    public Result<SysPlatform> info(@PathVariable("id") Long id) {
        return Result.ok(this.sysPlatformService.getById(id));
    }

    /**
     * 保存
     *
     * @param platform 平台实体入参
     * @return {@link Result}
     */
    @Operation(summary = "保存")
    @PostMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:platform:save')")
    @BreezeSysLog(description = "平台信息保存", type = LogType.SAVE)
    public Result<Boolean> save(@Validated @RequestBody SysPlatform platform) {
        return Result.ok(this.sysPlatformService.save(platform));
    }

    /**
     * 修改
     *
     * @param sysPlatform 平台实体
     * @return {@link Result}
     */
    @Operation(summary = "修改")
    @PutMapping("/edit")
    @PreAuthorize("hasAnyAuthority('sys:platform:edit')")
    @BreezeSysLog(description = "平台信息修改", type = LogType.EDIT)
    public Result<Boolean> edit(@Validated @RequestBody SysPlatform sysPlatform) {
        return Result.ok(this.sysPlatformService.updateById(sysPlatform));
    }

    /**
     * 删除
     *
     * @param ids id
     * @return {@link Result}
     */
    @Operation(summary = "删除")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:platform:delete')")
    @BreezeSysLog(description = "平台信息删除", type = LogType.DELETE)
    public Result<Boolean> delete(@NotNull(message = "参数不能为空") @RequestBody Long[] ids) {
        List<SysMenu> menuEntityList = this.sysMenuService.list(Wrappers.<SysMenu>lambdaQuery().in(SysMenu::getPlatformId, ids));
        if (CollectionUtil.isNotEmpty(menuEntityList)) {
            return Result.warning(Boolean.FALSE, "该平台有菜单配置");
        }
        return Result.ok(this.sysPlatformService.removeByIds(Arrays.asList(ids)));
    }

}
