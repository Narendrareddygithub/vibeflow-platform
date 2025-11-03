# VibeFlow Frontend

Next.js frontend for the VibeFlow LLM fine-tuning platform.

## Features

- Next.js 16 with TypeScript
- Tailwind CSS for styling
- React Context for state management
- Custom API client
- Responsive design
- Authentication flows

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Environment Configuration

Copy the environment file:

```bash
cp .env.local.example .env.local
```

Edit `.env.local` and set:

```env
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### 3. Run Development Server

```bash
npm run dev
```

The application will be available at `http://localhost:3000`

## Project Structure

```
frontend/
├── app/                 # Next.js app directory
│   ├── globals.css     # Global styles
│   ├── layout.tsx      # Root layout
│   ├── page.tsx        # Home page
│   ├── dashboard/      # Dashboard pages
│   ├── login/          # Login page
│   ├── register/       # Registration page
│   └── ...             # Other pages
├── components/          # React components
│   ├── auth/           # Authentication components
│   ├── dashboard/      # Dashboard components
│   ├── projects/       # Project components
│   ├── datasets/       # Dataset components
│   ├── training/       # Training components
│   └── shared/         # Shared components
├── lib/                # Utilities
│   ├── api-client.ts   # API client
│   └── auth-context.tsx # Auth context
└── public/             # Static assets
```

## Key Features

### Authentication
- Login/Register forms
- JWT token management
- Protected routes
- Session persistence

### Dashboard
- Project overview
- Quick actions
- Statistics
- Recent activity

### Project Management
- Create/edit projects
- Project settings
- Project overview

### Dataset Management
- File upload interface
- Dataset preview
- Data validation
- Format support (CSV, JSON, JSONL, Parquet)

### Training
- Training configuration
- Progress monitoring
- Job control (pause/resume/cancel)
- Real-time updates

### AI Agent
- Chat interface
- Model recommendations
- Configuration assistance
- Contextual help

## Development

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

### Code Quality

- TypeScript for type safety
- ESLint for code linting
- Tailwind CSS for consistent styling
- Prettier for code formatting (recommended)

### State Management

The application uses React Context for global state:

- `AuthContext` - User authentication state
- Custom hooks for component state
- Local state for UI interactions

### API Integration

All API calls are handled through the `apiClient` class in `lib/api-client.ts`:

- Automatic token management
- Error handling
- Type-safe responses
- Automatic retries

## Styling

The application uses Tailwind CSS with a custom design system:

- Primary colors: Blue palette
- Secondary colors: Gray palette
- Consistent spacing and typography
- Responsive design patterns
- Dark mode ready

## Deployment

The frontend can be deployed to:

- Vercel (recommended)
- Netlify
- AWS Amplify
- Any static hosting platform

For deployment:

1. Build the application:
   ```bash
   npm run build
   ```

2. Deploy the `out` directory to your hosting platform

3. Configure environment variables in your hosting platform

4. Set up proper routing for client-side navigation

## Environment Variables

### Required

- `NEXT_PUBLIC_API_URL` - Backend API URL

### Optional

- `NEXT_PUBLIC_APP_NAME` - Application name (default: "VibeFlow")
- `NEXT_PUBLIC_ENVIRONMENT` - Environment (development/production)

## Contributing

When contributing to the frontend:

1. Follow TypeScript best practices
2. Use Tailwind classes for styling
3. Maintain component organization
4. Write accessible markup
5. Test responsive behavior

## License

MIT