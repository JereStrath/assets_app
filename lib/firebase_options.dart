// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAV0gum4l9MxXyDFfg8UHYWX-n8TQzh6-E',
    appId: '1:560858414341:web:a67333e664efe392700b6c',
    messagingSenderId: '560858414341',
    projectId: 'assets-app-49e92',
    authDomain: 'assets-app-49e92.firebaseapp.com',
    storageBucket: 'assets-app-49e92.firebasestorage.app',
    measurementId: 'G-64KRB01GT0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVioLd5AYGJAdNquoEmij5JwNYtDxRqSI',
    appId: '1:560858414341:android:fb4014d4c48e76ad700b6c',
    messagingSenderId: '560858414341',
    projectId: 'assets-app-49e92',
    storageBucket: 'assets-app-49e92.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWhMh9WxtpBfN0iFQcprAa0AnMXzrHOtc',
    appId: '1:560858414341:ios:38d28be30f09d32a700b6c',
    messagingSenderId: '560858414341',
    projectId: 'assets-app-49e92',
    storageBucket: 'assets-app-49e92.firebasestorage.app',
    iosClientId: '560858414341-til79fhjvs0oavqoiogr9drdjpp3sr8q.apps.googleusercontent.com',
    iosBundleId: 'com.example.assetsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWhMh9WxtpBfN0iFQcprAa0AnMXzrHOtc',
    appId: '1:560858414341:ios:38d28be30f09d32a700b6c',
    messagingSenderId: '560858414341',
    projectId: 'assets-app-49e92',
    storageBucket: 'assets-app-49e92.firebasestorage.app',
    iosClientId: '560858414341-til79fhjvs0oavqoiogr9drdjpp3sr8q.apps.googleusercontent.com',
    iosBundleId: 'com.example.assetsApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAV0gum4l9MxXyDFfg8UHYWX-n8TQzh6-E',
    appId: '1:560858414341:web:83df2885254208dd700b6c',
    messagingSenderId: '560858414341',
    projectId: 'assets-app-49e92',
    authDomain: 'assets-app-49e92.firebaseapp.com',
    storageBucket: 'assets-app-49e92.firebasestorage.app',
    measurementId: 'G-74ZF81KEVP',
  );
}
