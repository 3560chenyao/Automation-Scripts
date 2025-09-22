#!/bin/bash

# ===============================================
# 脚本名称: dameng_backup.sh
# 描述    : 达梦数据库(DM8)自动逻辑备份脚本
# 作者    : 陈瑶
# 项目来源: 市监局信创项目实训
# ===============================================

# 1. 定义变量（根据实际部署修改）
DB_USER="SYSDBA"
DB_PASSWORD="YourPassword123" # 注意：真实环境中应使用密码管理器或配置文件，不要硬编码！
DB_HOST="localhost"
DB_PORT="5236"
DB_NAME="DAMENG"

# 备份目录（确保此目录存在且有写权限）
BACKUP_DIR="/data/dmdata/dmbak"
# 备份文件保留天数
DAYS_TO_KEEP=14

# 2. 生成备份文件名（含日期）
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/logic_backup_${DB_NAME}_${DATE}.dmp"
LOG_FILE="${BACKUP_DIR}/backup_log_${DATE}.txt"

# 3. 开始备份
echo "$(date): 开始执行达梦数据库逻辑备份..." | tee -a $LOG_FILE

# 使用达梦的 dexp 工具进行逻辑备份
# 注意：需要提前配置好达梦的环境变量，或者使用绝对路径
dexp USERID=${DB_USER}/${DB_PASSWORD}@${DB_HOST}:${DB_PORT} FILE=${BACKUP_FILE} LOG=${BACKUP_DIR}/dexp_${DATE}.log FULL=Y

# 4. 检查备份是否成功
if [ $? -eq 0 ]; then
    echo "$(date): 数据库备份成功！备份文件: $BACKUP_FILE" | tee -a $LOG_FILE
else
    echo "$(date): [错误] 数据库备份失败！请检查日志。" | tee -a $LOG_FILE
    exit 1
fi

# 5. 清理过期备份文件（可选，但很重要）
echo "$(date): 开始清理 ${DAYS_TO_KEEP} 天前的备份文件..." | tee -a $LOG_FILE
find $BACKUP_DIR -name "logic_backup_${DB_NAME}_*.dmp" -mtime +$DAYS_TO_KEEP -delete
find $BACKUP_DIR -name "backup_log_*.txt" -mtime +$DAYS_TO_KEEP -delete
find $BACKUP_DIR -name "dexp_*.log" -mtime +$DAYS_TO_KEEP -delete

echo "$(date): 备份及清理任务全部完成。" | tee -a $LOG_FILE
