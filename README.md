# VibeFlow - Complete LLM Fine-Tuning Platform

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)
![Next.js](https://img.shields.io/badge/Next.js-16-black)
![FastAPI](https://img.shields.io/badge/FastAPI-0.109-green)

VibeFlow is a production-grade, open-source platform for fine-tuning large language models with zero cost infrastructure. Built with Next.js, FastAPI, and real ML capabilities using Hugging Face Transformers and PEFT.

## ✨ Features

### Core Capabilities

- **AI-Guided Workflow**: Gemini 2.5 powered assistant helps you through the entire fine-tuning process
- **Real ML Training**: Actual model fine-tuning with LoRA/QLoRA using Hugging Face Transformers and PEFT
- **Multiple Model Support**: Mistral-7B, Llama-2, Falcon, Phi-3, Gemma models
- **Data Management**: Support for CSV, JSON, JSONL, and Parquet formats
- **Training Monitoring**: Real-time progress tracking, logs, and metrics
- **Model Evaluation**: Comprehensive benchmarking with BLEU, ROUGE, and other metrics
- **API Deployment**: One-click deployment with API key management
- **Zero Cost**: Runs entirely on free tiers and open-source technology

## 🚀 Quick Start

### Prerequisites

- Python 3.9+ (3.10 recommended)
- Node.js 20.9.0+
- Gemini API key ([Get one free](https://makersuite.google.com/app/apikey))

### 1. Setup Backend

```bash
cd vibeflow/backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
# Edit .env and add your GEMINI_API_KEY
python main.py
```

Backend runs at `http://localhost:8000`

### 2. Setup Frontend

```bash
cd vibeflow/frontend
npm install
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local
npm run dev
```

Frontend runs at `http://localhost:3000`

### 3. Start Using

1. Open http://localhost:3000
2. Register a new account
3. Create your first project
4. Upload a dataset or chat with the AI agent
5. Start training!

## 📚 Documentation

- **[Deployment Guide](./DEPLOYMENT_GUIDE.md)**: Complete setup and deployment instructions
- **[Architecture Overview](./docs/architecture.md)**: System architecture and design
- **[API Documentation](http://localhost:8000/docs)**: Interactive API docs (when backend is running)
- **[User Guide](./USER_GUIDE.md)**: Complete user walkthrough

## 🏗️ Technology Stack

### Frontend
- **Framework**: Next.js 16 with React 19
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Icons**: Lucide React

### Backend
- **Framework**: Python FastAPI
- **Database**: SQLite (SQLAlchemy ORM)
- **Authentication**: JWT tokens
- **ML Framework**: Hugging Face Transformers
- **Fine-Tuning**: PEFT (LoRA/QLoRA)
- **Quantization**: bitsandbytes
- **AI Agent**: Google Gemini 2.5 API

### Infrastructure
- **Training**: Google Colab (free tier) or local GPU
- **Deployment**: Railway (backend), Vercel (frontend)
- **Storage**: Local filesystem / Hugging Face Hub
- **Cost**: 100% free tier compatible

## 📖 Project Structure

```
vibeflow/
├── backend/                  # FastAPI backend
│   ├── app/
│   │   ├── api/             # API routes
│   │   ├── core/            # Core functionality (auth, db, config)
│   │   ├── models/          # Data models and schemas
│   │   └── services/        # Business logic
│   ├── main.py              # Application entry point
│   ├── requirements.txt     # Python dependencies
│   └── .env.example         # Environment template
├── frontend/                 # Next.js frontend
│   ├── app/                 # Next.js app directory
│   ├── components/          # React components
│   ├── lib/                 # Utilities and API client
│   └── package.json         # Node dependencies
├── docs/                    # Documentation
│   └── architecture.md      # Architecture documentation
├── DEPLOYMENT_GUIDE.md      # Complete deployment guide
└── README.md               # This file
```

## 🔑 API Endpoints

### Authentication
```
POST /api/auth/register    # Register new user
POST /api/auth/login       # Login
POST /api/auth/refresh     # Refresh token
```

### Projects
```
GET    /api/projects       # List projects
POST   /api/projects       # Create project
GET    /api/projects/:id   # Get project
PUT    /api/projects/:id   # Update project
DELETE /api/projects/:id   # Delete project
```

### Training
```
POST /api/training/start       # Start training
GET  /api/training/:id         # Get status
POST /api/training/:id/pause   # Pause
POST /api/training/:id/resume  # Resume
POST /api/training/:id/cancel  # Cancel
```

### AI Agent
```
POST /api/agent/chat              # Chat with AI
POST /api/agent/recommendations   # Get recommendations
GET  /api/agent/status            # Check availability
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure:
- Code passes all tests
- Documentation is updated
- Code follows style guidelines
- Commits are descriptive

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Hugging Face for Transformers and PEFT libraries
- Google for Gemini API
- FastAPI team for the excellent framework
- Next.js team for the modern web framework
- Open-source ML community

---

**Built with passion for democratizing AI** ⭐

**Star this repo if you find it useful!**