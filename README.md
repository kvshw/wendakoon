# Wendakoon Portfolio

A modern, responsive portfolio application built with Flutter and Node.js.

## Version 1.0.0

### Features
- Modern, responsive profile dashboard
- Dark/Light theme support
- Real-time GitHub integration
- Social media links and stats
- Glass morphism UI design
- Animated components
- Responsive layout

### Tech Stack
- **Frontend**: Flutter
- **Backend**: Node.js
- **APIs**: GitHub API
- **State Management**: Riverpod
- **Routing**: Go Router
- **UI Components**: 
  - Font Awesome Icons
  - Google Fonts
  - Cached Network Image
  - URL Launcher

### Prerequisites
- Flutter SDK
- Node.js
- Git
- GitHub Account

### Environment Setup
1. Clone the repository
```bash
git clone https://github.com/kvshw/wendakoon.git
cd wendakoon
```

2. Install dependencies
```bash
# Frontend
cd frontend
flutter pub get

# Backend
cd ../backend
npm install
```

3. Configure environment variables
- Copy `.env.example` to `.env`
- Update the following variables:
  - `GITHUB_TOKEN`: Your GitHub personal access token
  - Other configuration variables as needed

### Running the App

#### Frontend
```bash
cd frontend
flutter run
```

#### Backend
```bash
cd backend
npm start
```

### Project Structure
```
wendakoon/
├── frontend/           # Flutter application
│   ├── lib/
│   │   ├── core/      # Core functionality
│   │   ├── features/  # Feature modules
│   │   └── main.dart  # Entry point
│   └── pubspec.yaml   # Dependencies
├── backend/           # Node.js server
│   ├── routes/       # API routes
│   └── package.json  # Dependencies
└── README.md
```

### Current Features
- Profile Dashboard
  - Avatar and basic info
  - Social stats with animations
  - GitHub integration
  - Social media links
- Theme Switching
  - Dark mode
  - Light mode with glass effect
- Responsive Design
  - Mobile-first approach
  - Adaptive layouts

### Upcoming Features
- Project showcase
- Blog/Articles section
- Contact form
- Skills section
- Experience timeline
- Education details
- Achievements
- Project filtering

### Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### License
This project is licensed under the MIT License - see the LICENSE file for details.

### Contact
Kavishwa Wendakoon - kaveebhashiofficial@gmail.com

Project Link: https://github.com/kvshw/wendakoon
