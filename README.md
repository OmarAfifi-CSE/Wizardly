<div align="center">
    
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/Logo.png">
  <img alt="Wizardly Logo" src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/Logo.png" width="100">
</picture>
    
<p align="center">
  <img src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/Wizardly%20App%20Demo.gif" alt="Wizardly App Demo" width="900"/>
</p>
</div>

<div align="center">

**Weather forecasting with a touch of magic.**

*A beautiful, dynamic weather app built with Flutter that magically transforms its UI to match the current weather conditions.*

</div>

<div align="center">

[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev)
[![State Management](https://img.shields.io/badge/State-Provider-blue?logo=flutter)](https://pub.dev/packages/provider)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/OmarAfifi-CSE/Wizardly/blob/master/LICENSE)

</div>

---

Wizardly is an atmospheric experience, not just another weather app. It delivers accurate, real-time forecasts through a beautiful and fully immersive interface. The entire application theme, from colors to animated backgrounds, dynamically transforms to match the live weather, creating a unique and delightful experience with every launch.

## 📸 A Tour Through the Magical Themes

Wizardly's core feature is its dynamic UI that reflects the weather in each city. Click below to see how the app transforms.

<br>
<table width="100%">
<tr>
    <td width="50%" valign="top">
        <h4 align="center">☀️ Sunny Day</h4>
        <p align="center">
            <img src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/screenshots/1-%20Sunny%20Weather.png" alt="Sunny Weather Theme" width="300">
        </p>
        <p>When the sun is out, the app is bathed in a warm, inviting orange glow. The UI is bright and cheerful, perfectly matching the clear skies.</p>
    </td>
    <td width="50%" valign="top">
        <h4 align="center">🔍 Intuitive City Search</h4>
        <p align="center">
            <img src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/screenshots/2-%20Search%20Screen.png" alt="Search Screen" width="300">
        </p>
        <p>The search screen maintains the current theme, providing a seamless and consistent user experience while you look for your next destination.</p>
    </td>
</tr>
<tr>
    <td width="50%" valign="top">
        <h4 align="center">☁️ Cloudy Skies</h4>
        <p align="center">
            <img src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/screenshots/3-%20Cloudy%20Weather.png" alt="Cloudy Weather Theme" width="300">
        </p>
        <p>For overcast conditions, the app uses a soothing blue-grey theme, reflecting a sky filled with clouds.</p>
    </td>
    <td width="50%" valign="top">
        <h4 align="center">💧 Rainy Day</h4>
        <p align="center">
            <img src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/screenshots/4-%20Rainy%20Weather.png" alt="Rainy Weather Theme" width="300">
        </p>
        <p>For rainy days, the app adopts a cool, tranquil green theme. The animated background shows gentle rain, creating a calming, immersive effect.</p>
    </td>
    
</tr>
<tr>
    <td width="50%" valign="top">
        <h4 align="center">❄️ Snowy Weather</h4>
        <p align="center">
            <img src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/screenshots/5-%20Snowy%20Weather.png" alt="Snowy Weather Theme" width="300">
        </p>
        <p>During a snowfall, the interface shifts to a crisp, cool lavender palette with a beautiful animated snow background, making you feel the winter chill.</p>
    </td>
    <td width="50%" valign="top">
        <h4 align="center">🌙 Clear Night</h4>
        <p align="center">
            <img src="https://github.com/OmarAfifi-CSE/Wizardly/blob/master/assets/screenshots/6-%20Night%20Weather.png" alt="Night Theme" width="300">
        </p>
        <p>After sunset, the app transitions to a deep, serene blue night theme. The UI is calm and easy on the eyes, perfect for checking the weather before bed.</p>
    </td>
    
</tr>
</table>

---

## ✨ Features

Wizardly is packed with features to make checking the weather a delightful experience.

-   **🪄 Dynamic Theming:** The star of the show. The entire UI automatically adapts to the current weather conditions and time of day.
-   **🌍 Global Weather Data:** Get detailed weather information for any city in the world.
-   **📍 Automatic Location Detection:** On startup, the app instantly finds and displays the weather for your current location.
-   **📊 Comprehensive Details:** Access all the info you need: "Feels Like" temperature, humidity, wind speed, pressure, and visibility.
-   **🗓️ Hourly & Daily Forecasts:** Plan ahead with a 24-hour hourly forecast and a 7-day outlook.
-   **💎 Glassy UI:** Modern, frosted-glass components create a sleek and elegant look.
-   **🔄 Pull to Refresh:** Easily update the weather data with a simple downward swipe.
-   **🎬 Stunning Animations:** Powered by `flutter_animate`, fluid transitions and effects bring the UI to life, while `shimmer` provides an elegant loading experience.

---

## 🛠️ Tech Stack & Key Packages

Wizardly is built with a modern and robust Flutter stack, focusing on clean architecture and performance.

-   **Core:** **Flutter & Dart**
-   **State Management:** **Provider** for simple and effective state management.
-   **Networking:** **Dio** for robust and reliable API requests.
-   **UI & Animations:**
    -   `flutter_animate`: For crafting beautiful and complex UI animations with ease.
    -   `shimmer`: To provide elegant loading skeletons (placeholders) while data is fetched.
    -   `weather_animation`: The magic behind the beautiful animated backgrounds.
-   **Key Utility Packages:**
    -   `geolocator`: For automatically detecting the user's location.
    -   `flutter_screenutil`: For building a fully responsive and adaptive UI.
    -   `font_awesome_flutter`: For a rich and diverse icon set.
    -   `intl` & `timeago`: For user-friendly date and time formatting.

---

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

-   Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
-   You will need a free API key from [WeatherAPI.com](https://www.weatherapi.com).

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/OmarAfifi-CSE/Wizardly.git
    cd Wizardly
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Configure the API Key:**
    -   Open the file `lib/services/weather_service.dart`.
    -   Inside the `WeatherService` class, you will find a placeholder for the API key. Replace it with your key:
        ```dart
        // In lib/services/weather_service.dart
        
        class WeatherService {
          final String _apiKey = 'YOUR_API_KEY_HERE';
          // ... rest of the code
        }
        ```

4.  **Run the application:**
    ```sh
    flutter run
    ```

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<div align="center">

*Crafted with ❤️ and a little bit of magic.*

</div>
