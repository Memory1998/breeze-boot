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

package com.breeze.security.auth;

import com.breeze.security.params.AuthLoginParam;
import com.breeze.security.service.LocalUserDetailsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Objects;

/**
 * auth gitee / github 等身份验证提供者
 * <p>
 * 参考：
 * {@link  org.springframework.security.authentication.dao.DaoAuthenticationProvider}
 *
 * @author gaoweixuan
 * @date 2022-11-09
 */
@Slf4j
public class AuthAuthenticationProvider implements AuthenticationProvider {

    /**
     * 创建失败
     */
    private static final String CREATE_FAIL = "三方登录失败";

    /**
     * 用户详细信息服务
     */
    private final LocalUserDetailsService userDetailsService;

    public AuthAuthenticationProvider(LocalUserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    /**
     * 进行身份验证
     *
     * @param authentication 身份验证
     * @return {@link Authentication}
     * @throws AuthenticationException 身份验证异常
     */
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        AuthAuthenticationToken authenticationToken = (AuthAuthenticationToken) authentication;
        AuthLoginParam authLoginParam = (AuthLoginParam) authenticationToken.getPrincipal();
        UserDetails userDetails = this.userDetailsService.createOrLoadUser(authLoginParam);
        if (Objects.isNull(userDetails)) {
            throw new InternalAuthenticationServiceException(CREATE_FAIL);
        }
        AuthAuthenticationToken authAuthenticationToken = new AuthAuthenticationToken(userDetails, "" , userDetails.getAuthorities());
        authAuthenticationToken.setDetails(userDetails);
        return authAuthenticationToken;
    }

    /**
     * 支持
     * <p>
     * 此方法标识可以使用传入的当前的PROVIDER可以作为验证
     *
     * @param authentication 身份验证
     * @return boolean
     */
    @Override
    public boolean supports(Class<?> authentication) {
        return AuthAuthenticationToken.class.isAssignableFrom(authentication);
    }

}