@echo off
setlocal

echo.
echo  === Pushing updates to GitHub Pages ===
echo.

cd /d "%~dp0"

:: Init git if needed
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo  First run — initializing repo...
    git init
    git checkout -b main
    git remote add origin https://github.com/am-sys-io/profile.git
)

:: Pull latest first to avoid conflicts
git pull --rebase origin main

:: Stage everything
git add -A

:: Check for changes
git diff --cached --quiet
if not errorlevel 1 (
    echo  No changes to push.
    goto :end
)

:: Commit with timestamp
git commit -m "Update %date% %time%"

:: Push
git push origin main

echo.
echo  Done! https://am-sys-io.github.io/profile/

:end
echo.
pause
