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

### Installation (For Reviewers)

> ⚠️ **IMPORTANT NOTE FOR REVIEWERS** ⚠️
> The New York Times API key is currently **hardcoded** in `lib/utils/constants.dart`. 
> I am fully aware that in a real-world production environment, API keys should *never* be exposed in source control (they should be secured via `.env` or a backend server). However, to ensure zero-friction for this internship review process and guarantee the app runs perfectly right out of the box, I have intentionally left the key accessible.

**Option A: Download ZIP (Easiest)**
1. On this GitHub page, click the green **Code** button and select **Download ZIP**.
2. Extract the downloaded ZIP file to a folder on your computer.
3. Open **Android Studio** or **VS Code**.
4. Go to `File > Open...` and select the extracted `newsfeed` folder.
5. Open a terminal inside the IDE and run `flutter pub get` to install dependencies.
6. Run the app on your emulator or physical device (or just type `flutter run`).

**Option B: Using Git**
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

<img width="720" height="1600" alt="splash_screen" src="https://github.com/user-attachments/assets/25c3796d-2992-4931-8183-1023e777ac1a" />
<img width="720" height="1600" alt="homepage" src="https://github.com/user-attachments/assets/52d79760-6ba7-4795-8d0e-71f925c95791" />
<img width="720" height="1600" alt="Sections" src="https://github.com/user-attachments/assets/edb6d575-a804-4890-a354-46eabed562f7" />
<img width="720" height="1600" alt="Saved" src="https://github.com/user-attachments/assets/ecd26f60-8ec5-431a-bfe5-2cb36173ce46" />
<img width="720" height="1600" alt="Profile" src="https://github.com/user-attachments/assets/6a531080-b8c4-486a-8abd-0428ba105fb8" />
<img width="720" height="1600" alt="DarkMode" src="https://github.com/user-attachments/assets/a10a52a5-f7e8-4912-8924-337c10c76577" />

## License

This project is open-source and available under the MIT License.
