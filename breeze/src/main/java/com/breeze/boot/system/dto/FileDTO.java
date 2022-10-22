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
 * 文件dto
 *
 * @author breeze
 * @date 2022-09-02
 */
@Data
public class FileDTO extends PageDTO {
    /**
     * 旧文件名称
     */
    private String oldFileName;
    /**
     * 新文件名字
     */
    private String newFileName;
    /**
     * 用户id
     */
    private String userId;
    /**
     * 用户代码
     */
    private String userCode;
    /**
     * 用户名
     */
    private String username;

    /**
     * url
     */
    private String url;
}