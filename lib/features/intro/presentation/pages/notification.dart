import 'package:blott_app/config/assets/app_images.dart';
import 'package:blott_app/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/theme/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _img(),
              const SizedBox(height: 20),
              _title(),
              const SizedBox(height: 20),
              _description(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _img() {
    return Image.asset(
      AppImages.notificationLogo,
      height: 70,
      width: 70,
    );
  }

  Widget _title() {
    return const Text(
      'Get the most out of Blott ✅',
      style: TextStyle(
        color: Color(0xff1E1F20),
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }

  Widget _description() {
    return const Text(
      'We need to know a bit about you so that we can create your account.',
      style: TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => _requestNotificationPermission(context),
        child: const SizedBox(
          width: double.infinity,
          height: 48,
          child: Center(
            child: Text(
              'Continue',
              style: TextStyle(
                color: Color(0xffFAFAFA),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _requestNotificationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
    } else if (status.isDenied || status.isPermanentlyDenied) {}
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const DailyNewsPage(),
      ),
    );
  }
}
