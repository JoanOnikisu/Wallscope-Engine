@echo off
title Onyx-Wallscape-Engine
echo [SYSTEM] Launching Wallscape Engine Protocol...
echo.

:: Execute PowerShell script with security bypass
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0WallscapeEngine.ps1"

echo.
echo [SYSTEM] Operation completed.
pause