@echo off
REM VibeFlow Quick Start Script for Windows
REM This script helps you get VibeFlow running quickly on Windows

echo =========================================
echo   VibeFlow - LLM Fine-Tuning Platform
echo =========================================
echo.

REM Check if running from correct directory
if not exist "backend" (
    echo Error: backend directory not found
    echo Please run this script from the vibeflow root directory
    exit /b 1
)

if not exist "frontend" (
    echo Error: frontend directory not found
    echo Please run this script from the vibeflow root directory
    exit /b 1
)

echo Checking prerequisites...

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH
    exit /b 1
)

REM Check Node
node --version >nul 2>&1
if errorlevel 1 (
    echo Error: Node.js is not installed or not in PATH
    exit /b 1
)

REM Check npm
npm --version >nul 2>&1
if errorlevel 1 (
    echo Error: npm is not installed or not in PATH
    exit /b 1
)

echo OK All prerequisites found
echo.

REM Setup backend
echo =========================================
echo Setting up Backend...
echo =========================================

cd backend

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating Python virtual environment...
    python -m venv venv
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Install dependencies
echo Installing Python dependencies...
python -m pip install --quiet --upgrade pip
python -m pip install --quiet -r requirements.txt

REM Setup .env file
if not exist ".env" (
    echo Creating .env file...
    copy .env.example .env
    echo.
    echo =========================================
    echo    IMPORTANT: Gemini API Key Required
    echo =========================================
    echo.
    echo To use the AI agent features, you need a Gemini API key.
    echo.
    echo Steps to get your free API key:
    echo 1. Visit: https://makersuite.google.com/app/apikey
    echo 2. Sign in with your Google account
    echo 3. Click 'Create API Key'
    echo 4. Copy the key
    echo.
    set /p GEMINI_KEY="Enter your Gemini API key (or press Enter to skip): "
    
    if not "!GEMINI_KEY!"=="" (
        powershell -Command "(gc .env) -replace 'GEMINI_API_KEY=.*', 'GEMINI_API_KEY=!GEMINI_KEY!' | Out-File -encoding ASCII .env"
        echo OK Gemini API key configured
    ) else (
        echo WARNING: AI agent features will not work without API key
        echo    You can add it later by editing backend\.env
    )
)

echo OK Backend setup complete
echo.

REM Return to root
cd ..

REM Instructions
echo =========================================
echo   Setup Complete!
echo =========================================
echo.
echo To start VibeFlow:
echo.
echo 1. Start the Backend:
echo    cd backend
echo    venv\Scripts\activate.bat
echo    python main.py
echo.
echo 2. Start the Frontend (separate terminal):
echo    cd frontend
echo    npm run dev
echo.
echo 3. Access the Application:
echo    Frontend:  http://localhost:3000
echo    Backend:   http://localhost:8000
echo    API Docs:  http://localhost:8000/docs
echo.

echo Quick Test:
echo    curl http://localhost:8000/health
echo.

echo Documentation:
echo    - Quick Start: README.md
echo    - Deployment: DEPLOYMENT_GUIDE.md
echo    - User Guide: USER_GUIDE.md
echo.

set /p START_NOW="Start backend now? (y/n): "

if /i "%START_NOW%"=="y" (
    echo.
    echo Starting backend...
    echo Frontend will need to be started in another terminal
    echo.
    cd backend
    call venv\Scripts\activate.bat
    python main.py
)