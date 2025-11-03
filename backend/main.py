from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from app.core.config import settings
from app.core.database import init_db
from app.api import auth, projects, datasets, models, training, agent, evaluation
from app.services.model_service import ModelService
from app.core.database import SessionLocal


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Lifecycle events for the application"""
    # Startup: Initialize database and seed data
    init_db()
    db = SessionLocal()
    try:
        ModelService.init_model_catalog(db)
    finally:
        db.close()
    
    yield
    
    # Shutdown: cleanup if needed


# Create FastAPI application
app = FastAPI(
    title=settings.APP_NAME,
    description="A complete web-based LLM fine-tuning platform",
    version="1.0.0",
    lifespan=lifespan
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth.router)
app.include_router(projects.router)
app.include_router(datasets.router)
app.include_router(models.router)
app.include_router(training.router)
app.include_router(evaluation.router)
app.include_router(agent.router)


@app.get("/")
def root():
    """Root endpoint"""
    return {
        "name": settings.APP_NAME,
        "version": "1.0.0",
        "status": "running"
    }


@app.get("/health")
def health_check():
    """Health check endpoint"""
    return {"status": "healthy"}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=settings.DEBUG)