
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

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.boot.core.base.CustomizePermission;
import com.breeze.boot.core.enums.DataPermissionType;
import com.breeze.boot.core.enums.ResultCode;
import com.breeze.boot.core.exception.BreezeBizException;
import com.breeze.boot.core.utils.BreezeThreadLocal;
import com.breeze.boot.core.utils.Result;
import com.breeze.boot.modules.auth.mapper.SysRowPermissionMapper;
import com.breeze.boot.modules.auth.model.entity.SysRoleRowPermission;
import com.breeze.boot.modules.auth.model.entity.SysRowPermission;
import com.breeze.boot.modules.auth.model.entity.SysTenant;
import com.breeze.boot.modules.auth.model.form.RowPermissionForm;
import com.breeze.boot.modules.auth.model.mappers.SysRowPermissionMapStruct;
import com.breeze.boot.modules.auth.model.query.RowPermissionQuery;
import com.breeze.boot.modules.auth.model.vo.RowPermissionVO;
import com.breeze.boot.modules.auth.service.SysRoleRowPermissionService;
import com.breeze.boot.modules.auth.service.SysRowPermissionService;
import com.breeze.boot.modules.auth.service.SysTenantService;
import lombok.RequiredArgsConstructor;
import org.jetbrains.annotations.NotNull;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.breeze.boot.core.constants.CacheConstants.ROW_PERMISSION;

/**
 * 系统行级数据权限服务 impl
 *
 * @author gaoweixuan
 * @since 2022-10-30
 */
@Service
@RequiredArgsConstructor
public class SysRowPermissionServiceImpl extends ServiceImpl<SysRowPermissionMapper, SysRowPermission> implements SysRowPermissionService {

    /**
     * 系统角色数据权限服务
     */
    private final SysRoleRowPermissionService sysRoleRowPermissionService;

    private final SysRowPermissionMapStruct sysRowPermissionMapStruct;

    private final SysTenantService sysTenantService;

    private final CacheManager cacheManager;

    @Override
    @PostConstruct
    public void init() {
        List<SysTenant> sysTenantList = sysTenantService.list();
        Cache cache = getCache();

        sysTenantList.forEach(sysTenant -> {
            BreezeThreadLocal.set(sysTenant.getId());
            try {
                List<SysRowPermission> sysRowPermissionList = this.list();
                // 使用批量处理优化
                List<CustomizePermission> customizePermissionList = new ArrayList<>();
                sysRowPermissionList.forEach(rowPermission -> {
                    CustomizePermission customizePermission = sysRowPermissionMapStruct.entity2Cache(rowPermission);
                    String permissionsString = rowPermission.getPermissions().stream()
                            .map(Object::toString)
                            .collect(Collectors.joining(","));
                    customizePermission.setPermissions(permissionsString);
                    customizePermissionList.add(customizePermission);
                });

                // 批量添加到缓存中
                customizePermissionList.forEach(customizePermission -> {
                    String permissionCode = customizePermission.getPermissionCode();
                    cache.put(permissionCode, customizePermission);
                });
            } catch (Exception e) {
                // 增加异常处理逻辑，记录日志或进行其他处理
                log.error("Error processing tenant: " + sysTenant.getId(), e);
            } finally {
                BreezeThreadLocal.remove();
            }
        });
    }

    /**
     * 列表页面
     *
     * @param rowPermissionQuery 权限查询
     * @return {@link Page}<{@link RowPermissionVO}>
     */
    @Override
    public Page<RowPermissionVO> listPage(RowPermissionQuery rowPermissionQuery) {
        Page<SysRowPermission> rowPermissionPage = this.baseMapper.listPage(new Page<>(rowPermissionQuery.getCurrent(), rowPermissionQuery.getSize()), rowPermissionQuery);
        return this.sysRowPermissionMapStruct.page2VOPage(rowPermissionPage);
    }

    /**
     * 按id获取信息
     *
     * @param permissionId 权限id
     * @return {@link RowPermissionVO }
     */
    @Override
    public RowPermissionVO getInfoById(Long permissionId) {
        SysRowPermission sysRowPermission = this.getById(permissionId);
        Cache cache = getCache();
        cache.put(sysRowPermission.getPermissionCode(), sysRowPermission);
        CustomizePermission customizePermission = sysRowPermissionMapStruct.entity2Cache(sysRowPermission);
        String permissionsString = sysRowPermission.getPermissions().stream()
                .map(Object::toString)
                .collect(Collectors.joining(","));
        customizePermission.setPermissions(permissionsString);

        // 批量添加到缓存中
        String permissionCode = customizePermission.getPermissionCode();
        cache.put(permissionCode, customizePermission);
        return this.sysRowPermissionMapStruct.entity2VO(sysRowPermission);
    }

    /**
     * 保存数据权限
     *
     * @param rowPermissionForm 行权限表单
     * @return {@link Result}<{@link Boolean}>
     */
    @Override
    public Result<Boolean> saveRowPermission(RowPermissionForm rowPermissionForm) {
        SysRowPermission sysRowPermission = sysRowPermissionMapStruct.form2Entity(rowPermissionForm);
        if (DataPermissionType.checkInEnum(rowPermissionForm.getPermissionCode())) {
            throw new BreezeBizException(ResultCode.NO_ACTION_IS_ALLOWED);
        }
        boolean save = this.save(sysRowPermission);
        if (!save) {
            throw new BreezeBizException(ResultCode.FAIL);
        }
        Cache cache = getCache();
        cache.put(sysRowPermission.getPermissionCode(), sysRowPermission);
        CustomizePermission customizePermission = sysRowPermissionMapStruct.entity2Cache(sysRowPermission);
        String permissionsString = sysRowPermission.getPermissions().stream()
                .map(Object::toString)
                .collect(Collectors.joining(","));
        customizePermission.setPermissions(permissionsString);

        // 批量添加到缓存中
        String permissionCode = customizePermission.getPermissionCode();
        cache.put(permissionCode, customizePermission);
        return Result.ok();
    }

    @NotNull
    private Cache getCache() {
        Cache cache = cacheManager.getCache(ROW_PERMISSION);
        // 检查cache是否为null
        if (cache == null) {
            throw new IllegalStateException("Cache is null.");
        }
        return cache;
    }

    /**
     * 修改权限
     *
     * @param id                id
     * @param rowPermissionForm 行权限表单
     * @return {@link Result }<{@link Boolean }>
     */
    @Override
    public Result<Boolean> modifyRowPermission(Long id, RowPermissionForm rowPermissionForm) {
        SysRowPermission sysRowPermission = sysRowPermissionMapStruct.form2Entity(rowPermissionForm);
        sysRowPermission.setId(id);
        if (DataPermissionType.checkInEnum(rowPermissionForm.getPermissionCode())) {
            throw new BreezeBizException(ResultCode.NO_ACTION_IS_ALLOWED);
        }
        boolean update = sysRowPermission.updateById();
        if (!update) {
            throw new BreezeBizException(ResultCode.FAIL);
        }
        Cache cache = getCache();
        cache.put(sysRowPermission.getPermissionCode(), sysRowPermission);
        CustomizePermission customizePermission = sysRowPermissionMapStruct.entity2Cache(sysRowPermission);
        String permissionsString = sysRowPermission.getPermissions().stream()
                .map(Object::toString)
                .collect(Collectors.joining(","));
        customizePermission.setPermissions(permissionsString);

        // 批量添加到缓存中
        String permissionCode = customizePermission.getPermissionCode();
        cache.put(permissionCode, customizePermission);
        return Result.ok();
    }

    /**
     * 删除数据权限通过IDs
     *
     * @param ids ids
     * @return {@link Result}<{@link Boolean}>
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result<Boolean> removeRowPermissionByIds(List<Long> ids) {
        Cache cache = cacheManager.getCache(ROW_PERMISSION);
        List<SysRoleRowPermission> rolePermissionList = this.sysRoleRowPermissionService.list(Wrappers.<SysRoleRowPermission>lambdaQuery().in(SysRoleRowPermission::getPermissionId, ids));
        if (CollectionUtil.isNotEmpty(rolePermissionList)) {
            throw new BreezeBizException(ResultCode.IS_USED);
        }
        List<SysRowPermission> rowPermissionList = this.listByIds(ids);
        for (SysRowPermission rowPermission : rowPermissionList) {
            assert cache != null;
            cache.evict(rowPermission.getPermissionCode());
        }

        return Result.ok(this.removeBatchByIds(ids));
    }
}
