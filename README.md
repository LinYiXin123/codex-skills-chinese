# codex-skills-chinese

自动将 Codex 技能列表中文化，并为每个技能文件夹生成 `技能作用.txt`。

这个项目适合：

- 想把 Codex 技能列表改成中文的人
- 想让每个技能文件夹自动生成中文用途说明的人
- 想让新增技能在重启后也继续自动中文化的人

## 功能

- 自动扫描 `~/.codex/skills` 和 `~/.codex/plugins`
- 自动把技能显示名改成中文
- 自动把技能短描述改成中文
- 自动在每个技能文件夹里生成 `技能作用.txt`
- 自动缓存翻译结果，避免重复翻译
- 支持自定义中文覆盖规则
- 支持 Windows 登录后自动后台运行

## 环境要求

- Windows
- 已安装 Python
- 已安装并正在使用 Codex

## 安装方法

### 方法 1：推荐

1. 下载本仓库压缩包，或使用 `git clone`
2. 右键用 PowerShell 打开本项目目录
3. 运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

安装完成后会：

- 把脚本复制到你的 `C:\Users\你的用户名\.codex\tools\skill-chinese`
- 自动执行一次同步
- 自动注册 Windows 登录后的后台启动

## 手动立即同步

安装后，你可以双击：

`C:\Users\你的用户名\.codex\tools\skill-chinese\立即同步技能中文.cmd`

也可以在项目目录运行：

```powershell
python .\sync_skill_chinese.py --once --verbose
```

## 自定义中文名称

可以编辑：

`skill_chinese_overrides.json`

例如：

```json
{
  "skills": {
    "browser": {
      "display_name": "浏览器控制",
      "short_description": "控制 Codex 内置浏览器并测试页面"
    }
  }
}
```

修改后再次运行同步即可生效。

## 文件说明

- `sync_skill_chinese.py`：主同步脚本
- `install.ps1`：一键安装到用户 `.codex` 目录
- `install_skill_chinese_autorun.ps1`：配置自动后台运行
- `skill_chinese_overrides.json`：中文覆盖规则
- `立即同步技能中文.cmd`：手动立即同步入口

## 说明

- 本项目默认优先使用你自定义的中文规则
- 没有规则时，会优先复用已缓存的中文结果
- 再没有时，才会使用自动翻译作为兜底

## License

MIT

## English Summary

Automatically localize Codex skills into Chinese and generate a `技能作用.txt` note inside each skill folder.
