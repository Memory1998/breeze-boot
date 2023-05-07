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

package com.breeze.boot.system.params;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 系统数据权限自定义添加参数
 *
 * @author gaoweixuan
 * @date 2022-11-12
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Schema(description = "系统数据权限自定义添加参数")
public class PermissionDiyParam {

    private static final long serialVersionUID = 1L;

    /**
     * 系统数据权限自定义ID
     */
    @Schema(description = "系统数据权限自定义ID")
    private String id;

    /**
     * 列
     */
    @Schema(description = "列")
    private String tableColumn;

    /**
     * 条件
     */
    @Schema(description = "条件")
    private String conditions;

    /**
     * 比较
     */
    @Schema(description = "比较")
    private String compare;

    /**
     * 运算符
     */
    @Schema(description = "运算符")
    private String operator;

}