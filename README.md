# 📰 Daily News

A premium, editorial-style news aggregator built with Flutter. Designed with a focus on modern UX/UI, **Daily News** delivers top global stories with a classic magazine aesthetic, smooth custom animations, and high performance. Powered by the New York Times API.

## ✨ Features

- **Editorial UI/UX**: Classic serif typography (Playfair Display & Merriweather) with a high-contrast, black-and-white magazine aesthetic.
- **Dynamic Animations**: Custom page transitions (Fade + Slide), staggered list entrance animations, and an elegant branded splash screen.
- **Real-Time Data**: Live fetching of top stories across multiple categories (World, Science, Tech, Arts) via the NYT API.
- **High Performance**: Highly optimized list rendering with `RepaintBoundary`, debounced search filtering, and smart image caching (`CachedNetworkImage`).
- **Offline Reading (Bookmarks)**: Save articles locally using `SharedPreferences` to read your favorite pieces later.
- **Smart Time Formatting**: Dynamic "time ago" relative stamps (e.g., "2 hours ago", "Yesterday").

## 🛠 Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Networking**: Dio
- **Local Storage**: SharedPreferences
- **UI & Typography**: Google Fonts, Custom PageRoutes
- **Environment Management**: flutter_dotenv

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.19.0 or higher)
- A valid [New York Times Developer API Key](https://developer.nytimes.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/newsfeed.git
   cd newsfeed
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Environment Variables**
   Create a `.env` file in the root directory of the project and add your NYT API Key:
   ```env
   NYT_API_KEY=your_api_key_here
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

## 📱 Screenshots

*(Add screenshots here once the repo is public!)*
<p align="center">
  <img src="https://via.placeholder.com/250x500.png?text=Home+Feed" width="250" />
  <img src="https://via.placeholder.com/250x500.png?text=Article+Detail" width="250" />
  <img src="https://via.placeholder.com/250x500.png?text=Saved+Articles" width="250" />
</p>

## 📄 License

This project is open-source and available under the MIT License.
