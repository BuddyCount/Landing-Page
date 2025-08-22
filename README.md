# BuddyCount Landing Page

A professional, standalone landing page for BuddyCount - a shared budget management app. This landing page showcases the app's features with beautiful screenshots and is designed to be completely independent of the main application.

## Features

- **Professional Design**: Modern, responsive landing page with Material Design 3
- **Screenshot Showcase**: Displays app screenshots to demonstrate functionality
- **Feature Highlights**: Clear explanation of app benefits and features
- **Call-to-Action**: Multiple entry points for users to engage with the app
- **Mobile-First**: Optimized for all device sizes

## Screenshots

The landing page includes screenshots from the actual app:
- Clean dashboard view
- Expense entry form
- Completed expense tracking

## Getting Started

### Prerequisites

- Flutter SDK: Version 3.9.0 or higher
- Dart SDK: Version 3.9.0 or higher

### Installation

1. **Clone the repository**:
   ```bash
   git clone <your-landing-page-repo-url>
   cd buddycount_landing
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the landing page**:
   ```bash
   flutter run -d chrome
   ```

## Project Structure

```
lib/
├── main_landing.dart      # Entry point for landing page
└── screens/
    └── landing_page.dart  # Main landing page widget

assets/
└── screenshots/           # App screenshots for showcase

pubspec_landing.yaml      # Dependencies for landing page
```

## Customization

### Screenshots
Replace the screenshots in `assets/screenshots/` with your own app screenshots:
- `no_expense.png` - Clean dashboard view
- `expense_fill.png` - Expense entry form
- `completed_expense.png` - Completed expense view

### App Links
Update the call-to-action buttons to link to your actual app:
- Replace placeholder SnackBar messages with actual navigation
- Update app store links when available
- Customize download/install buttons

### Branding
- Update colors in the theme
- Replace "BuddyCount" with your app name
- Customize the logo and branding elements

## Deployment

### Web Deployment
```bash
flutter build web
```

### GitHub Pages
1. Build the web version
2. Push to GitHub
3. Enable GitHub Pages in repository settings
4. Set source to `/docs` folder

### Netlify/Vercel
1. Connect your repository
2. Set build command: `flutter build web`
3. Set publish directory: `build/web`

## Dependencies

- **flutter**: Core Flutter framework
- **flutter_lints**: Code quality and style enforcement

## License

This project is for the BuddyCount landing page. Customize as needed for your own app.

## Support

For questions about this landing page template, please refer to the Flutter documentation or create an issue in the repository.
