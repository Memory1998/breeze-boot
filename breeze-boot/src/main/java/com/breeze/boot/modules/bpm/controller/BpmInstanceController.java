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

package com.breeze.boot.modules.bpm.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.boot.core.utils.Result;
import com.breeze.boot.modules.bpm.model.form.BpmApprovalForm;
import com.breeze.boot.modules.bpm.model.form.BpmStartForm;
import com.breeze.boot.modules.bpm.model.query.BpmInstanceQuery;
import com.breeze.boot.modules.bpm.model.vo.BpmInstanceVO;
import com.breeze.boot.modules.bpm.service.IBpmInstanceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springdoc.api.annotations.ParameterObject;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 流程实例控制器
 *
 * @author gaoweixuan
 * @since 2023-03-01
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/bpm/v1/instance")
@Tag(name = "流程实例管理模块", description = "BpmInstanceController")
public class BpmInstanceController {

    /**
     * 流程资源服务
     */
    private final IBpmInstanceService bpmInstanceService;

    /**
     * 列表
     *
     * @param bpmInstanceQuery 流程实例查询
     * @return {@link Result}<{@link Page}<{@link BpmInstanceVO}>>
     */
    @Operation(summary = "列表")
    @GetMapping
    @PreAuthorize("hasAnyAuthority('bpm:instance:list')")
    public Result<Page<BpmInstanceVO>> list(@ParameterObject BpmInstanceQuery bpmInstanceQuery) {
        return Result.ok(this.bpmInstanceService.listPage(bpmInstanceQuery));
    }

    /**
     * 发起流程
     *
     * @param startForm 流程启动参数
     * @return {@link Result }<{@link String }>
     */
    @Operation(summary = "发起")
    @PostMapping("/start")
    @PreAuthorize("hasAnyAuthority('bpm:instance:start')")
    public Result<String> startProcess(@Valid @RequestBody @ParameterObject BpmStartForm startForm) {
        return this.bpmInstanceService.startProcess(startForm);
    }


    /**
     * 挂起
     *
     * @param procInstId 流程实例ID
     * @return {@link Result }<{@link String }>
     */
    @Operation(summary = "挂起")
    @PutMapping("/suspendedInstance")
    @PreAuthorize("hasAnyAuthority('bpm:instance:suspended')")
    public Result<Boolean> suspendedInstance(@NotBlank(message = "流程实例ID不能为空") @Schema(description = "流程实例ID")
                                             @RequestParam(name = "procInstId") String procInstId) {
        return this.bpmInstanceService.suspendedInstance(procInstId);
    }

    /**
     * 作废
     */
    @PostMapping(value = "/voidProcess")
    @ResponseBody
    public Result<?> voidProcess(@Validated @RequestBody @ParameterObject BpmApprovalForm bpmApprovalForm) {
        bpmInstanceService.voidProcess(bpmApprovalForm);
        return Result.ok();
    }

    /**
     * 删除
     */
    @DeleteMapping
    @ResponseBody
    public Result<?> remove(@NotBlank(message = "流程实例ID不能为空") @Schema(description = "流程实例ID")
                            @RequestBody List<String> processInstanceIdList) {
        bpmInstanceService.remove(processInstanceIdList);
        return Result.ok();
    }

}
