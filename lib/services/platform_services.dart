// Importing the 'dart:io' library to access platform information.
import 'dart:io' show Platform;

// Importing the 'kIsWeb' constant from the 'flutter/foundation.dart' library.
// This constant is used to determine if the app is running on the web.
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformServices {
  // Method to check if the app is running on a mobile platform.
  static bool get isMobile {
    // If the app is running on the web, it is not considered as a mobile platform.
    if (kIsWeb) {
      return false;
    } else {
      // Check if the platform is iOS or Android.
      return Platform.isIOS || Platform.isAndroid;
    }
  }

  // Method to check if the app is running on a desktop platform.
  static bool get isDesktop {
    // If the app is running on the web, it is not considered as a desktop platform.
    if (kIsWeb) {
      return false;
    } else {
      // Check if the platform is Linux, Fuchsia, Windows, or macOS.
      return Platform.isLinux ||
          Platform.isFuchsia ||
          Platform.isWindows ||
          Platform.isMacOS;
    }
  }

  // Method to check if the app is running on an Android device.
  static bool get isAndroid {
    // If the app is running on the web, it is not considered as an Android device.
    if (kIsWeb) {
      return false;
    } else {
      // Check if the platform is Android.
      return Platform.isAndroid;
    }
  }
}
