# VibeFlow User Guide

## Table of Contents

1. [Getting Started](#getting-started)
2. [Creating Your First Project](#creating-your-first-project)
3. [Using the AI Agent](#using-the-ai-agent)
4. [Uploading Datasets](#uploading-datasets)
5. [Selecting Models](#selecting-models)
6. [Configuring Training](#configuring-training)
7. [Monitoring Training](#monitoring-training)
8. [Evaluating Models](#evaluating-models)
9. [Deploying Models](#deploying-models)
10. [Best Practices](#best-practices)

## Getting Started

### Registration and Login

1. Navigate to http://localhost:3000 (or your deployed URL)
2. Click "Sign Up" to create an account
3. Enter your email and password (minimum 8 characters)
4. You'll be automatically logged in after registration

### Dashboard Overview

After logging in, you'll see the main dashboard with:
- **Projects**: List of all your fine-tuning projects
- **Recent Activity**: Latest training jobs and updates
- **Quick Actions**: Create project, upload dataset, browse models
- **Statistics**: Training hours, models trained, datasets uploaded

## Creating Your First Project

### Method 1: AI-Guided Creation (Recommended for Beginners)

1. Click "New Project" button
2. Select "AI-Guided Setup"
3. Enter a project name
4. Click "Chat with AI Assistant"
5. Describe your goal in natural language:
   ```
   "I want to fine-tune a model to classify customer support tickets 
   into categories: technical, billing, and general inquiries."
   ```
6. The AI will ask clarifying questions:
   - What type of data do you have?
   - How many samples?
   - What's your target accuracy?
   - Any specific constraints (time, resources)?
7. Follow the AI's recommendations

### Method 2: Manual Creation

1. Click "New Project" button
2. Select "Manual Setup"
3. Fill in project details:
   - **Name**: Descriptive project name
   - **Description**: What you're trying to achieve
   - **Goal**: Specific objective (optional but helpful)
4. Click "Create Project"

## Using the AI Agent

The AI Agent (powered by Gemini 2.5) helps throughout the fine-tuning process.

### Starting a Conversation

1. Open any project
2. Click "AI Assistant" in the sidebar
3. Type your question or request
4. Hit Enter or click Send

### Example Conversations

**Getting Started:**
```
You: "I'm new to fine-tuning. What should I do first?"

AI: "Welcome! Let's start by understanding your goal. What task do you want your model to perform? 
For example:
- Text classification
- Question answering
- Content generation
- Summarization
- Translation"
```

**Model Selection:**
```
You: "Which model should I use for sentiment analysis on product reviews?"

AI: "For sentiment analysis on product reviews, I recommend:

1. **Gemma-2B** (Best for starting out)
   - Lightweight and fast
   - 3GB VRAM with quantization
   - Great accuracy for classification tasks

2. **Phi-3-Mini** (Balanced option)
   - Better performance
   - 4GB VRAM required
   - Excellent instruction following

Would you like me to set up training with one of these models?"
```

### Agent Capabilities

The AI Agent can:
- Recommend models based on your task
- Suggest optimal hyperparameters
- Help prepare your dataset
- Explain training metrics
- Troubleshoot issues
- Recommend next steps

## Uploading Datasets

### Supported Formats

- **CSV**: Comma-separated values
- **JSON**: Standard JSON format
- **JSONL**: JSON Lines (recommended for large datasets)
- **Parquet**: Apache Parquet format

### Upload Process

1. Open your project
2. Click "Datasets" tab
3. Click "Upload Dataset" button
4. Drag and drop your file or click to browse
5. Wait for analysis to complete
6. Review dataset preview

### Dataset Requirements

**Minimum Requirements:**
- At least 100 samples (1000+ recommended)
- Text data in at least one column
- Consistent format across rows

**Optimal Dataset Structure:**

**For Classification:**
```csv
text,label
"This product is amazing!",positive
"Terrible experience, very disappointed",negative
```

**For Generation:**
```jsonl
{"prompt": "Translate to French:", "completion": "Bonjour"}
{"prompt": "Summarize:", "completion": "Brief summary text"}
```

## Selecting Models

### Model Catalog

Browse available models in the "Models" section:

| Model | Best For | Size | VRAM |
|-------|----------|------|------|
| **Gemma-2B** | Quick experiments, limited resources | 2B | 3GB |
| **Phi-3-Mini** | Instruction following, chat | 3.8B | 4GB |
| **Gemma-7B** | Balanced performance | 7B | 6GB |
| **Mistral-7B** | High performance, reasoning | 7B | 6GB |
| **Llama-2-7B** | General purpose | 7B | 6GB |
| **Falcon-7B** | Web data training | 7B | 6GB |

### Choosing the Right Model

**Consider:**

1. **Task Complexity**
   - Simple tasks: Gemma-2B or Phi-3-Mini
   - Complex tasks: Mistral-7B or Llama-2-7B

2. **Available Resources**
   - Limited GPU: Gemma-2B (3GB VRAM)
   - Standard GPU: Any 7B model (6GB with quantization)
   - No GPU: Use Google Colab (recommended)

3. **Dataset Size**
   - Small (<1k): Smaller models to avoid overfitting
   - Medium (1k-10k): Any model
   - Large (>10k): Larger models perform better

## Configuring Training

### Basic Configuration

**Essential Parameters:**

1. **Learning Rate** (2e-4 default)
   - How fast the model learns
   - Lower (1e-4): More stable, slower
   - Higher (3e-4): Faster, may be unstable

2. **Number of Epochs** (3 default)
   - How many times to go through dataset
   - More epochs: Better learning, risk of overfitting
   - Start with 3, increase if underfitting

3. **Batch Size** (4 default)
   - How many samples per update
   - Larger: Faster training, more memory
   - Smaller: More stable, less memory

4. **Max Sequence Length** (512 default)
   - Maximum text length to process
   - Longer: Captures more context, more memory
   - Shorter: Faster, less memory

### Configuration Presets

**Quick Start (Fast Training):**
```
Learning Rate: 3e-4
Epochs: 2
Batch Size: 8
LoRA Rank: 4
Quantization: 4-bit
```

**Balanced (Recommended):**
```
Learning Rate: 2e-4
Epochs: 3
Batch Size: 4
LoRA Rank: 8
Quantization: 4-bit
```

**High Quality (Best Results):**
```
Learning Rate: 1e-4
Epochs: 5
Batch Size: 2
LoRA Rank: 16
Quantization: 8-bit
```

## Monitoring Training

### Training Status

Once training starts, you'll see:
- **Status**: pending, running, paused, completed, failed
- **Progress**: 0-100% completion
- **Elapsed Time**: How long it's been running
- **Estimated Time**: Time remaining

### Real-Time Metrics

**Loss Metrics:**
- **Training Loss**: How well model fits training data
- Should decrease over time
- Plateauing is normal after initial drop

**Other Metrics:**
- **Learning Rate**: Current learning rate (may vary)
- **Gradient Norm**: Size of updates (stability indicator)
- **Samples/Second**: Training speed

### Training Logs

View detailed logs:
1. Click "View Logs" in training monitor
2. See step-by-step progress
3. Check for warnings or errors
4. Download logs for analysis

### Controlling Training

**Pause Training:**
- Click "Pause" button
- Current progress is saved
- Resume later with "Resume"

**Cancel Training:**
- Click "Cancel" if needed
- Progress is lost but checkpoints remain
- Can start fresh training

**Resume Training:**
- Click "Resume" on paused job
- Continues from last checkpoint
- Uses same configuration

## Best Practices

### Dataset Preparation

1. **Quality Over Quantity**
   - 1000 high-quality samples > 10,000 noisy ones
   - Clean and validate data
   - Remove duplicates

2. **Balanced Classes**
   - Equal representation of each class
   - Or use class weights
   - Prevents bias

3. **Data Augmentation**
   - Paraphrase examples
   - Add variations
   - Increases diversity

4. **Train/Val Split**
   - 80/20 or 90/10 split
   - Validates generalization
   - Catches overfitting

### Model Selection

1. **Start Small**
   - Begin with Gemma-2B or Phi-3-Mini
   - Faster iterations
   - Easier debugging

2. **Scale Up Gradually**
   - If results are good, try larger model
   - If poor, check data first
   - More parameters ≠ always better

### Training Configuration

1. **Conservative Start**
   - Use default settings first
   - Establish baseline
   - Then experiment

2. **Learning Rate**
   - Most important hyperparameter
   - Start with 2e-4
   - Reduce if unstable

3. **Monitor Overfitting**
   - Watch validation loss
   - If diverging from training loss: overfitting
   - Reduce epochs or add regularization

### Cost Optimization

1. **Use Free Tier**
   - Google Colab for training
   - Gemini API free tier
   - Railway/Vercel free tiers

2. **Efficient Training**
   - Use quantization
   - Smaller batch sizes
   - Gradient accumulation

3. **Model Size**
   - Smaller models = faster/cheaper
   - Often "good enough"
   - Can always upgrade

---

**Happy Fine-Tuning!** 

If you found this guide helpful, consider starring the [GitHub repository](https://github.com/Narendrareddygithub/vibeflow-platform).