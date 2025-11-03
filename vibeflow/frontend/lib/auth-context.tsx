'use client';

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { apiClient } from '@/lib/api-client';

interface User {
  id: number;
  email: string;
}

interface AuthContextType {
  user: User | null;
  loading: boolean;
  login: (email: string, password: string) => Promise<{ error?: string }>;
  register: (email: string, password: string) => Promise<{ error?: string }>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Check if user is logged in
    const token = localStorage.getItem('access_token');
    if (token) {
      // In a real app, verify token with backend
      const userData = localStorage.getItem('user_data');
      if (userData) {
        setUser(JSON.parse(userData));
      }
    }
    setLoading(false);
  }, []);

  const login = async (email: string, password: string) => {
    const response = await apiClient.login(email, password);
    if (response.error) {
      return { error: response.error };
    }
    
    const userData = { id: 1, email }; // In real app, get from response
    setUser(userData);
    localStorage.setItem('user_data', JSON.stringify(userData));
    return {};
  };

  const register = async (email: string, password: string) => {
    const response = await apiClient.register(email, password);
    if (response.error) {
      return { error: response.error };
    }
    
    const userData = { id: 1, email };
    setUser(userData);
    localStorage.setItem('user_data', JSON.stringify(userData));
    return {};
  };

  const logout = () => {
    apiClient.logout();
    setUser(null);
    localStorage.removeItem('user_data');
  };

  return (
    <AuthContext.Provider value={{ user, loading, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}