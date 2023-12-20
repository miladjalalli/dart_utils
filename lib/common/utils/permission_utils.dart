import 'package:permission_handler/permission_handler.dart';

/**
 * @Author: Milad Jalali
 * @Date: 2023/17/12
 */


/// درخواست دسترسی به مجوز مورد نظر تا گرفتن تایید یا بازکردن تنظیمات اپلیکیشن

class PermissionUtils {
  Future<bool> checkPermissionUntilGetIt(Permission permission) async {
    PermissionStatus status = await permission.request();
    if (status.isDenied == true) {
      return checkPermissionUntilGetIt(permission);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }
}
