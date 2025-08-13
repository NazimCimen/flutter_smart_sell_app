import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<void> requestNotificationPermission();
}

class PermissionServiceImpl implements PermissionService {
  @override
  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
    } else if (status.isDenied) {
      final result = await Permission.notification.request();
      if (result.isGranted) {
      } else {}
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {}
  }
}
