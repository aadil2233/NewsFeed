# News Feed Mobile App

A clean, modern Flutter mobile application that fetches Top Stories from the New York Times API and displays them in beautifully categorized tabs. Built strictly following clean code practices, this app ensures offline resilience, prevents API rate limiting gracefully, and utilizes modern Flutter widget states.

## Features

- **NYT API Integration**: Fetches top stories directly from the NYT Developer endpoints.
- **Provider State Management**: Simple and robust state logic cleanly separated from UI.
- **Dynamic Location Filtering**: Chips map exactly to the real-time geographic metadata available in the fetched articles.
- **Offline Mode**: Fully caches every category loaded. Seamlessly displays the cache when there's a network issue or API rate limit.
- **Image Caching & Hero Animations**: Uses `cached_network_image` and `Hero` transitions for a fluid UI experience without redundant image downloads.
- **Dark Mode Support**: System-wide dark/light theme toggling from the app bar.
- **API Rate Limit Guarding**: Built-in 60-minute background caching cooldown prevents the app from being temporarily blocked by the `429 Too Many Requests` limit on free NYT API keys.

## Getting Started

### 1. Requirements
Ensure you have the latest stable version of Flutter installed.

### 2. Add API Key
You MUST provide your own New York Times API key.
1. Open `lib/utils/constants.dart`.
2. Locate the `nytApiKey` constant.
3. Replace the placeholder string with your personal API key string:
   ```dart
   static const String nytApiKey = 'YOUR_API_KEY_HERE';
   ```

### 3. Run the App
From the root of the project directory, run:
```bash
flutter clean
flutter pub get
flutter run
```

### 4. Running Unit Tests
To run the widget/unit test validation suite:
```bash
flutter test
```
