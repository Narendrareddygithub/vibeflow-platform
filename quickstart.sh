#!/bin/bash

# VibeFlow Quick Start Script
# This script helps you get VibeFlow running quickly

set -e

echo "========================================="
echo "  VibeFlow - LLM Fine-Tuning Platform  "
echo "========================================="
echo ""

# Check if running from correct directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "Error: Please run this script from the vibeflow root directory"
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "Checking prerequisites..."

if ! command_exists python3; then
    echo "Error: Python 3 is not installed"
    exit 1
fi

if ! command_exists node; then
    echo "Error: Node.js is not installed"
    exit 1
fi

if ! command_exists npm; then
    echo "Error: npm is not installed"
    exit 1
fi

echo "✓ All prerequisites found"
echo ""

# Setup backend
echo "========================================="
echo "Setting up Backend..."
echo "========================================="

cd backend

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "Installing Python dependencies..."
pip install -q --upgrade pip
pip install -q -r requirements.txt

# Setup .env file
if [ ! -f ".env" ]; then
    echo "Creating .env file..."
    cp .env.example .env
    echo ""
    echo "========================================="
    echo "⚠️  IMPORTANT: Gemini API Key Required"
    echo "========================================="
    echo ""
    echo "To use the AI agent features, you need a Gemini API key."
    echo ""
    echo "Steps to get your free API key:"
    echo "1. Visit: https://makersuite.google.com/app/apikey"
    echo "2. Sign in with your Google account"
    echo "3. Click 'Create API Key'"
    echo "4. Copy the key"
    echo ""
    read -p "Enter your Gemini API key (or press Enter to skip): " GEMINI_KEY
    
    if [ ! -z "$GEMINI_KEY" ]; then
        # Update .env file with API key
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "s/GEMINI_API_KEY=.*/GEMINI_API_KEY=$GEMINI_KEY/" .env
        else
            # Linux
            sed -i "s/GEMINI_API_KEY=.*/GEMINI_API_KEY=$GEMINI_KEY/" .env
        fi
        echo "✓ Gemini API key configured"
    else
        echo "⚠️  Skipped: AI agent features will not work without API key"
        echo "   You can add it later by editing backend/.env"
    fi
fi

echo "✓ Backend setup complete"
echo ""

# Return to root
cd ..

echo "========================================="
echo "  Setup Complete!"
echo "========================================="
echo ""
echo "To start VibeFlow:"
echo ""
echo "1. Start the Backend:"
echo "   cd backend"
echo "   source venv/bin/activate"
echo "   python main.py"
echo ""
echo "2. Start the Frontend (separate terminal):"
echo "   cd frontend"
echo "   npm run dev"
echo ""
echo "3. Access the Application:"
echo "   Frontend:  http://localhost:3000"
echo "   Backend:   http://localhost:8000"
echo "   API Docs:  http://localhost:8000/docs"
echo ""