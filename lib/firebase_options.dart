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
    apiKey: 'AIzaSyCHQDS9bTUFMtLaenqxPGf_dAWJWsLPFdQ',
    appId: '1:358285087395:web:314c34e90571ad0d2b2516',
    messagingSenderId: '358285087395',
    projectId: 'fooddeliveryapp-65851',
    authDomain: 'fooddeliveryapp-65851.firebaseapp.com',
    databaseURL: 'https://fooddeliveryapp-65851-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fooddeliveryapp-65851.appspot.com',
    measurementId: 'G-RSS4YTCBGE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8dxoyOWswhN7x132xPoYXNDQegJ0nBVs',
    appId: '1:358285087395:android:17c8ce4c91dae84a2b2516',
    messagingSenderId: '358285087395',
    projectId: 'fooddeliveryapp-65851',
    databaseURL: 'https://fooddeliveryapp-65851-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fooddeliveryapp-65851.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGyt51YuBIelrgaDG4QOS3KvsVz1Dvsi8',
    appId: '1:358285087395:ios:5acca08baf08f9622b2516',
    messagingSenderId: '358285087395',
    projectId: 'fooddeliveryapp-65851',
    databaseURL: 'https://fooddeliveryapp-65851-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fooddeliveryapp-65851.appspot.com',
    androidClientId: '358285087395-98bqfc9sfss1h1cjv18sdnmeoihq1dt2.apps.googleusercontent.com',
    iosClientId: '358285087395-rgc12mvedmdmbq59jhjaeknbqigrprms.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFoodDeliveryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGyt51YuBIelrgaDG4QOS3KvsVz1Dvsi8',
    appId: '1:358285087395:ios:5acca08baf08f9622b2516',
    messagingSenderId: '358285087395',
    projectId: 'fooddeliveryapp-65851',
    databaseURL: 'https://fooddeliveryapp-65851-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fooddeliveryapp-65851.appspot.com',
    androidClientId: '358285087395-98bqfc9sfss1h1cjv18sdnmeoihq1dt2.apps.googleusercontent.com',
    iosClientId: '358285087395-rgc12mvedmdmbq59jhjaeknbqigrprms.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFoodDeliveryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCTmy7LTXgNb85kW1kw433vkzLYqbmP6MQ',
    appId: '1:358285087395:web:6395cb0f63d135a52b2516',
    messagingSenderId: '358285087395',
    projectId: 'fooddeliveryapp-65851',
    authDomain: 'fooddeliveryapp-65851.firebaseapp.com',
    databaseURL: 'https://fooddeliveryapp-65851-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fooddeliveryapp-65851.appspot.com',
    measurementId: 'G-X7Z5X0FTW6',
  );
}
