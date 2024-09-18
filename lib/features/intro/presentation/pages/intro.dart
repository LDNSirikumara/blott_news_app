import 'package:blott_app/config/theme/app_colors.dart';
import 'package:blott_app/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:blott_app/features/intro/presentation/pages/notification.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/save_user_name.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key, required this.saveUserNameUseCase});

  final SaveUserName saveUserNameUseCase;

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _title(),
              const SizedBox(height: 20),
              _description(),
              const SizedBox(height: 20),
              _firstNameField(context),
              _lastNameField(context),
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _title() {
    return const Text(
      'Your legal name',
      style: TextStyle(
        color: Color(0xff171717),
        fontWeight: FontWeight.w700,
        fontSize: 30,
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
    );
  }

  Widget _firstNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: firstNameController,
        onChanged: (value) => setState(() {}),
        decoration: const InputDecoration(
          labelText: 'First name',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  Widget _lastNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: lastNameController,
        onChanged: (value) => setState(() {}),
        decoration: const InputDecoration(
          labelText: 'Last name',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: firstNameController.text.trim().isEmpty || lastNameController.text.trim().isEmpty ? null : _onPressed,
      backgroundColor: firstNameController.text.trim().isEmpty || lastNameController.text.trim().isEmpty ? AppColors.primary.withOpacity(0.4) : AppColors.primary,
      disabledElevation: firstNameController.text.trim().isEmpty || lastNameController.text.trim().isEmpty ? 0 : null,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.chevron_right,
        color: AppColors.white,
        size: 40,
      ),
    );
  }

  void _onPressed() {
    final user = User(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
    );
    if (firstNameController.text.trim().isEmpty || lastNameController.text.trim().isEmpty) {
    } else {
      widget.saveUserNameUseCase.call(user);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => NotificationPage(),
      ),
    );
  }
}
