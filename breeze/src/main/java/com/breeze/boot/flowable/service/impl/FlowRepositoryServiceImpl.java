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

package com.breeze.boot.flowable.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.boot.flowable.dto.FlowRepositoryDTO;
import com.breeze.boot.flowable.service.IFlowRepositoryService;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.ProcessDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 流程资源服务impl
 *
 * @author gaoweixuan
 * @date 2023-03-01
 */
@Slf4j
@Service
public class FlowRepositoryServiceImpl implements IFlowRepositoryService {

    /**
     * 流程资源库服务
     */
    @Autowired
    private RepositoryService repositoryService;

    /**
     * 列表页面
     *
     * @param flowRepositoryDTO 流程资源库dto
     * @return {@link IPage}<{@link ProcessDefinition}>
     */
    @Override
    public IPage<ProcessDefinition> listPage(FlowRepositoryDTO flowRepositoryDTO) {
        List<ProcessDefinition> processDefinitions = repositoryService.createProcessDefinitionQuery()
                .listPage(flowRepositoryDTO.getCurrent(), flowRepositoryDTO.getSize());

        for (ProcessDefinition processDefinition : processDefinitions) {
            log.info(processDefinition.getDeploymentId());
        }
        Page<ProcessDefinition> page = new Page<>();
        page.setRecords(processDefinitions);
        return page;
    }

}