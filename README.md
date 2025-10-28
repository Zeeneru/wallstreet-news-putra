# News App Flutter (Minimal)
Android build - ready to run.

## What is included
- Simple Flutter app that fetches news from NewsAPI.org
- Uses your API key embedded in `lib/services/news_service.dart`
- Dependencies: http, cached_network_image, url_launcher

## How to install & run (Windows - avoid common errors)
1. Install Flutter SDK and add to PATH: https://flutter.dev/docs/get-started/install/windows
2. Install Android Studio + Android SDK and set up an emulator or connect device.
3. Enable **Developer Mode** in Windows (required for plugin symlinks):
   - Open Settings > Update & Security > For developers > Enable "Developer mode"
   - Or run: `start ms-settings:developers`
4. From project root run:
   - `flutter pub get`
   - `flutter run` (or `flutter run -d <device id>`)
5. If you see plugin/symlink errors on Windows, enabling Developer Mode as above resolves them.
6. If you get Android SDK / license errors, run:
   - `flutter doctor --android-licenses`
   - `flutter doctor` and fix any remaining issues.

## Notes
- API Key is already included (you provided it). To change, edit:
  `lib/services/news_service.dart`
- This project is minimal for learning and quick running. For production, do not hardcode API keys.

