# Daily News

A premium, editorial-style news aggregator built with Flutter. Designed with a focus on modern UX/UI, Daily News delivers top global stories with a classic magazine aesthetic, smooth custom animations, and high performance. Powered by the New York Times API.

## Features

- Editorial UI/UX: Classic serif typography (Playfair Display & Merriweather) with a high-contrast, black-and-white magazine aesthetic.
- Dynamic Animations: Custom page transitions (Fade + Slide), staggered list entrance animations, and an elegant branded splash screen.
- Real-Time Data: Live fetching of top stories across multiple categories (World, Science, Tech, Arts) via the NYT API.
- High Performance: Highly optimized list rendering with RepaintBoundary, debounced search filtering, and smart image caching.
- Offline Reading (Bookmarks): Save articles locally using SharedPreferences to read your favorite pieces later.
- Smart Time Formatting: Dynamic "time ago" relative stamps (e.g., "2 hours ago", "Yesterday").

## Tech Stack

- Framework: Flutter (Dart)
- State Management: Provider
- Networking: Dio
- Local Storage: SharedPreferences
- UI & Typography: Google Fonts, Custom PageRoutes

## System Requirements

- Minimum Android SDK: API 21 (Android 5.0) or higher
- Minimum iOS Version: iOS 12.0 or higher
- Flutter SDK: v3.19.0 or higher

## Getting Started

### Installation

> ⚠️ **IMPORTANT NOTE FOR REVIEWERS** ⚠️
> The New York Times API key is currently **hardcoded** in `lib/utils/constants.dart`. 
> I am fully aware that in a real-world production environment, API keys should *never* be exposed in source control (they should be secured via `.env` or a backend server). However, to ensure zero-friction for this internship review process and guarantee the app runs perfectly right out of the box, I have intentionally left the key accessible.

1. Clone the repository
   ```bash
   git clone https://github.com/itscodbro/newsfeed.git
   cd newsfeed
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Run the App
   ```bash
   flutter run
   ```

## Screenshots

(Add screenshots here once the repo is public)

## License

This project is open-source and available under the MIT License.
