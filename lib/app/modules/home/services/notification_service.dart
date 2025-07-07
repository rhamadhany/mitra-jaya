import 'package:flutter_app_installer/flutter_app_installer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static Future<void> initialize() async {
    const initial = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initialSettings = InitializationSettings(android: initial);
    await plugin.initialize(
      initialSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  static Future<void> onDidReceiveNotificationResponse(
    NotificationResponse response,
  ) async {
    final filePath = response.payload;
    if (filePath != null && filePath.isNotEmpty) {
      if (filePath.endsWith('.apk')) {
        final installer = FlutterAppInstaller();
        installer.installApk(filePath: filePath);
      }
    }
  }

  static final plugin = FlutterLocalNotificationsPlugin();

  static Future<void> showProgressNotification(
    int id,
    String title,
    String body,
    int progress,
    int maxProgress,
    String? filePath,
  ) async {
    final androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'File download progress',
      progress: progress,
      maxProgress: maxProgress,
      showProgress: true,
      importance: Importance.high,
      onlyAlertOnce: true,
    );
    final details = NotificationDetails(android: androidDetails);
    await plugin.show(id, title, body, details, payload: filePath);
  }
}
