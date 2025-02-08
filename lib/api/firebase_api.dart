import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/views/homepage.dart';
import 'package:get/get.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.title}');
  print('Payload: ${message.data}');
}

// firebase api messages
class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      print('Foreground Message: ${message.notification?.body ?? ''}');
      print('Payload: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notification Opened: ${message.notification?.body ?? ''}');
      print('Payload: ${message.data}');
      Get.to(() => HomePage());     
    });
  }
}
