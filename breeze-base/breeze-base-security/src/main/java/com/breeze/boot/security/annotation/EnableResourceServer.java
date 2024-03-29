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

package com.breeze.boot.security.annotation;

import com.breeze.boot.security.config.AuthorizationServerConfiguration;
import com.breeze.boot.security.config.WebSecurityConfig;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * 开启资源服务配置
 *
 * @author gaoweixuan
 * @since 2021/10/1
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@EnableWebSecurity()
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Import({WebSecurityConfig.class, AuthorizationServerConfiguration.class})
public @interface EnableResourceServer {
}
