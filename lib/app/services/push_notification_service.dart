import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late final String? token;
  static final StreamController<dynamic> _messageStream =
      StreamController.broadcast();
  static Stream<dynamic> get dataNotification => _messageStream.stream;

  static Future initNotifications() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    debugPrint("Este es el token $token");

    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onLaunch);
    FirebaseMessaging.onBackgroundMessage(onResume);
  }

  static Future<dynamic> onMessage(RemoteMessage message) async {
    debugPrint("======== ON Message ==========");
    Map dataNotification = message.data;
    dataNotification.addAll({'isLocal': true});
    _messageStream.add(dataNotification);
  }

  static Future<dynamic> onLaunch(RemoteMessage message) async {
    debugPrint("======== ON Launch ==========");

    Map dataNotification = message.data;
    dataNotification.addAll({'isLocal': false});
    _messageStream.add(dataNotification);
  }

  static Future<dynamic> onResume(RemoteMessage message) async {
    debugPrint("======== ON Resume ==========");
    Map dataNotification = message.data;
    dataNotification.addAll({'isLocal': false});
    _messageStream.add(dataNotification);
  }

  static closeStream() {
    _messageStream.close();
  }
}
