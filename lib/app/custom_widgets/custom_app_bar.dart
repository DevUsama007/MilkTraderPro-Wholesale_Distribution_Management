import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final double? elevation;
  final IconThemeData? iconTheme;
  final bool automaticallyImplyLeading;
  final IconData? icon;
  VoidCallback? ontap;
  CustomAppbar({
    super.key,
    this.ontap,
    required this.title,
    this.icon,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation,
    this.iconTheme,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: GestureDetector(
      //   onTap: ontap,
      //   child: Icon(
      //     icon,
      //     color: Colors.white,
      //   ),
      // ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20),
        // style: AppTextStyles.customText(
        //   fontWeight: FontWeight.w700,
        //   color: Colors.white,
        //   fontSize: 18,
        // ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      iconTheme: iconTheme,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      shadowColor: Colors.yellow,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
