#!/bin/bash

# ===============================================
# 脚本名称: lamp_setup.sh
# 描述    : CentOS 7/8 一键安装LAMP基础环境 (Apache, PHP, MariaDB)
# 作者    : 陈瑶
# 项目来源: 麒麟企业级应用集群项目
# ===============================================

# 检查是否为Root用户
if [ "$(id -u)" != "0" ]; then
   echo "错误: 此脚本必须使用root权限运行。" 1>&2
   exit 1
fi

# 定义颜色输出（让日志更清晰）
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}[INFO] 开始安装LAMP环境...${NC}"

# 1. 安装Apache (httpd)
echo -e "${GREEN}[INFO] 安装Apache...${NC}"
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# 2. 安装PHP及其常用扩展
echo -e "${GREEN}[INFO] 安装PHP...${NC}"
yum install -y php php-mysqlnd php-gd php-xml php-mbstring

# 3. 安装MariaDB 
echo -e "${GREEN}[INFO] 安装MariaDB...${NC}"
yum install -y mariadb-server mariadb
systemctl start mariadb
systemctl enable mariadb

# 4. 执行MySQL安全初始化
# 在生产环境中，mysql_secure_installation需要交互式操作，这里仅作展示
echo -e "${GREEN}[INFO] 建议手动运行 'mysql_secure_installation' 命令来加固数据库。${NC}"

# 5. 配置防火墙
echo -e "${GREEN}[INFO] 配置防火墙...${NC}"
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# 6. 创建测试页面
echo "<?php phpinfo(); ?>" > /var/www/html/test.php

# 重启Apache使PHP生效
systemctl restart httpd

echo -e "${GREEN}[INFO] LAMP环境安装完成！${NC}"
echo -e "${GREEN}[INFO] 你可以通过 http://IP/test.php 测试PHP。${NC}"
