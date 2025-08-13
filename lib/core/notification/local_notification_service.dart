import 'package:sell_smart/core/notification/local_notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

abstract class LocalNotificationService {
  /// Initializes the local notification service.
  Future<void> initialize();

  /// Shows a daily notification at the specified time for the given channel type.
  Future<void> showDailyNotification({
    required NotificationModel notificationModel,
  });
}

class LocalNotificationServiceImpl implements LocalNotificationService {
  final  _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initializes timezones, notification settings, and creates all notification channels.
  @override
  Future<void> initialize() async {
    await _initTimezone();

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    await _createAllNotificationChannels();
  }

  /// Initializes the timezone settings based on the device's local timezone.
  Future<void> _initTimezone() async {
    tz.initializeTimeZones();
    try {
      final currentTimezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimezone));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));
    }
  }

  /// Creates all predefined notification channels.
  Future<void> _createAllNotificationChannels() async {
    final androidPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      for (final channelType in NotificationChannelType.values) {
        final channel = AndroidNotificationChannel(
          channelType.channelId,
          channelType.channelName,
          description: channelType.channelDescription,
          importance: Importance.high,
        );
        await androidPlugin.createNotificationChannel(channel);
      }
    }
  }

  /// Schedules a daily notification at the specified hour and minute.
  @override
  Future<void> showDailyNotification({
    required NotificationModel notificationModel,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationModel.id,
      notificationModel.title,
      notificationModel.body,
      _nextInstanceOfTime(notificationModel.hour, notificationModel.minute),
      NotificationDetails(
        android: AndroidNotificationDetails(
          notificationModel.type.channelId,
          notificationModel.type.channelName,
          channelDescription: notificationModel.type.channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Calculates the next scheduled time for the notification based on the provided hour and minute.
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
