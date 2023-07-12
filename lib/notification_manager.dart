import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//Add your logic
class NotificationManager {
  static void bgNotiResponse(NotificationResponse details) {
    final payload = details.payload ?? 'error';
    debugPrint('Payload Background Noti: $payload');
  }

  static void fgNotiResponse(NotificationResponse details) {
    final payload = details.payload ?? 'error';
    debugPrint('Payload Foreground Noti: $payload');
  }
}
