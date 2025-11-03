# VibeFlow

> A Complete, Zero-Cost Platform for LLM Fine-Tuning

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![Next.js](https://img.shields.io/badge/Next.js-16-black)](https://nextjs.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.109-green)](https://fastapi.tiangolo.com/)

VibeFlow is a production-grade, open-source platform for fine-tuning large language models with zero cost infrastructure. Built with Next.js, FastAPI, and real ML capabilities using Hugging Face Transformers and PEFT.

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

### 3. Setup Frontend

```bash
cd frontend
npm install
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local
npm run dev
```

### 4. Access

- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- API Docs: http://localhost:8000/docs

## Features

- **AI-Guided Workflow**: Gemini 2.5 powered assistant
- **Real ML Training**: Hugging Face Transformers + PEFT
- **Multiple Models**: Mistral-7B, Llama-2, Falcon, Phi-3, Gemma
- **Zero Cost**: Runs on free tiers
- **Production Ready**: Complete API, auth, database

## Documentation

- [Deployment Guide](./DEPLOYMENT_GUIDE.md)
- [User Guide](./USER_GUIDE.md)
- [Project Summary](./PROJECT_SUMMARY.md)

## License

MIT License - see [LICENSE](LICENSE) file for details.