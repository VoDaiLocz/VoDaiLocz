@echo off
setlocal enabledelayedexpansion

echo [INFO] Pushing to GitHub Profile Repository...
echo.

git status
echo.

echo [INFO] Adding all files...
git add .

echo.
git diff --cached --quiet
if %errorlevel% == 0 (
    echo [INFO] No local changes to commit.
) else (
    echo [INFO] Committing changes...
    git commit -m "Update GitHub profile with dynamic effects"
    if not %errorlevel% == 0 (
        echo.
        echo [ERROR] Commit failed. Resolve the issue and try again.
        echo.
        pause
        exit /b 1
    )
)

echo.
echo [INFO] Syncing with remote branch (rebase)...
git pull --rebase origin main
if not %errorlevel% == 0 (
    echo.
    echo [ERROR] Rebase failed. Resolve conflicts then run again.
    echo Tip: git rebase --continue OR git rebase --abort
    echo.
    pause
    exit /b 1
)

echo.
echo [INFO] Pushing to GitHub...
git push -u origin main

if %errorlevel% == 0 (
    echo.
    echo [OK] SUCCESS! Your GitHub profile has been updated.
    echo Visit: https://github.com/VoDaiLocz
    echo.
) else (
    echo.
    echo [ERROR] Push failed. Please check:
    echo 1. Repository 'VoDaiLocz' exists on GitHub
    echo 2. You have push permissions
    echo 3. Internet connection is stable
    echo.
)

pause
endlocal
