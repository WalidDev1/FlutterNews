import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationApi {
static final _notifications = FlutterLocalNotificationsPlugin();

static Future _notificationDetails() async {
  return NotificationDetails(
    android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
      importance: Importance.max,

    ), // AndroidNotificationDetails
    iOS: IOSNotificationDetails(),
  ); // NotificationDetails
}

static Future showNotification({
int id = 0,
String title,
String body,
String payload,
}) async =>
    _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    ) ;
}

void scheduleAlarm(
    DateTime scheduledNotificationDateTime) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'alarm_notif',
    'alarm_notif',
    'Channel for Alarm notification',
    icon: 'codex_logo',
    sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
    largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
  );

  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.schedule(0, 'News', " 25 nouvelles articles diponibile ",
      scheduledNotificationDateTime, platformChannelSpecifics);
}

void SetNotif(DateTime tt) {
  DateTime scheduleAlarmDateTime;
  if (tt.isAfter(DateTime.now()))
    scheduleAlarmDateTime = tt;
  else
    scheduleAlarmDateTime = tt.add(Duration(minutes: 1));
  scheduleAlarm(scheduleAlarmDateTime);
}