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

package com.breeze.boot.websocket.events;

import com.breeze.boot.websocket.bo.UserMsgBO;
import org.springframework.context.ApplicationEvent;

/**
 * 消息保存事件
 *
 * @author gaoweixuan
 * @date 2022-11-28
 */
public class MsgSaveEvent extends ApplicationEvent {

    /**
     * 消息保存事件
     *
     * @param userMsgBO 消息BO
     */
    public MsgSaveEvent(UserMsgBO userMsgBO) {
        super(userMsgBO);
    }

}