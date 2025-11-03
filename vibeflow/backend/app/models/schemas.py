from pydantic import BaseModel, EmailStr, Field
from typing import Optional, List, Dict, Any
from datetime import datetime


# User Schemas
class UserCreate(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8)


class UserLogin(BaseModel):
    email: EmailStr
    password: str


class UserResponse(BaseModel):
    id: int
    email: str
    created_at: datetime
    
    class Config:
        from_attributes = True


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"


# Project Schemas
class ProjectCreate(BaseModel):
    name: str = Field(..., min_length=1, max_length=200)
    description: Optional[str] = None
    goal: Optional[str] = None


class ProjectUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None
    goal: Optional[str] = None
    status: Optional[str] = None


class ProjectResponse(BaseModel):
    id: int
    name: str
    description: Optional[str]
    goal: Optional[str]
    status: str
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


# Dataset Schemas
class DatasetResponse(BaseModel):
    id: int
    project_id: int
    name: str
    file_path: str
    format: str
    rows: Optional[int]
    columns: Optional[int]
    schema_info: Optional[Dict[str, Any]]
    status: str
    created_at: datetime
    
    class Config:
        from_attributes = True


class DatasetPreview(BaseModel):
    columns: List[str]
    data: List[Dict[str, Any]]
    total_rows: int


# Model Schemas
class ModelCatalogResponse(BaseModel):
    id: int
    name: str
    source: str
    hf_model_id: Optional[str]
    size: str
    task_types: List[str]
    requirements: Dict[str, Any]
    description: str
    
    class Config:
        from_attributes = True


# Training Schemas
class TrainingConfig(BaseModel):
    learning_rate: float = 2e-4
    num_epochs: int = 3
    batch_size: int = 4
    max_length: int = 512
    lora_r: int = 8
    lora_alpha: int = 32
    lora_dropout: float = 0.1
    use_quantization: bool = True
    quantization_type: str = "4bit"  # 4bit, 8bit
    gradient_accumulation_steps: int = 4
    warmup_steps: int = 100
    save_steps: int = 100


class TrainingJobCreate(BaseModel):
    project_id: int
    dataset_id: int
    model_id: int
    config: TrainingConfig


class TrainingJobResponse(BaseModel):
    id: int
    project_id: int
    dataset_id: int
    model_id: int
    config: Dict[str, Any]
    status: str
    progress: float
    metrics: Optional[Dict[str, Any]]
    created_at: datetime
    started_at: Optional[datetime]
    completed_at: Optional[datetime]
    
    class Config:
        from_attributes = True


# Evaluation Schemas
class EvaluationCreate(BaseModel):
    training_job_id: int


class EvaluationResponse(BaseModel):
    id: int
    training_job_id: int
    metrics: Dict[str, Any]
    benchmark_results: Optional[Dict[str, Any]]
    created_at: datetime
    
    class Config:
        from_attributes = True


# API Key Schemas
class APIKeyCreate(BaseModel):
    name: str


class APIKeyResponse(BaseModel):
    id: int
    name: str
    key: Optional[str]  # Only returned on creation
    usage_count: int
    created_at: datetime
    last_used_at: Optional[datetime]
    
    class Config:
        from_attributes = True


# Conversation Schemas
class ConversationMessage(BaseModel):
    role: str  # user or assistant
    content: str
    timestamp: Optional[datetime] = None


class ConversationCreate(BaseModel):
    project_id: Optional[int] = None
    message: str


class ConversationResponse(BaseModel):
    id: int
    project_id: Optional[int]
    messages: List[Dict[str, Any]]
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


# Agent Schemas
class AgentChatRequest(BaseModel):
    conversation_id: Optional[int] = None
    project_id: Optional[int] = None
    message: str


class AgentChatResponse(BaseModel):
    conversation_id: int
    message: str
    suggestions: Optional[List[str]] = None
    recommendations: Optional[Dict[str, Any]] = None


class AgentRecommendationRequest(BaseModel):
    goal: Optional[str] = None
    dataset_id: Optional[int] = None
    task_type: Optional[str] = None


class AgentRecommendationResponse(BaseModel):
    recommended_model: Optional[ModelCatalogResponse] = None
    recommended_config: Optional[TrainingConfig] = None
    reasoning: str
    alternatives: Optional[List[ModelCatalogResponse]] = None