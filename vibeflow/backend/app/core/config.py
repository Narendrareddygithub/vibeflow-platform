from pydantic_settings import BaseSettings
from typing import List
import secrets


class Settings(BaseSettings):
    APP_NAME: str = "VibeFlow"
    DEBUG: bool = True
    SECRET_KEY: str = secrets.token_urlsafe(32)
    DATABASE_URL: str = "sqlite:///./vibeflow.db"
    
    # JWT Settings
    JWT_SECRET_KEY: str = secrets.token_urlsafe(32)
    JWT_ALGORITHM: str = "HS256"
    JWT_ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    JWT_REFRESH_TOKEN_EXPIRE_DAYS: int = 7
    
    # API Keys
    GEMINI_API_KEY: str = ""
    HF_TOKEN: str = ""
    KAGGLE_USERNAME: str = ""
    KAGGLE_KEY: str = ""
    
    # Upload Settings
    MAX_UPLOAD_SIZE: int = 100000000  # 100MB
    UPLOAD_DIR: str = "./uploads"
    MODELS_CACHE_DIR: str = "./models_cache"
    
    # CORS
    CORS_ORIGINS: List[str] = ["http://localhost:3000", "http://localhost:8000"]
    
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()