# Wendakoon - Luxury Portfolio Website

A high-end, luxury-styled portfolio website designed to showcase professional work and personal achievements in an elegant and impressive manner. Built with Flutter Web and Flask.

## Tech Stack

- **Frontend**: Flutter Web
- **Backend**: Flask (Python)
- **Database**: Supabase
- **Hosting**: TBD

## Project Structure

```
wendakoon/
├── frontend/          # Flutter web application
│   ├── lib/
│   │   ├── models/    # Data models
│   │   ├── views/     # UI screens
│   │   ├── services/  # API services
│   │   └── utils/     # Helper functions
│   └── web/          # Web-specific files
│
├── backend/           # Flask backend
│   ├── app.py        # Main application file
│   ├── config.py     # Configuration
│   ├── routes/       # API endpoints
│   ├── models/       # Data models
│   ├── services/     # Business logic
│   └── tests/        # Test files
│
└── README.md         # Project documentation
```

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Python 3.8+
- Git
- VS Code or IntelliJ IDEA (recommended)

### Frontend Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Get Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the web app:
   ```bash
   flutter run -d chrome
   ```

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create and activate virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set up environment variables:
   - Copy `.env.example` to `.env`
   - Fill in the required environment variables

5. Run the Flask server:
   ```bash
   flask run
   ```

### Environment Variables

Create a `.env` file in both frontend and backend directories with the following variables:

```env
# Backend (.env)
FLASK_APP=app.py
FLASK_ENV=development
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_key

# Frontend (.env)
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

## Development

- Follow the Flutter style guide for frontend development
- Use Black and flake8 for Python code formatting
- Write tests for new features
- Update documentation as needed

## Features

- Luxury-styled landing page with animated hero section
- Interactive portfolio gallery with project showcase
- Professional statistics dashboard
- About me section with timeline
- Contact and inquiry system
- Responsive design for all devices

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
