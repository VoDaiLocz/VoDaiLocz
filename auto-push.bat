@echo off
setlocal enabledelayedexpansion

echo [INFO] Auto-pushing to GitHub Profile Repository...
echo.
echo [INFO] Waiting for repository VoDaiLocz/VoDaiLocz to be ready...
echo.

set /a attempt=0
if defined MAX_ATTEMPTS (
    set /a max_attempts=%MAX_ATTEMPTS%
) else (
    set /a max_attempts=30
)

if defined RETRY_DELAY (
    set /a retry_delay=%RETRY_DELAY%
) else (
    set /a retry_delay=10
)

:retry
set /a attempt+=1
echo [Attempt !attempt!/!max_attempts!] Syncing with origin/main...
git pull --rebase origin main
if not %errorlevel% == 0 (
    echo [ERROR] Could not sync with remote yet.
    goto wait_or_exit
)

echo [INFO] Trying to push... (Press Ctrl+C to stop)
git push -u origin main
if %errorlevel% == 0 (
    echo.
    echo [OK] SUCCESS! Your GitHub profile has been updated.
    echo Visit: https://github.com/VoDaiLocz/VoDaiLocz
    echo.
    pause
    exit /b 0
) else (
    echo [ERROR] Push failed.
    goto wait_or_exit
)

:wait_or_exit
if !attempt! geq !max_attempts! (
    echo.
    echo [ERROR] Auto-push stopped after !max_attempts! attempts.
    echo Please check:
    echo 1. Remote repository exists and URL is correct
    echo 2. You have push permissions
    echo 3. Local branch can rebase cleanly
    echo.
    pause
    exit /b 1
)

echo [INFO] Retrying in !retry_delay! seconds...
timeout /t !retry_delay! /nobreak >nul
goto retry
