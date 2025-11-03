# VibeFlow - Complete Setup and Deployment Guide

## Overview

VibeFlow is a production-grade, zero-cost platform for fine-tuning large language models. This guide provides complete instructions for setting up, developing, and deploying the platform.

## Prerequisites

### Required Software

- **Python 3.9+** (3.10 recommended)
- **Node.js 20.9.0+** (LTS recommended)
- **npm or yarn**
- **Git**
- **CUDA** (optional, for local training with GPU)

### System Requirements

- **Minimum**: 8GB RAM, 20GB disk space
- **Recommended**: 16GB RAM, 50GB disk space
- **For Training**: GPU with 8GB+ VRAM (or use Google Colab)

## Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/Narendrareddygithub/vibeflow-platform.git
cd vibeflow
```

### 2. Setup Backend

```bash
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
# Edit .env and add your GEMINI_API_KEY
python main.py
```

Backend runs at `http://localhost:8000`

### 3. Setup Frontend

```bash
cd frontend
npm install
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local
npm run dev
```

Frontend runs at `http://localhost:3000`

### 4. Get Gemini API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Click "Create API Key"
3. Copy the key and add to backend `.env` as `GEMINI_API_KEY`

## Testing

### Backend Test
```bash
curl http://localhost:8000/health
```

### API Documentation
Visit http://localhost:8000/docs for interactive API docs

## Deployment

### Option 1: Railway + Vercel (Recommended)

**Backend to Railway:**
```bash
cd backend
railway init
railway up
```

**Frontend to Vercel:**
```bash
cd frontend
vercel
```

### Option 2: Docker

```bash
docker-compose up
```

## Troubleshooting

### Common Issues

**"Gemini API Key not configured"**
- Set `GEMINI_API_KEY` in backend `.env`
- Get free key at https://makersuite.google.com/app/apikey

**"CUDA out of memory"**
- Enable 4-bit quantization
- Reduce batch size
- Try smaller model (Gemma-2B, Phi-3-Mini)
- Use gradient accumulation

### Getting Help

- API Documentation: http://localhost:8000/docs
- Check logs in console output
- Ensure all prerequisites are installed

## License

MIT License - See LICENSE file for details