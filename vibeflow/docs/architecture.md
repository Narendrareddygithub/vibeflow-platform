# VibeFlow - System Architecture

## Overview
VibeFlow is a production-grade, zero-cost platform for fine-tuning large language models using open-source technology.

## Technology Stack

### Backend
- **Framework**: Python FastAPI (async-capable, high-performance)
- **Database**: SQLite with SQLAlchemy ORM
- **Authentication**: JWT tokens
- **ML Framework**: Hugging Face Transformers, PEFT (LoRA/QLoRA)
- **Quantization**: bitsandbytes
- **Real-time**: WebSocket connections for training monitoring
- **File Processing**: Pandas for data handling

### Frontend
- **Framework**: Next.js 14 with React 18
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **State Management**: React Context + hooks
- **Real-time**: WebSocket client
- **PWA**: Service workers for offline capability

### AI Agent
- **Provider**: Google Gemini 2.5 API
- **Purpose**: Guided workflow, model recommendations, configuration optimization
- **Context Management**: Conversation history tracking

### External Integrations
- **Hugging Face**: Model/dataset loading, deployment
- **Kaggle API**: Dataset discovery
- **Google Colab**: Training execution environment
- **Gemini 2.5**: AI agent capabilities

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         Frontend                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Dashboard   │  │   Wizard     │  │  Training    │     │
│  │              │  │   Flow       │  │  Monitor     │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Evaluation   │  │  API Mgmt    │  │  Project     │     │
│  │              │  │              │  │  Manager     │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────────┘
                            │
                            │ REST API / WebSocket
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Backend API                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │    Auth      │  │   Projects   │  │   Datasets   │     │
│  │   Service    │  │   Service    │  │   Service    │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Training    │  │  Evaluation  │  │     API      │     │
│  │  Service     │  │  Service     │  │   Service    │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│  ┌──────────────┐  ┌──────────────┐                        │
│  │   Gemini     │  │   Model      │                        │
│  │   Agent      │  │   Service    │                        │
│  └──────────────┘  └──────────────┘                        │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Data Layer                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │    SQLite    │  │  File Storage│  │   Model      │     │
│  │   Database   │  │   (uploads)  │  │  Checkpoints │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                  ML Infrastructure                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Hugging Face │  │     PEFT     │  │ bitsandbytes │     │
│  │ Transformers │  │  (LoRA/QLoRA)│  │(Quantization)│     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────────┘
```

## Database Schema

### Users
- id, email, password_hash, created_at, updated_at

### Projects
- id, user_id, name, description, goal, status, created_at, updated_at

### Datasets
- id, project_id, name, file_path, format, rows, columns, status, created_at

### Models
- id, name, source, size, task_types, requirements, description

### TrainingJobs
- id, project_id, dataset_id, model_id, config, status, progress, logs, metrics, created_at, started_at, completed_at

### Evaluations
- id, training_job_id, metrics, benchmark_results, created_at

### APIKeys
- id, user_id, key_hash, name, usage_count, created_at, last_used_at, revoked_at

### Conversations
- id, user_id, project_id, messages, context, created_at

## API Endpoints

### Authentication
- POST /api/auth/register
- POST /api/auth/login
- POST /api/auth/refresh
- POST /api/auth/logout

### Projects
- GET /api/projects
- POST /api/projects
- GET /api/projects/{id}
- PUT /api/projects/{id}
- DELETE /api/projects/{id}

### Datasets
- POST /api/datasets/upload
- GET /api/datasets/{id}
- GET /api/datasets/{id}/preview
- POST /api/datasets/{id}/process

### Models
- GET /api/models
- GET /api/models/{id}
- POST /api/models/upload

### Training
- POST /api/training/start
- GET /api/training/{id}
- POST /api/training/{id}/pause
- POST /api/training/{id}/resume
- POST /api/training/{id}/cancel
- WS /api/training/{id}/stream

### Evaluation
- POST /api/evaluation/start
- GET /api/evaluation/{id}
- GET /api/evaluation/{id}/compare

### API Management
- POST /api/keys/generate
- GET /api/keys
- DELETE /api/keys/{id}
- GET /api/keys/{id}/analytics

### AI Agent
- POST /api/agent/chat
- GET /api/agent/recommendations

## User Flows

### Flow 1: Beginner with Goal
1. User describes goal in natural language
2. Gemini agent asks clarifying questions
3. Agent recommends model, dataset, and configuration
4. User reviews and confirms
5. System initiates training
6. Real-time monitoring of progress
7. Automatic evaluation
8. One-click deployment

### Flow 2: Intermediate with Dataset
1. User uploads dataset
2. System analyzes and validates data
3. Gemini agent recommends model based on data
4. User configures hyperparameters with guidance
5. Training with real-time monitoring
6. Evaluation with benchmark comparison
7. Export or deployment

### Flow 3: Advanced User
1. User selects specific model
2. Uploads or selects dataset
3. Fine-tunes hyperparameters in advanced mode
4. Initiates training with custom config
5. Monitors detailed metrics
6. Runs custom evaluations
7. API deployment with key management

## Security Architecture

### Authentication
- JWT tokens with short expiration
- Refresh token rotation
- Password hashing with bcrypt

### Data Protection
- File encryption at rest
- HTTPS for data in transit
- Secure API key storage (hashed)
- Project-level access control

### API Security
- Rate limiting per user/API key
- Request validation
- SQL injection prevention (parameterized queries)
- CORS configuration

## Deployment Strategy

### Development
- Local SQLite database
- Local file storage
- Environment variables for secrets

### Production
- Hosted on free tier (Railway, Render, or similar)
- Static frontend on Vercel/Netlify
- ML training on Google Colab/HF Spaces
- Database backups

## Zero-Cost Infrastructure

- Frontend: Vercel/Netlify free tier
- Backend: Railway/Render free tier
- Database: SQLite (file-based)
- ML Training: Google Colab free tier
- Model Storage: Hugging Face free tier
- AI Agent: Gemini API free tier
- File Storage: Local filesystem (small datasets)