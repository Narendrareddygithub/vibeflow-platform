# VibeFlow - Complete Setup and Deployment Guide

## Overview

VibeFlow is a production-grade, zero-cost platform for fine-tuning large language models. This guide provides complete instructions for setting up, developing, and deploying the platform.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Backend Setup](#backend-setup)
3. [Frontend Setup](#frontend-setup)
4. [Getting API Keys](#getting-api-keys)
5. [Local Development](#local-development)
6. [Deployment](#deployment)
7. [Testing](#testing)
8. [Troubleshooting](#troubleshooting)

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

## Backend Setup

### 1. Navigate to Backend Directory

```bash
cd vibeflow/backend
```

### 2. Create Virtual Environment

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure Environment Variables

```bash
cp .env.example .env
```

Edit `.env` and set:

```env
# Required
GEMINI_API_KEY=your-gemini-api-key-here

# Optional but recommended
HF_TOKEN=your-huggingface-token

# Auto-generated if not set
JWT_SECRET_KEY=your-jwt-secret
SECRET_KEY=your-app-secret
```

### 5. Initialize Database

The database will be automatically initialized on first run.

### 6. Run Backend

```bash
python main.py
```

Backend will be available at `http://localhost:8000`

API docs at `http://localhost:8000/docs`

## Frontend Setup

### 1. Navigate to Frontend Directory

```bash
cd vibeflow/frontend
```

### 2. Install Dependencies

If you encounter permission issues with npm, try:

```bash
# Option 1: Using npm
npm install

# Option 2: If permissions issues persist
npm install --prefix .

# Option 3: Use yarn instead
yarn install
```

Required packages:
- lucide-react (icons)
- axios (HTTP client alternative)
- react-dropzone (file uploads)
- recharts (charts and visualizations)

To install manually:
```bash
npm install lucide-react axios react-dropzone recharts --legacy-peer-deps
```

### 3. Configure Environment

Create `.env.local`:

```env
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### 4. Run Frontend

```bash
npm run dev
```

Frontend will be available at `http://localhost:3000`

## Getting API Keys

### Gemini API Key (Required)

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Click "Create API Key"
3. Copy the key and add to backend `.env` as `GEMINI_API_KEY`

**Note**: Gemini API has a generous free tier (60 requests per minute).

### Hugging Face Token (Optional)

1. Go to [Hugging Face Settings](https://huggingface.co/settings/tokens)
2. Create a new token with "read" access
3. Copy and add to backend `.env` as `HF_TOKEN`

**Note**: Required only for accessing gated models (like Llama-2).

### Kaggle API (Optional)

1. Go to [Kaggle Account Settings](https://www.kaggle.com/settings)
2. Click "Create New API Token"
3. Download `kaggle.json`
4. Add credentials to `.env`:
   ```
   KAGGLE_USERNAME=your-username
   KAGGLE_KEY=your-key
   ```

## Local Development

### Development Workflow

1. **Start Backend** (Terminal 1):
   ```bash
   cd vibeflow/backend
   source venv/bin/activate
   python main.py
   ```

2. **Start Frontend** (Terminal 2):
   ```bash
   cd vibeflow/frontend
   npm run dev
   ```

3. **Access Application**:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - API Docs: http://localhost:8000/docs

### Testing the Setup

1. **Register a User**:
   ```bash
   curl -X POST http://localhost:8000/api/auth/register \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","password":"password123"}'
   ```

2. **Login**:
   ```bash
   curl -X POST http://localhost:8000/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","password":"password123"}'
   ```

3. **Check Available Models**:
   ```bash
   curl -X GET http://localhost:8000/api/models \
     -H "Authorization: Bearer YOUR_TOKEN"
   ```

## Deployment

### Option 1: Deploy to Railway (Recommended)

#### Backend Deployment

1. **Create Railway Account**: Go to [railway.app](https://railway.app)

2. **Create New Project**:
   ```bash
   cd vibeflow/backend
   railway init
   railway up
   ```

3. **Set Environment Variables**:
   - Go to Railway dashboard
   - Navigate to your project
   - Add environment variables from `.env`

4. **Get Deployment URL**:
   - Railway will provide a public URL
   - Update frontend `.env` with this URL

#### Frontend Deployment

1. **Create Vercel Account**: Go to [vercel.com](https://vercel.com)

2. **Deploy Frontend**:
   ```bash
   cd vibeflow/frontend
   npm install -g vercel
   vercel
   ```

3. **Configure**:
   - Add `NEXT_PUBLIC_API_URL` environment variable
   - Point to your Railway backend URL

### Option 2: Docker Deployment

#### Backend Dockerfile

Create `vibeflow/backend/Dockerfile`:

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "main.py"]
```

#### Docker Compose

Create `vibeflow/docker-compose.yml`:

```yaml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - GEMINI_API_KEY=${GEMINI_API_KEY}
      - HF_TOKEN=${HF_TOKEN}
    volumes:
      - ./backend/uploads:/app/uploads
      - ./backend/models_cache:/app/models_cache

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    environment:
      - NEXT_PUBLIC_API_URL=http://localhost:8000
    depends_on:
      - backend
```

Run with:
```bash
docker-compose up
```

### Option 3: Manual Server Deployment

#### On Ubuntu Server

1. **Setup Backend**:
   ```bash
   # Install Python
   sudo apt update
   sudo apt install python3.10 python3-pip python3-venv

   # Clone and setup
   cd /var/www
   git clone YOUR_REPO
   cd vibeflow/backend
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt

   # Create systemd service
   sudo nano /etc/systemd/system/vibeflow-backend.service
   ```

   Service file:
   ```ini
   [Unit]
   Description=VibeFlow Backend
   After=network.target

   [Service]
   User=www-data
   WorkingDirectory=/var/www/vibeflow/backend
   Environment="PATH=/var/www/vibeflow/backend/venv/bin"
   ExecStart=/var/www/vibeflow/backend/venv/bin/python main.py

   [Install]
   WantedBy=multi-user.target
   ```

   ```bash
   sudo systemctl enable vibeflow-backend
   sudo systemctl start vibeflow-backend
   ```

2. **Setup Frontend**:
   ```bash
   cd /var/www/vibeflow/frontend
   npm install
   npm run build
   npm start
   ```

3. **Setup Nginx**:
   ```bash
   sudo apt install nginx

   sudo nano /etc/nginx/sites-available/vibeflow
   ```

   Nginx config:
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;

       location /api {
           proxy_pass http://localhost:8000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
       }

       location / {
           proxy_pass http://localhost:3000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
       }
   }
   ```

   ```bash
   sudo ln -s /etc/nginx/sites-available/vibeflow /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

## Training Strategies

### Option 1: Local Training (GPU Required)

- Requires NVIDIA GPU with 8GB+ VRAM
- Install CUDA toolkit
- Use quantization (4-bit/8-bit) for larger models
- Recommended for: Gemma-2B, Phi-3-Mini with quantization

### Option 2: Google Colab (Recommended)

1. **Export Training Configuration**:
   - Use VibeFlow to configure training
   - Export configuration as JSON

2. **Create Colab Notebook**:
   ```python
   # Install dependencies
   !pip install transformers peft bitsandbytes accelerate

   # Load configuration
   import json
   config = json.loads('''YOUR_CONFIG_JSON''')

   # Train model
   # ... (use training code from training_service.py)
   ```

3. **Upload Trained Model**:
   - Upload to Hugging Face Hub
   - Or download and upload to VibeFlow

### Option 3: Hugging Face Spaces

- Deploy training as a Space
- Use GPU-enabled Space (paid)
- Automate with GitHub Actions

## Testing

### Backend Tests

```bash
cd vibeflow/backend
pytest
```

### Frontend Tests

```bash
cd vibeflow/frontend
npm test
```

### End-to-End Testing

1. Register user
2. Create project
3. Upload dataset
4. Chat with AI agent
5. Start training
6. Monitor progress
7. Evaluate model
8. Deploy API

## Troubleshooting

### Common Issues

#### 1. "Gemini API Key not configured"

**Solution**: Set `GEMINI_API_KEY` in backend `.env`

#### 2. "Permission denied" when installing npm packages

**Solutions**:
```bash
# Option 1: Fix npm permissions
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH

# Option 2: Use yarn
npm install -g yarn
yarn install

# Option 3: Use nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 20
```

#### 3. "CUDA out of memory" during training

**Solutions**:
- Enable 4-bit quantization
- Reduce batch size
- Use gradient accumulation
- Try smaller model (Gemma-2B, Phi-3-Mini)

#### 4. "Database locked" error

**Solution**: SQLite doesn't handle concurrent writes well. For production:
- Use PostgreSQL instead
- Or serialize write operations

#### 5. CORS errors in frontend

**Solution**: Check `CORS_ORIGINS` in backend `.env`:
```env
CORS_ORIGINS=["http://localhost:3000","YOUR_FRONTEND_URL"]
```

### Getting Help

1. **Check Logs**:
   - Backend: Check console output
   - Frontend: Check browser console
   - Training: Check job logs in database

2. **API Documentation**: http://localhost:8000/docs

3. **Common Error Messages**:
   - 401 Unauthorized: Check JWT token
   - 403 Forbidden: Check resource ownership
   - 404 Not Found: Check resource ID
   - 500 Server Error: Check backend logs

## Performance Optimization

### Backend

1. **Use PostgreSQL** for production (instead of SQLite)
2. **Enable caching** with Redis
3. **Use async workers** for training jobs
4. **Add rate limiting** for API endpoints

### Frontend

1. **Enable code splitting**
2. **Optimize images** with Next.js Image component
3. **Use React.memo** for expensive components
4. **Implement virtual scrolling** for large lists

### Training

1. **Use quantization** (4-bit/8-bit)
2. **Enable gradient checkpointing**
3. **Use LoRA** instead of full fine-tuning
4. **Batch your training** jobs

## Security Best Practices

1. **Never commit** `.env` files
2. **Use HTTPS** in production
3. **Implement rate limiting**
4. **Validate all inputs**
5. **Use secure JWT tokens**
6. **Enable CORS properly**
7. **Hash API keys** before storage
8. **Regular security audits**

## Monitoring

### Application Monitoring

- **Backend**: Use FastAPI's built-in logging
- **Frontend**: Use Next.js analytics
- **Training**: Store metrics in database

### Recommended Tools

- **Sentry**: Error tracking
- **LogRocket**: Session replay
- **Grafana**: Metrics visualization
- **Prometheus**: Metrics collection

## Backup and Recovery

### Database Backup

```bash
# SQLite
cp vibeflow.db vibeflow.db.backup

# PostgreSQL
pg_dump vibeflow > backup.sql
```

### Model Checkpoints

- Stored in `models_cache/`
- Backup to cloud storage (S3, Google Cloud Storage)
- Version control with Git LFS (for small models)

## Scaling

### Horizontal Scaling

- **Load balancer**: Nginx or HAProxy
- **Multiple backend instances**
- **Shared database**: PostgreSQL
- **Shared storage**: S3 or NFS

### Vertical Scaling

- **Increase RAM** for larger models
- **Better GPU** for faster training
- **SSD storage** for faster I/O

## License

MIT License - See LICENSE file for details

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create feature branch
3. Make changes
4. Add tests
5. Submit pull request

## Support

For issues and questions:
- GitHub Issues
- Email: support@vibeflow.example
- Discord: discord.gg/vibeflow

---

**Note**: This is a production-grade platform. Always follow security best practices and never expose sensitive credentials.