// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'notification_manager.dart';

/*Created date: 20-06-23*/
class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final _notiSettings = NotificationsSetting();

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          NotificationManager.bgNotiResponse,
      onDidReceiveNotificationResponse: NotificationManager.fgNotiResponse,
    );
    tz.initializeTimeZones();
  }

  static Future _notificationsDetail() async {
    return NotificationDetails(
      android: _notiSettings.androidNotiDetails(),
      iOS: _notiSettings.iosNotiDetails(),
    );
  }

  static Future showNotififation(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _notifications.show(
      id,
      title ?? 'Empty Title',
      body ?? 'Empty Body',
      await _notificationsDetail(),
      payload: payload ?? 'Empty Payload',
    );
  }

  static Future showPeriodicNotification(
      {required int id,
      required String title,
      required String body,
      required RepeatInterval repeatInterval,
      String? payload}) async {
    return _notifications.periodicallyShow(
        id, title, body, repeatInterval, await _notificationsDetail(),
        payload: payload);
  }

  static Future setScheduledNotification({
    required int id,
    required String title,
    required String body,
    required String? payload,
    required DateTime start,
    required DateTime end,
  }) async {
    DateTime startDatetime = start;
    DateTime endDatetime = end;

    Duration difference = endDatetime.difference(startDatetime);
    return _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(DateTime.now().add(difference), tz.local),
      await _notificationsDetail(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  static void stopNotification({required int id}) {
    _notifications.cancel(id);
  }
}

//---------------------------Notification Setting-------------------------------

class NotificationsSetting {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'Default Id', //id
    'Default Name', //name
    description: 'Default description', //name
    importance: Importance.max,
    playSound: true,
  );
  AndroidNotificationDetails androidNotiDetails(
      {String? id, String? name, String? channelDescription}) {
    return AndroidNotificationDetails(id ?? channel.id, name ?? channel.name,
        channelDescription: channelDescription ?? channel.description,
        importance: Importance.max,
        priority: Priority.high,
        color: Colors.blue,
        playSound: true,
        icon: '@mipmap/ic_launcher');
  }

  //setting for ios notification details
  DarwinNotificationDetails iosNotiDetails(
      {bool? presentAlert, bool? presentBadge, bool? presentSound}) {
    return DarwinNotificationDetails(
      sound: 'default.wav',
      presentAlert: presentAlert ?? true,
      presentBadge: presentBadge ?? true,
      presentSound: presentSound ?? true,
    );
  }
}
