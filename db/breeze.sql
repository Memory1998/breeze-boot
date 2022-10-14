/*
 Navicat Premium Data Transfer

 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Schema         : breeze

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 14/10/2022 10:14:13
*/

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `dept_name`   varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门名称',
    `parent_id`   bigint(22) NULL DEFAULT 0 COMMENT '上级部门ID',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1565314987957145601 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept`
VALUES (2, '二级', 1565314987957145600, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (3, '三级', 2, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (4, '四级', 3, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (5, '六级', 4, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (6, '六级', 4, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (7, '六级', 4, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (8, '六级', 4, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (9, '六级', 4, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (10, '六级', 4, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);
INSERT INTO `sys_dept`
VALUES (1565314987957145600, 'CTO/CEO', 0, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:19', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `dict_name`   varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典名称',
    `dict_code`   varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '字典编码',
    `is_open`     tinyint(1) NULL DEFAULT 0 COMMENT '是否启用 0-关闭 1-启用',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1565595193934598146 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict`
VALUES (1, '1123', '01123', 1, NULL, NULL, '2022-08-19 20:28:49', NULL, NULL, '2022-09-25 07:38:30', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `dict_id`     bigint(22) NULL DEFAULT NULL COMMENT '字典ID',
    `value`       varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '字典项的值',
    `label`       varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典项的名称',
    `sort`        tinyint(1) NULL DEFAULT NULL COMMENT '排序',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1566968028544348162 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item`
VALUES (1565616035716284417, 2, '13', '11', NULL, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:38:35', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`
(
    `id`            bigint(22) NOT NULL AUTO_INCREMENT,
    `old_file_name` bigint(128) NULL DEFAULT NULL COMMENT '原文件名称',
    `new_file_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新文件名字',
    `use_id`        bigint(22) NULL DEFAULT NULL COMMENT '用户ID',
    `user_code`     varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户编码',
    `username`      varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
    `url`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'url',
    `create_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time`   datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
    `update_time`   datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`     tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`     bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`
(
    `id`            bigint(22) NOT NULL AUTO_INCREMENT,
    `system_module` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统模块',
    `log_title`     varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志标题',
    `log_type`      tinyint(1) NULL DEFAULT 0 COMMENT '日志类型 0 普通日志 1 登录日志',
    `request_type`  tinyint(1) NULL DEFAULT NULL COMMENT '请求类型 0 GET 1 POST 2 PUT 3 DELETE ',
    `ip`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
    `do_type`       tinyint(1) NULL DEFAULT 3 COMMENT '操作类型 0 添加 1 删除 2 修改 3 查询',
    `browser`       varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器名称',
    `system`        varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统类型',
    `result`        tinyint(1) NULL DEFAULT 0 COMMENT '结果 0 失败 1 成功',
    `create_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time`   datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time`   datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`     tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`     bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `platform_id` bigint(22) NULL DEFAULT NULL COMMENT '平台ID',
    `parent_id`   bigint(22) NULL DEFAULT 0 COMMENT '上一级的菜单ID',
    `title`       varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
    `name`        varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件名称',
    `type`        tinyint(1) NULL DEFAULT 0 COMMENT '类型 0 文件夹 1 菜单 2 按钮',
    `icon`        varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
    `path`        varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单路径',
    `component`   varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
    `permission`  varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
    `sort`        int(11) NULL DEFAULT NULL COMMENT '顺序',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1580362363688144899 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu`
VALUES (1578702340612325378, 1564528653105573889, 1578702340666851329, '日志管理', 'log', 1, 'el-icon-user-solid', '/log',
        '/system/log/LogView', 'sys:log:list', 8, NULL, NULL, '2022-08-18 17:00:15', NULL, '0', '2022-10-14 09:26:01',
        0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340620713986, 1564528653105573889, 1580357263003439106, '设计器', 'designer', 1, 'el-icon-user-solid',
        '/designer', '/system/designer/DesignerView', 'flow:dsigner:list', 4, NULL, NULL, '2022-08-17 22:38:55',
        'admin', 'admin', '2022-10-14 09:26:54', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340620713987, 1564528653105573889, 1578702340683628545, '修改', NULL, 2, NULL, NULL, NULL,
        'sys:user:update', 11, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340620713988, 1564528653105573889, 1578702340683628545, '删除', NULL, 2, NULL, NULL, NULL,
        'sys:user:delete', 12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340624908290, 1564528653105573889, 1578702340683628545, '添加', NULL, 2, NULL, NULL, NULL, 'sys:user:save',
        12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340624908291, 1564528653105573889, 1578702340683628546, '修改', NULL, 2, NULL, NULL, NULL,
        'sys:menu:update', 11, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340624908292, 1564528653105573889, 1578702340683628546, '删除', NULL, 2, NULL, NULL, NULL,
        'sys:menu:delete', 12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340624908293, 1564528653105573889, 1578702340683628546, '添加', NULL, 2, NULL, NULL, NULL, 'sys:menu:save',
        12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340633296898, 1564528653105573889, 1578702340662657026, '删除', NULL, 2, NULL, NULL, NULL,
        'sys:dept:delete', 12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340633296899, 1564528653105573889, 1578702340662657026, '添加', NULL, 2, NULL, NULL, NULL, 'sys:dept:save',
        12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:15', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340641685505, 1564528653105573889, 1578702340654268418, '修改', '2', 2, NULL, NULL, NULL,
        'sys:role:update', 11, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:02', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340641685506, 1564528653105573889, 1578702340654268418, '删除', NULL, 2, NULL, NULL, NULL,
        'sys:role:delete', 12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340650074114, 1564528653105573889, 1578702340654268418, '添加', NULL, 2, NULL, NULL, NULL, 'sys:role:save',
        12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340650074115, 1564528653105573889, 1578702340662657027, '修改', NULL, 2, NULL, NULL, NULL,
        'sys:dict:update', 11, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340650074116, 1564528653105573889, 1578702340662657027, '删除', NULL, 2, NULL, NULL, NULL,
        'sys:dict:delete', 12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340650074117, 1564528653105573889, 1578702340662657027, '添加', NULL, 2, NULL, NULL, NULL, 'sys:dict:save',
        12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340654268417, 1564528653105573889, 1578702340612325378, '删除', NULL, 2, NULL, NULL, NULL,
        'sys:log:delete', 12, NULL, NULL, '2022-08-18 23:37:01', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340654268418, 1564528653105573889, 1578702340666851329, '角色管理', 'role', 1, 'el-icon-user-solid', '/role',
        '/system/role/RoleView', 'sys:role:list', 5, NULL, NULL, '2022-08-17 22:38:55', NULL, '0',
        '2022-10-14 09:26:54', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340662657026, 1564528653105573889, 1578702340666851329, '部门管理', 'dept', 1, 'el-icon-user-solid', '/dept',
        '/system/dept/DeptView', 'sys:dept:list', 6, NULL, NULL, '2022-08-17 22:38:55', NULL, '0',
        '2022-10-14 09:26:54', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340662657027, 1564528653105573889, 1578702340666851329, '字典管理', 'dict', 1, 'el-icon-user-solid', '/dict',
        '/system/dict/DictView', 'sys:dict:list', 7, NULL, NULL, '2022-08-18 16:58:15', NULL, '0',
        '2022-10-14 09:26:54', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340666851329, 1564528653105573889, 0, '系统设置', '', 0, 'el-icon-s-tools', '/system', '', '', 1, NULL, NULL,
        '2022-01-28 02:49:34', NULL, '0', '2022-10-14 09:25:26', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340671045634, 1564528653105573889, 1578702340666851329, '平台管理', 'platform', 1, 'el-icon-s-home',
        '/platform', '/system/platform/PlatformView', 'sys:platform:list', 1, NULL, NULL, '2022-02-26 17:31:51', NULL,
        '0', '2022-10-14 09:26:54', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340671045635, 1564528653105573889, 1578702340671045634, '添加按钮', NULL, 2, NULL, NULL, NULL,
        'sys:platform:save', 11, NULL, NULL, '2022-08-18 19:47:23', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340679434241, 1564528653105573889, 1578702340671045634, '修改按钮', NULL, 2, NULL, NULL, NULL,
        'sys:platform:update', 10, NULL, NULL, '2022-08-18 19:47:23', 'admin', 'admin', '2022-10-14 09:27:16', 0, NULL,
        1);
INSERT INTO `sys_menu`
VALUES (1578702340679434243, 1564528653105573889, 1578702340671045634, '删除按钮', NULL, 2, NULL, NULL, NULL,
        'sys:platform:delete', 9, NULL, NULL, '2022-08-18 18:57:09', NULL, '0', '2022-10-14 09:27:16', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340683628545, 1564528653105573889, 1578702340666851329, '用户管理', 'user', 1, 'el-icon-user-solid', '/user',
        '/system/user/UserView', 'sys:user:list', 2, NULL, NULL, '2022-02-27 00:06:55', NULL, '0',
        '2022-10-14 09:26:54', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1578702340683628546, 1564528653105573889, 1578702340666851329, '菜单管理', 'menu', 1, 'el-icon-s-order', '/menu',
        '/system/menu/MenuView', 'sys:menu:list', 3, NULL, NULL, '2022-02-27 00:08:30', NULL, '0',
        '2022-10-14 09:26:54', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1580357263003439106, 1564528653105573889, 0, '工作流', NULL, 0, 'el-icon-s-tools', '/flow', NULL, NULL, 1, 'admin',
        'admin', '2022-10-13 08:38:28', 'admin', 'admin', '2022-10-14 09:30:34', 0, NULL, 1);
INSERT INTO `sys_menu`
VALUES (1580357773622202370, 1564528653105573889, 1580357263003439106, '流程分类', 'type', 1, 'el-icon-s-tools', '/type',
        '/flow/type/TypeView', 'flow:type:list', 1, 'admin', 'admin', '2022-10-13 08:40:30', 'admin', 'admin',
        '2022-10-14 09:31:18', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_platform
-- ----------------------------
DROP TABLE IF EXISTS `sys_platform`;
CREATE TABLE `sys_platform`
(
    `id`            bigint(22) NOT NULL,
    `platform_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台名称',
    `platform_code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台编码',
    `description`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
    `create_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time`   datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time`   datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`     int(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`     bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平台' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_platform
-- ----------------------------
INSERT INTO `sys_platform`
VALUES (1564528653105573889, '后台管理中心', 'managementCenter', '后台管理中心', NULL, 'admin', '2022-02-27 00:04:17', NULL, '0',
        '2022-09-25 07:39:01', 0, NULL, 1);
INSERT INTO `sys_platform`
VALUES (1580099387022348289, '微信小程序', 'mini', NULL, 'admin', 'admin', '2022-10-12 15:33:45', NULL, NULL, NULL, 0, NULL,
        1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `role_code`   varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色编码',
    `role_name`   varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1578702274250047491 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role`
VALUES (1565322827518140417, 'ROLE_ADMIN', '超级管理员', NULL, NULL, '2022-01-28 02:54:10', NULL, NULL,
        '2022-09-25 07:39:15', 0, NULL, 1);
INSERT INTO `sys_role`
VALUES (1578702274250047490, '123', '123123', NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:39:15', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `menu_id`     bigint(22) NULL DEFAULT NULL COMMENT '菜单ID',
    `role_id`     bigint(22) NULL DEFAULT NULL COMMENT '角色ID',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1578714139957030916 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu`
VALUES (1578714139738927106, 1578702340666851329, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139843784705, 1578702340671045634, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139847979009, 1578702340679434243, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139856367617, 1578702340679434241, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139860561922, 1578702340671045635, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139868950529, 1578702340683628545, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139877339137, 1578702340624908291, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139885727745, 1578702340620713987, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139885727746, 1578702340624908292, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139894116354, 1578702340620713988, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139894116355, 1578702340624908293, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139894116356, 1578702340624908290, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139902504961, 1578702340633296898, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139902504962, 1578702340633296899, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139910893570, 1578702340683628546, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139910893571, 1578702340654268418, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139919282178, 1578702340641685505, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139927670785, 1578702340641685506, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139931865089, 1578702340650074114, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139931865090, 1578702340662657026, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139940253697, 1578702340662657027, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139940253698, 1578702340650074115, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139948642306, 1578702340650074116, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139948642307, 1578702340650074117, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139957030914, 1578702340612325378, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);
INSERT INTO `sys_role_menu`
VALUES (1578714139957030915, 1578702340654268417, 1565322827518140417, NULL, NULL, '2022-09-25 07:38:56', NULL, NULL,
        '2022-09-25 07:38:56', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `name`        varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租户名称',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant`
VALUES (1, '1', NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:39:24', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `dept_id`     bigint(22) NOT NULL COMMENT '部门ID',
    `avatar`      varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
    `amount_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录账户名称',
    `user_code`   varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户编码',
    `username`    varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '用户姓名',
    `password`    varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码',
    `sex`         int(1) NULL DEFAULT NULL COMMENT '性别 0 女性 1 男性',
    `id_card`     varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
    `phone`       varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
    `open_id`     int(11) NULL DEFAULT NULL COMMENT '微信OpenID',
    `email`       varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮件',
    `is_lock`     int(1) NULL DEFAULT NULL COMMENT '锁定',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uni_user_name`(`username`, `tenant_id`) USING BTREE COMMENT '同一个租户下，用户名唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1580050739311898627 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user`
VALUES (1, 1565314987957145600, NULL, '超级管理员', 'admin', 'admin',
        '$2a$10$0oaHJPN7Pqq49dUqQgUVSug5l1ELUqjvuDZ5BIJwr2PJyGqzMjIca', 0, '371521123456789', '17812345678', 123123,
        'breeze-cloud@foxmail.com', 0, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:34:54', 0, NULL, 1);
INSERT INTO `sys_user`
VALUES (2, 1565314987957145600, NULL, '普通用户', 'user', 'user',
        '$2a$10$HmLMBj1Bj29yPuf2gHzcsODyGVsg2M667g5jPrboHBeitt1kWBLjm', 1, '371521123456789', '17812345678', NULL,
        'cloud@foxmail.com', 0, NULL, NULL, '2022-08-18 23:27:32', NULL, NULL, '2022-09-25 09:48:37', 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`
(
    `id`          bigint(22) NOT NULL AUTO_INCREMENT,
    `user_id`     bigint(22) NULL DEFAULT NULL COMMENT '用户ID',
    `role_id`     bigint(22) NULL DEFAULT NULL COMMENT '角色ID',
    `create_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
    `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`   tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`   bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role`
VALUES (1, 1, 1565322827518140417, NULL, NULL, NULL, NULL, NULL, '2022-09-25 07:39:24', 0, NULL, 1);

SET
FOREIGN_KEY_CHECKS = 1;