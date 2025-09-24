# Automation Scripts for DevOps

本仓库收集了我在学习和项目实践中编写的运维自动化脚本，旨在解决重复性工作，实现运维工作的标准化和自动化。

## 🚀 快速开始

### 环境要求
- Linux 环境 (CentOS/Ubuntu/Kylin OS)
- Bash Shell
- Python 3.x (部分脚本需要)

### 脚本列表

| 脚本名称 | 语言 | 描述 | 适用场景 |
| :--- | :--- | :--- | :--- |
| [dameng_backup.sh](./dameng_backup.sh) | Shell | 达梦数据库(DM8)自动逻辑备份与清理 | 数据库运维 |
| [lamp_setup.sh](./lamp_setup.sh) | Shell | 一键自动化安装LAMP基础环境 | 系统部署 |

## 📝 使用说明

每个脚本文件都包含了详细的注释。运行前请：
1. 阅读脚本顶部的注释，修改必要的配置参数（如路径、密码）。
2. 赋予执行权限：`chmod +x script_name.sh`
3. 可考虑加入 `crontab` 实现定时任务。

## 💡 项目背景
这些脚本均来源于我的真实项目需求，例如：
- `dameng_backup.sh` 源自 **市监局信创项目** 的数据库备份需求。
- `lamp_setup.sh` 源自 **企业级集群项目** 的基础环境搭建需求。

---
