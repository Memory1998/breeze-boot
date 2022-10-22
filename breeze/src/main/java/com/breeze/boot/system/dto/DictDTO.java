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

package com.breeze.boot.system.dto;

import lombok.Data;

/**
 * 字典 dto
 *
 * @author breeze
 * @date 2022-09-02
 */
@Data
public class DictDTO extends PageDTO {

    /**
     * 字典 id
     */
    private Long id;

    /**
     * 字典 名称
     */
    private String dictName;

    /**
     * 字典 代码
     */
    private String dictCode;

    /**
     * 是开放
     */
    private Integer isOpen;

}