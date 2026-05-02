@echo off
chcp 65001 >nul
cd /d "%~dp0"
python "%~dp0sync_skill_chinese.py" --once --verbose
echo.
echo 已完成同步，按任意键关闭...
pause >nul
