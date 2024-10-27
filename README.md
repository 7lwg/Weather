<!-- # 🌦️ Weather App

## 📖 Overview

The **Weather App** provides users with real-time weather data for any city worldwide. It allows users to search for cities by name, select multiple cities to compare weather information, and view detailed weather forecasts. The "Current Location" feature lets users check the weather for their exact location with a single tap. The app offers all essential weather insights in a simple, intuitive interface for easy navigation and access to accurate weather data.

## 🚀 Features

- **🌍 City Search**: Quickly search for cities by name and view weather data instantly.
- **🏙️ Multiple City Selection**: Add and switch between multiple cities to view and compare weather information.
- **📍 Current Location**: Automatically fetch and display weather data for your current geographical location.
- **🌤️ Detailed Weather Information**: For each selected city, the app provides:
  - **Current temperature** and **condition** (e.g., sunny, cloudy, rain)
  - **Daily min and max temperatures**
  - **Hourly forecast** for the current day
  - **4-day forecast** with min/max temperatures and weather conditions
  - **Humidity percentage** and **feels-like temperature**
  - **UV Index** for sunlight intensity
  - **Wind speed** and **direction**
  - **Sunrise and sunset times**
  - **Current time** for easy reference

## 💡 How It Works

1. **Search for a city**: Enter a city's name in the search bar to add it to your list of tracked cities.
2. **View weather data**: Select a city from your list to view its live weather data and forecasts.
3. **Track multiple cities**: Add multiple cities and switch between them to monitor different locations.
4. **Current Location**: Tap the "Current Location" button to view real-time weather data for your exact location.

## Technologies Used

- **Flutter**: UI toolkit for building cross-platform applications.
- **Dart**: Programming language used with Flutter.
- **Cubit (Bloc)**: For state management, providing a simple way to manage and react to changes in the app's state.
- **http**: For making network requests to fetch country data from the [REST Countries API](https://weather.visualcrossing.com/).

- **SharedPreferences**: For storing local data persistently on the user's device.
- **Animation**: Used to create smooth and interactive user experiences.
- **Responsive Design**: Ensures the app layout works well across various screen sizes and devices.

## API

The app fetches country data from the [REST Countries API](https://weather.visualcrossing.com/), which provides detailed information on countries.

## 🔧 Technologies Used

- **Flutter**: Used to build a smooth and responsive cross-platform app.
- **Dart**: Core programming language for Flutter, powering the app's logic.
- **API Integration**: Weather data is fetched from an external weather API service.
- **Geolocation**: The app uses device location services to detect the user's location for weather updates.

## 🔮 Future Enhancements

- **Weather Alerts**: Introduce notifications for extreme weather conditions such as storms or heatwaves.
- **Customizable Units**: Let users toggle between Celsius and Fahrenheit for temperature display.
- **Extended Forecasts**: Add more detailed forecasts, including hourly precipitation and air quality index.
- **Language Localization**: Support for multiple languages to make the app accessible globally.

## 🛡️ License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🙌 Contribution

Contributions are welcome! Feel free to fork the repository, open issues, or submit pull requests to help improve the app. Every contribution counts! -->

# 🌦️ Weather App

## 📖 Overview

The **Weather App** provides users with real-time weather data for any city worldwide. It allows users to search for cities by name, select multiple cities to compare weather information, and view detailed weather forecasts. The "Current Location" feature lets users check the weather for their exact location with a single tap. The app offers all essential weather insights in a simple, intuitive interface for easy navigation and access to accurate weather data.

## 🚀 Features

- **🌍 City Search**: Quickly search for cities by name and view weather data instantly.
- **🏙️ Multiple City Selection**: Add and switch between multiple cities to view and compare weather information.
- **📍 Current Location**: Automatically fetch and display weather data for your current geographical location.
- **🌤️ Detailed Weather Information**: For each selected city, the app provides:
  - **Current temperature** and **condition** (e.g., sunny, cloudy, rain)
  - **Daily min and max temperatures**
  - **Hourly forecast** for the current day
  - **4-day forecast** with min/max temperatures and weather conditions
  - **Humidity percentage** and **feels-like temperature**
  - **UV Index** for sunlight intensity
  - **Wind speed** and **direction**
  - **Sunrise and sunset times**
  - **Current time** for easy reference

## 💡 How It Works

1. **Search for a city**: Enter a city's name in the search bar to add it to your list of tracked cities.
2. **View weather data**: Select a city from your list to view its live weather data and forecasts.
3. **Track multiple cities**: Add multiple cities and switch between them to monitor different locations.
4. **Current Location**: Tap the "Current Location" button to view real-time weather data for your exact location.

## 🔧 Technologies Used

- **Flutter**: UI toolkit for building cross-platform applications.
- **Dart**: Programming language used with Flutter.
- **Cubit**: State management solution that provides a simple way to manage and react to changes in the app's state.
- **http**: For making network requests to fetch weather data from the [External Weather API](https://weather.visualcrossing.com/).
- **SharedPreferences**: Used for persistent local data storage, allowing the app to remember user settings and preferences.
- **Geolocation**: Utilizes device location services to determine the user's current location for weather updates.
- **Animation**: Used to create smooth and interactive user experiences.
- **Responsive Design**: Ensures the app layout works well across various screen sizes and devices.

## 📡 API

The app fetches weather data from an [External Weather API](https://weather.visualcrossing.com/), which provides detailed information on weather conditions and forecasts.
