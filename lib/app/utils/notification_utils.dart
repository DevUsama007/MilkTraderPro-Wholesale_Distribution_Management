// import 'package:flutter/material.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:khata_app/app/res/app_colors.dart';

// class NotificationUtils {
//   static customNotification(
//       BuildContext context, String title, String message, bool success) {
//     final snackBar = SnackBar(
//       /// need to set following properties for best effect of awesome_snackbar_content
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//           color: success ? AppColors.iconColor : Color(0xFFEF5350),
//           title: title.toString(),
//           message: message.toString(),

//           /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants

//           contentType: success ? ContentType.success : ContentType.failure),
//     );

//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }
// }
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:khata_app/app/res/app_colors.dart';

class NotificationUtils {
  static void customNotification(
      BuildContext context, String title, String message, bool success) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewPadding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AwesomeSnackbarContent(
            color: success ? AppColors.appBarColor : const Color(0xFFEF5350),
            title: title,
            message: message,
            contentType: success ? ContentType.success : ContentType.failure,
          ),
        ),
      ),
    );

    // Insert the overlay
    overlay.insert(overlayEntry);

    // Remove after 3 seconds
    Future.delayed(const Duration(seconds: 3))
        .then((_) => overlayEntry.remove());
  }
}
