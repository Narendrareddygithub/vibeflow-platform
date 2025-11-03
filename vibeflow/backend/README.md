# VibeFlow Backend

Production-grade FastAPI backend for the VibeFlow LLM fine-tuning platform.

## Features

- JWT authentication with secure token management
- RESTful API for all operations
- SQLite database with SQLAlchemy ORM
- Real Hugging Face Transformers integration
- PEFT (LoRA/QLoRA) support for efficient fine-tuning
- Gemini 2.5 AI agent integration
- File upload and processing
- Real-time training monitoring
- Background task processing

## Setup

### 1. Install Dependencies

```bash
cd backend
pip install -r requirements.txt
```

### 2. Configure Environment

Copy `.env.example` to `.env` and configure:

```bash
cp .env.example .env
```

Required configuration:
- `GEMINI_API_KEY`: Your Google Gemini API key
- `HF_TOKEN`: Hugging Face access token (optional, for gated models)
- `JWT_SECRET_KEY`: Secret key for JWT tokens (auto-generated if not set)
- `SECRET_KEY`: Application secret key (auto-generated if not set)

### 3. Run the Application

```bash
python main.py
```

Or with uvicorn directly:

```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

The API will be available at `http://localhost:8000`

API documentation at `http://localhost:8000/docs`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login
- `POST /api/auth/refresh` - Refresh access token

### Projects
- `GET /api/projects` - List user projects
- `POST /api/projects` - Create project
- `GET /api/projects/{id}` - Get project details
- `PUT /api/projects/{id}` - Update project
- `DELETE /api/projects/{id}` - Delete project

### Datasets
- `POST /api/datasets/upload` - Upload dataset
- `GET /api/datasets/{id}` - Get dataset info
- `GET /api/datasets/{id}/preview` - Preview dataset
- `POST /api/datasets/{id}/process` - Preprocess dataset
- `DELETE /api/datasets/{id}` - Delete dataset

### Models
- `GET /api/models` - List available models
- `GET /api/models/{id}` - Get model details

### Training
- `POST /api/training/start` - Start training job
- `GET /api/training/{id}` - Get training status
- `POST /api/training/{id}/pause` - Pause training
- `POST /api/training/{id}/resume` - Resume training
- `POST /api/training/{id}/cancel` - Cancel training

### AI Agent
- `POST /api/agent/chat` - Chat with AI agent
- `POST /api/agent/recommendations` - Get model recommendations
- `GET /api/agent/status` - Check agent availability

## Project Structure

```
backend/
├── main.py                 # FastAPI application entry point
├── requirements.txt        # Python dependencies
├── .env.example           # Environment variables template
├── app/
│   ├── core/              # Core functionality
│   │   ├── config.py      # Configuration management
│   │   ├── database.py    # Database setup
│   │   └── security.py    # Authentication & security
│   ├── models/            # Data models
│   │   ├── database.py    # SQLAlchemy models
│   │   └── schemas.py     # Pydantic schemas
│   ├── services/          # Business logic
│   │   ├── auth_service.py
│   │   ├── project_service.py
│   │   ├── dataset_service.py
│   │   ├── model_service.py
│   │   ├── training_service.py
│   │   └── gemini_service.py
│   └── api/               # API routes
│       ├── deps.py        # Dependencies
│       ├── auth.py
│       ├── projects.py
│       ├── datasets.py
│       ├── models.py
│       ├── training.py
│       └── agent.py
├── uploads/               # Uploaded datasets
└── models_cache/          # Trained models
```

## Database Schema

The application uses SQLite with the following tables:

- `users` - User accounts
- `projects` - User projects
- `datasets` - Uploaded datasets
- `model_catalog` - Available models
- `training_jobs` - Training jobs
- `evaluations` - Evaluation results
- `api_keys` - API keys for deployment
- `conversations` - AI agent conversations

## ML Infrastructure

### Supported Models

- Mistral-7B
- Llama-2-7B
- Falcon-7B
- Phi-3-Mini
- Gemma-2B
- Gemma-7B

### Training Features

- LoRA/QLoRA fine-tuning with PEFT
- 4-bit and 8-bit quantization
- Gradient accumulation
- Checkpoint saving
- Resume from checkpoint
- Real-time progress monitoring

### Supported Data Formats

- CSV
- JSON
- JSONL
- Parquet

## Security

- JWT token authentication
- Password hashing with bcrypt
- CORS configuration
- Input validation with Pydantic
- SQL injection prevention
- File upload validation

## Development

### Run Tests

```bash
pytest
```

### Code Formatting

```bash
black app/
isort app/
```

### Type Checking

```bash
mypy app/
```

## Deployment

The backend can be deployed to:

- Railway (recommended for free tier)
- Render
- Heroku
- Any platform supporting Python/Docker

For production:
1. Set production environment variables
2. Use PostgreSQL instead of SQLite (optional)
3. Configure proper CORS origins
4. Enable HTTPS
5. Set up monitoring and logging

## License

MIT