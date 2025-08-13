class NotificationModel {
  final NotificationChannelType type;
  final int id;
  final String title;
  final String body;
  final int hour;
  final int minute;

  NotificationModel({
    required this.type,
    required this.id,
    required this.title,
    required this.body,
    required this.hour,
    required this.minute,
  });
}

enum NotificationChannelType {
  articleReminder(
    'article_reminder_channel',
    'Article Reminder',
    'Reminder to read your daily article',
  ),
  wordReminder(
    'word_reminder_channel',
    'Word Reminder',
    'Reminder to learn your daily word',
  );

  final String channelId;
  final String channelName;
  final String channelDescription;

  const NotificationChannelType(
    this.channelId,
    this.channelName,
    this.channelDescription,
  );
}
