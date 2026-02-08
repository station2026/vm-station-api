# VM Station Connect

自动化 SSH 连接管理工具，通过 ngrok 建立远程 SSH 访问隧道。

## 功能特性

- 🚀 自动启动和管理 ngrok TCP 隧道
- 📝 自动记录连接信息到日志文件
- 🔄 支持 Git 自动提交和推送连接信息
- 🪟 跨平台支持（Linux Shell 脚本 + Windows Batch 脚本）

## 文件说明

- **connect.sh** - Linux/Unix 主启动脚本
  - 停止旧的 ngrok 进程
  - 启动新的 ngrok TCP 隧道（SSH 端口 22）
  - 获取公共访问 URL
  - 保存连接信息到日志文件
  - 自动 Git 提交和推送

- **update.bat** - Windows 更新脚本
  - 从日志文件读取最新连接信息
  - 自动更新 SSH 配置文件
  - 解析 ngrok URL 并配置主机和端口

- **connected_info.log** - 当前连接信息
  - 存储 ngrok 生成的公共 TCP URL

- **connecting_details.log** - 连接详细日志
  - ngrok 启动和运行的详细输出

## 使用方法

### Linux/Unix 系统

```bash
# 启动 ngrok 隧道并推送连接信息
./connect.sh
```

### Windows 系统

```batch
# 更新本地 SSH 配置
update.bat
```

连接信息会保存在 `connected_info.log` 中，格式如：
```
tcp://6.tcp.eu.ngrok.io:13951
```

## 前置要求

- ngrok 已安装并配置 authtoken
- Git 已安装并配置用户信息
- jq（JSON 解析工具，Linux 系统需要）
- SSH 客户端

## 工作流程

1. **Linux 端（服务器）**：
   - 运行 `connect.sh`
   - ngrok 创建 SSH 隧道
   - 连接信息自动提交到 Git 仓库

2. **Windows 端（客户端）**：
   - 运行 `update.bat`
   - 从 Git 拉取最新连接信息
   - 自动更新 `~/.ssh/config`
   - 使用 `ssh vm-station` 即可连接

## SSH 配置示例

脚本会自动在 SSH 配置中创建类似以下的条目：

```
Host vm-station
    HostName 6.tcp.eu.ngrok.io
    User holi
    Port 13951
```

## 注意事项

- ngrok 免费版隧道 URL 会在每次重启时变化
- 确保 Git 仓库有适当的访问权限
- Windows 脚本需要在具有管理员权限的环境中运行
- 连接信息会自动推送到远程仓库，请注意安全

## 仓库信息

- **远程仓库**: git@github.com:station2026/vm-station-connect.git
- **用户**: station
- **邮箱**: mumadofihi69963@google.com

## License

MIT License
