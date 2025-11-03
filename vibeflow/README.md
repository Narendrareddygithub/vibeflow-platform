# VibeFlow

> A Complete, Zero-Cost Platform for LLM Fine-Tuning

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![Next.js](https://img.shields.io/badge/Next.js-16-black)](https://nextjs.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.109-green)](https://fastapi.tiangolo.com/)

VibeFlow is a production-grade, open-source platform for fine-tuning large language models with zero cost infrastructure. Built with Next.js, FastAPI, and real ML capabilities using Hugging Face Transformers and PEFT.

## Features

### Core Capabilities

- **AI-Guided Workflow**: Gemini 2.5 powered assistant helps you through the entire fine-tuning process
- **Real ML Training**: Actual model fine-tuning with LoRA/QLoRA using Hugging Face Transformers and PEFT
- **Multiple Model Support**: Mistral-7B, Llama-2, Falcon, Phi-3, Gemma models
- **Data Management**: Support for CSV, JSON, JSONL, and Parquet formats
- **Training Monitoring**: Real-time progress tracking, logs, and metrics
- **Model Evaluation**: Comprehensive benchmarking with BLEU, ROUGE, and other metrics
- **API Deployment**: One-click deployment with API key management
- **Zero Cost**: Runs entirely on free tiers and open-source technology

### User Flows

#### 1. Beginner Flow (AI-Guided)
- Describe your goal in natural language
- AI agent asks clarifying questions
- Automated model and configuration recommendations
- Guided data preparation
- Automatic training initiation
- Real-time monitoring and evaluation

#### 2. Intermediate Flow (Dataset-First)
- Upload your dataset
- AI analyzes and recommends suitable models
- Configure hyperparameters with helpful tooltips
- Train with progress monitoring
- Compare against baselines
- Export or deploy

#### 3. Advanced Flow (Full Control)
- Select specific model from catalog
- Fine-tune all hyperparameters
- Custom training configurations
- Detailed metrics and logging
- Advanced evaluation suite
- Full API deployment control

## Technology Stack

### Frontend
- **Framework**: Next.js 16 with React 19
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Icons**: Lucide React
- **Charts**: Recharts
- **HTTP Client**: Fetch API / Axios

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

## Quick Start

### Prerequisites

- Python 3.9+ (3.10 recommended)
- Node.js 20.9.0+
- Gemini API key ([Get one free](https://makersuite.google.com/app/apikey))

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/vibeflow.git
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

### 4. Start Using

1. Open http://localhost:3000
2. Register a new account
3. Create your first project
4. Upload a dataset or chat with the AI agent
5. Start training!

## Documentation

- **[Deployment Guide](./DEPLOYMENT_GUIDE.md)**: Complete setup and deployment instructions
- **[Architecture Overview](./docs/architecture.md)**: System architecture and design
- **[API Documentation](http://localhost:8000/docs)**: Interactive API docs (when backend is running)
- **[Backend README](./backend/README.md)**: Backend-specific documentation

## Project Structure

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
│   ├── package.json         # Node dependencies
│   └── .env.local.example   # Environment template
├── docs/                    # Documentation
│   └── architecture.md      # Architecture documentation
├── DEPLOYMENT_GUIDE.md      # Complete deployment guide
└── README.md               # This file
```

## Supported Models

| Model | Size | Task Types | VRAM (Quantized) |
|-------|------|------------|------------------|
| Mistral-7B | 7B | Text generation, Chat | 6GB |
| Llama-2-7B | 7B | Text generation, Chat | 6GB |
| Falcon-7B | 7B | Text generation | 6GB |
| Phi-3-Mini | 3.8B | Chat, Instruction | 4GB |
| Gemma-2B | 2B | Text generation | 3GB |
| Gemma-7B | 7B | Text generation, Chat | 6GB |

All models support efficient fine-tuning with LoRA/QLoRA.

## Dataset Requirements

### Supported Formats
- CSV
- JSON
- JSONL (recommended for large datasets)
- Parquet

### Data Structure
Your dataset should contain text data. Example formats:

**CSV/JSON:**
```csv
text,label
"This is a sample text",positive
"Another example",negative
```

**JSONL (preferred):**
```jsonl
{"text": "This is a sample text", "label": "positive"}
{"text": "Another example", "label": "negative"}
```

The system automatically detects and processes various column structures.

## Training Options

### Local Training
- Requires NVIDIA GPU with 8GB+ VRAM
- Supports CUDA-enabled PyTorch
- Automatic quantization (4-bit/8-bit)
- Resume from checkpoints

### Google Colab (Recommended)
- Free GPU access (T4 GPU)
- 12-16GB VRAM available
- Export config from VibeFlow
- Run training in Colab
- Upload results back to VibeFlow

### Hugging Face Spaces
- Deploy training as a Space
- Use GPU-enabled Spaces (paid)
- Automated training pipelines

## API Endpoints

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

### Datasets
```
POST   /api/datasets/upload        # Upload dataset
GET    /api/datasets/:id           # Get dataset info
GET    /api/datasets/:id/preview   # Preview data
POST   /api/datasets/:id/process   # Preprocess
DELETE /api/datasets/:id           # Delete dataset
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

## Configuration

### Training Hyperparameters

```python
{
  "learning_rate": 2e-4,        # Learning rate
  "num_epochs": 3,              # Number of epochs
  "batch_size": 4,              # Batch size
  "max_length": 512,            # Max sequence length
  "lora_r": 8,                  # LoRA rank
  "lora_alpha": 32,             # LoRA alpha
  "lora_dropout": 0.1,          # LoRA dropout
  "use_quantization": true,     # Enable quantization
  "quantization_type": "4bit",  # 4bit or 8bit
  "gradient_accumulation_steps": 4,
  "warmup_steps": 100,
  "save_steps": 100
}
```

### Environment Variables

**Backend (.env):**
```env
GEMINI_API_KEY=your-key          # Required
HF_TOKEN=your-token              # Optional
JWT_SECRET_KEY=auto-generated    # Auto-generated
DATABASE_URL=sqlite:///./vibeflow.db
```

**Frontend (.env.local):**
```env
NEXT_PUBLIC_API_URL=http://localhost:8000
```

## Development

### Running Tests

**Backend:**
```bash
cd backend
pytest
pytest --cov=app tests/
```

**Frontend:**
```bash
cd frontend
npm test
npm run test:e2e
```

### Code Quality

**Backend:**
```bash
black app/
isort app/
mypy app/
flake8 app/
```

**Frontend:**
```bash
npm run lint
npm run type-check
npm run format
```

## Deployment

### Quick Deploy (Recommended)

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

See [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) for detailed instructions.

## Security

- JWT authentication with secure token management
- Password hashing with bcrypt
- CORS configuration
- Input validation with Pydantic
- SQL injection prevention
- File upload validation
- API key hashing
- Rate limiting (recommended for production)

## Contributing

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

**"Database locked"**
- SQLite doesn't handle concurrent writes well
- For production, use PostgreSQL
- Or serialize write operations

**npm permission issues**
- Use nvm: `nvm install 20 && nvm use 20`
- Or fix permissions: `npm config set prefix ~/.npm-global`
- Or use yarn: `yarn install`

See [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md#troubleshooting) for more solutions.

## Roadmap

- [ ] WebSocket support for real-time training updates
- [ ] Multi-GPU training support
- [ ] Model versioning and comparison
- [ ] Advanced evaluation metrics (MMLU, HellaSwag)
- [ ] Automated hyperparameter tuning
- [ ] Team collaboration features
- [ ] Model marketplace
- [ ] Automated deployment to multiple platforms
- [ ] Mobile PWA improvements
- [ ] Docker containers for easy deployment

## Performance

### Benchmarks

| Model | Dataset Size | Training Time (Colab T4) | Memory Usage |
|-------|--------------|--------------------------|--------------|
| Gemma-2B | 10k samples | ~30 minutes | 4GB |
| Phi-3-Mini | 10k samples | ~45 minutes | 6GB |
| Mistral-7B | 10k samples | ~2 hours | 8GB |

*Using 4-bit quantization, LoRA rank 8, 3 epochs*

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- Hugging Face for Transformers and PEFT libraries
- Google for Gemini API
- FastAPI team for the excellent framework
- Next.js team for the modern web framework
- Open-source ML community

## Support

- **Documentation**: [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)
- **Issues**: [GitHub Issues](https://github.com/yourusername/vibeflow/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/vibeflow/discussions)

## Citation

If you use VibeFlow in your research or project, please cite:

```bibtex
@software{vibeflow2024,
  title = {VibeFlow: A Complete Platform for LLM Fine-Tuning},
  author = {Your Name},
  year = {2024},
  url = {https://github.com/yourusername/vibeflow}
}
```

---

**Built with passion for democratizing AI** 

**Star this repo if you find it useful!**