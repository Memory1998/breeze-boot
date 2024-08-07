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

package com.breeze.boot.modules.auth.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.boot.modules.auth.mapper.SysPlatformMapper;
import com.breeze.boot.modules.auth.model.entity.SysPlatform;
import com.breeze.boot.modules.auth.model.form.PlatformForm;
import com.breeze.boot.modules.auth.model.mappers.SysPlatformMapStruct;
import com.breeze.boot.modules.auth.model.query.PlatformQuery;
import com.breeze.boot.modules.auth.model.vo.PlatformVO;
import com.breeze.boot.modules.auth.service.SysPlatformService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 系统平台服务impl
 *
 * @author gaoweixuan
 * @since 2021-12-06 22:03:39
 */
@Service
@RequiredArgsConstructor
public class SysPlatformServiceImpl extends ServiceImpl<SysPlatformMapper, SysPlatform> implements SysPlatformService {

    private final SysPlatformMapStruct sysPlatformMapStruct;

    /**
     * 列表页面
     *
     * @param platformQuery 平台查询
     * @return {@link Page}<{@link PlatformVO}>
     */
    @Override
    public Page<PlatformVO> listPage(PlatformQuery platformQuery) {
        Page<SysPlatform> platformEntityPage = new Page<>(platformQuery.getCurrent(), platformQuery.getSize());
        QueryWrapper<SysPlatform> queryWrapper = new QueryWrapper<>();
        platformQuery.getSortQueryWrapper(queryWrapper);
        queryWrapper.like(StrUtil.isAllNotBlank(platformQuery.getPlatformName()), "platform_name", platformQuery.getPlatformName())
                .like(StrUtil.isAllNotBlank(platformQuery.getPlatformCode()), "platform_code", platformQuery.getPlatformCode());
        Page<SysPlatform> page = this.page(platformEntityPage, queryWrapper);
        return this.sysPlatformMapStruct.page2PageVO(page);
    }

    /**
     * 详情
     *
     * @param platformId 平台id
     * @return {@link PlatformVO }
     */
    @Override
    public PlatformVO getInfoById(Long platformId) {
        SysPlatform sysPlatform = this.getById(platformId);
        return this.sysPlatformMapStruct.entity2VO(sysPlatform);
    }

    /**
     * 保存平台
     *
     * @param platformForm 平台形式
     * @return {@link Boolean }
     */
    @Override
    public Boolean savePlatform(PlatformForm platformForm) {
        return this.save(sysPlatformMapStruct.form2Entity(platformForm));
    }

    /**
     * 修改平台
     *
     * @param id           ID
     * @param platformForm 平台形式
     * @return {@link Boolean }
     */
    @Override
    public Boolean modifyPlatform(Long id, PlatformForm platformForm) {
        SysPlatform sysPlatform = sysPlatformMapStruct.form2Entity(platformForm);
        sysPlatform.setId(id);
        return this.updateById(sysPlatform);
    }

}
