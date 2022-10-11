/*
 * Copyright 2022 the original author or authors.
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

package com.breeze.boot.system.service;

import cn.hutool.core.lang.tree.Tree;
import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.boot.system.dto.DeptDTO;
import com.breeze.boot.system.entity.SysDept;
import com.breeze.boot.core.Result;

import java.util.List;

/**
 * 系统部门服务
 *
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
public interface SysDeptService extends IService<SysDept> {

    /**
     * 部门列表
     *
     * @param deptDTO 部门dto
     * @return {@link List}<{@link Tree}<{@link Long}>>
     */
    List<Tree<Long>> listDept(DeptDTO deptDTO);

    /**
     * 删除通过id
     *
     * @param id id
     * @return {@link Result}
     */
    Result deleteById(Long id);

}
