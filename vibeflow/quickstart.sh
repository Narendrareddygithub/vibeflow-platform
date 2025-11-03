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

# Setup frontend
echo "========================================="
echo "Setting up Frontend..."
echo "========================================="

cd frontend

# Install dependencies
if [ ! -d "node_modules" ]; then
    echo "Installing Node dependencies..."
    npm install
    
    echo "Installing additional packages..."
    npm install lucide-react axios react-dropzone recharts --legacy-peer-deps || {
        echo "⚠️  Warning: Some packages failed to install"
        echo "   You may need to install them manually:"
        echo "   npm install lucide-react axios react-dropzone recharts --legacy-peer-deps"
    }
fi

# Setup .env.local
if [ ! -f ".env.local" ]; then
    echo "Creating .env.local file..."
    echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local
fi

echo "✓ Frontend setup complete"
echo ""

# Return to root
cd ..

# Instructions
echo "========================================="
echo "  Setup Complete!"
echo "========================================="
echo ""
echo "To start VibeFlow:"
echo ""
echo "1. Start the Backend (Terminal 1):"
echo "   cd backend"
echo "   source venv/bin/activate"
echo "   python main.py"
echo ""
echo "2. Start the Frontend (Terminal 2):"
echo "   cd frontend"
echo "   npm run dev"
echo ""
echo "3. Access the Application:"
echo "   Frontend:  http://localhost:3000"
echo "   Backend:   http://localhost:8000"
echo "   API Docs:  http://localhost:8000/docs"
echo ""
echo "Quick Test:"
echo "   curl http://localhost:8000/health"
echo ""
echo "Documentation:"
echo "   - Quick Start: README.md"
echo "   - Deployment: DEPLOYMENT_GUIDE.md"
echo "   - User Guide: USER_GUIDE.md"
echo ""

# Ask if user wants to start now
read -p "Start backend now? (y/n): " START_NOW

if [ "$START_NOW" = "y" ] || [ "$START_NOW" = "Y" ]; then
    echo ""
    echo "Starting backend..."
    echo "Frontend will need to be started in another terminal"
    echo ""
    cd backend
    source venv/bin/activate
    python main.py
fi