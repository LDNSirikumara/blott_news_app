import 'package:blott_app/config/assets/app_images.dart';
import 'package:blott_app/config/theme/app_colors.dart';
import 'package:blott_app/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:blott_app/features/intro/presentation/pages/intro.dart';
import 'package:flutter/material.dart';

import '../../../intro/data/data_sources/local/user_local_datasource.dart';
import '../../../intro/data/repository/user_repository_impl.dart';
import '../../../intro/domain/usecases/get_user_name.dart';
import '../../../intro/domain/usecases/save_user_name.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Image.asset(AppImages.splashLogo, height: 150, width: 150),
      ),
    );
  }

  Future<void> redirect() async {
    final userLocalDataSource = UserLocalDataSource();
    final userRepository = UserRepositoryImpl(userLocalDataSource);
    final saveUserNameUseCase = SaveUserName(userRepository);
    await Future.delayed(const Duration(seconds: 3));

    final getUserNameUseCase = GetUserName(userRepository);

    getUserNameUseCase.call().then((value) {
      if (value?.firstName == null || value?.firstName == '') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => IntroPage(saveUserNameUseCase: saveUserNameUseCase),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const DailyNewsPage(),
          ),
        );
      }
    });
  }
}
