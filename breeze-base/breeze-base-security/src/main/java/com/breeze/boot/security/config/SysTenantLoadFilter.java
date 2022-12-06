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

package com.breeze.boot.security.config;

import com.breeze.boot.core.enums.ResultCode;
import com.breeze.boot.core.ex.SystemServiceException;
import com.breeze.boot.core.utils.BreezeThreadLocal;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

/**
 * 系统租户加载过滤器
 *
 * @author gaoweixuan
 * @date 2022-11-08
 */
public class SysTenantLoadFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String tenantId = request.getHeader("B_TENANT_ID");
        if (Objects.isNull(tenantId)) {
            throw new SystemServiceException(ResultCode.exception("缺少租户信息"));
        }
        BreezeThreadLocal.set(Long.parseLong(tenantId));
        filterChain.doFilter(request, response);
    }
}
