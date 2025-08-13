import 'package:sell_smart/core/notification/local_notification_model.dart';
import 'package:flutter/foundation.dart';

@immutable
final class NotificationConstants {
  const NotificationConstants._();

  static NotificationModel scheduledArticleReminder = NotificationModel(
    type: NotificationChannelType.articleReminder,
    id: 1,
    title: 'TEST TITLE',
    body: 'TEST BODY',
    hour: 10,
    minute: 00,
  );

  static NotificationModel scheduledWordReminder = NotificationModel(
    type: NotificationChannelType.wordReminder,
    id: 2,
    title: 'TEST TITLE',
    body: 'TEST BODY',
    hour: 20,
    minute: 30,
  );
}
