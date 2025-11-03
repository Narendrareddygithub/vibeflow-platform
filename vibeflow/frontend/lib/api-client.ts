const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8001';

export interface ApiResponse<T> {
  data?: T;
  error?: string;
}

class ApiClient {
  private baseURL: string;
  private token: string | null = null;

  constructor(baseURL: string) {
    this.baseURL = baseURL;
    if (typeof window !== 'undefined') {
      this.token = localStorage.getItem('access_token');
    }
  }

  setToken(token: string) {
    this.token = token;
    if (typeof window !== 'undefined') {
      localStorage.setItem('access_token', token);
    }
  }

  clearToken() {
    this.token = null;
    if (typeof window !== 'undefined') {
      localStorage.removeItem('access_token');
      localStorage.removeItem('refresh_token');
    }
  }

  private async request<T>(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<ApiResponse<T>> {
    const headers: HeadersInit = {
      'Content-Type': 'application/json',
      ...options.headers,
    };

    if (this.token) {
      headers['Authorization'] = `Bearer ${this.token}`;
    }

    try {
      const response = await fetch(`${this.baseURL}${endpoint}`, {
        ...options,
        headers,
      });

      const data = await response.json();

      if (!response.ok) {
        return { error: data.detail || 'Request failed' };
      }

      return { data };
    } catch (error) {
      return { error: error instanceof Error ? error.message : 'Network error' };
    }
  }

  // Auth endpoints
  async register(email: string, password: string) {
    return this.request('/api/auth/register', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    });
  }

  async login(email: string, password: string) {
    const response = await this.request<{
      access_token: string;
      refresh_token: string;
    }>('/api/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    });

    if (response.data) {
      this.setToken(response.data.access_token);
      if (typeof window !== 'undefined') {
        localStorage.setItem('refresh_token', response.data.refresh_token);
      }
    }

    return response;
  }

  async logout() {
    this.clearToken();
  }

  // Projects
  async getProjects() {
    return this.request('/api/projects', { method: 'GET' });
  }

  async createProject(data: { name: string; description?: string; goal?: string }) {
    return this.request('/api/projects', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  async getProject(id: number) {
    return this.request(`/api/projects/${id}`, { method: 'GET' });
  }

  async updateProject(id: number, data: any) {
    return this.request(`/api/projects/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  }

  async deleteProject(id: number) {
    return this.request(`/api/projects/${id}`, { method: 'DELETE' });
  }

  // Datasets
  async uploadDataset(projectId: number, file: File) {
    const formData = new FormData();
    formData.append('file', file);

    const headers: HeadersInit = {};
    if (this.token) {
      headers['Authorization'] = `Bearer ${this.token}`;
    }

    try {
      const response = await fetch(
        `${this.baseURL}/api/datasets/upload?project_id=${projectId}`,
        {
          method: 'POST',
          headers,
          body: formData,
        }
      );

      const data = await response.json();
      if (!response.ok) {
        return { error: data.detail || 'Upload failed' };
      }
      return { data };
    } catch (error) {
      return { error: error instanceof Error ? error.message : 'Upload failed' };
    }
  }

  async getDataset(id: number) {
    return this.request(`/api/datasets/${id}`, { method: 'GET' });
  }

  async getDatasetPreview(id: number, rows: number = 10) {
    return this.request(`/api/datasets/${id}/preview?rows=${rows}`, {
      method: 'GET',
    });
  }

  // Models
  async getModels(taskType?: string) {
    const query = taskType ? `?task_type=${taskType}` : '';
    return this.request(`/api/models${query}`, { method: 'GET' });
  }

  async getModel(id: number) {
    return this.request(`/api/models/${id}`, { method: 'GET' });
  }

  // Training
  async startTraining(data: {
    project_id: number;
    dataset_id: number;
    model_id: number;
    config: any;
  }) {
    return this.request('/api/training/start', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  async getTrainingJob(id: number) {
    return this.request(`/api/training/${id}`, { method: 'GET' });
  }

  async pauseTraining(id: number) {
    return this.request(`/api/training/${id}/pause`, { method: 'POST' });
  }

  async resumeTraining(id: number) {
    return this.request(`/api/training/${id}/resume`, { method: 'POST' });
  }

  async cancelTraining(id: number) {
    return this.request(`/api/training/${id}/cancel`, { method: 'POST' });
  }

  // AI Agent
  async chatWithAgent(data: {
    message: string;
    conversation_id?: number;
    project_id?: number;
  }) {
    return this.request('/api/agent/chat', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  async getRecommendations(data: {
    goal?: string;
    dataset_id?: number;
    task_type?: string;
  }) {
    return this.request('/api/agent/recommendations', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  // Additional project endpoints
  async getProjectDatasets(projectId: number) {
    return this.request(`/api/projects/${projectId}/datasets`, { method: 'GET' });
  }

  async getProjectTraining(projectId: number) {
    return this.request(`/api/projects/${projectId}/training`, { method: 'GET' });
  }

  async getAgentStatus() {
    return this.request('/api/agent/status', { method: 'GET' });
  }
}

export const apiClient = new ApiClient(API_BASE_URL);