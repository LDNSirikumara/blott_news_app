import 'package:blott_app/config/theme/app_colors.dart';
import 'package:blott_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:blott_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../intro/data/data_sources/local/user_local_datasource.dart';
import '../../../../intro/data/repository/user_repository_impl.dart';
import '../../../../intro/domain/entities/user.dart';
import '../../../../intro/domain/usecases/get_user_name.dart';
import '../../widgets/article.dart';

class DailyNewsPage extends StatelessWidget {
  // final GetUserName getUserNameUseCase;
  // const DailyNewsPage({super.key, required this.getUserNameUseCase});
  const DailyNewsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 181,
            color: const Color(0xFF05021B),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  _userName(),
                  _listOfArticles(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userName() {
    final userLocalDataSource = UserLocalDataSource();
    final userRepository = UserRepositoryImpl(userLocalDataSource);
    final getUserNameUseCase = GetUserName(userRepository);
    return FutureBuilder<User?>(
      future: getUserNameUseCase.call(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          return Text(
            'Hey ${user.firstName}',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 32,
              fontFamily: GoogleFonts.raleway().fontFamily,
              color: Colors.white,
            ),
          );
        } else {
          return Text(
            'Hey ',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 32,
              fontFamily: GoogleFonts.raleway().fontFamily,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _listOfArticles() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 200),
            child: Center(
              child: CupertinoActivityIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }
        if (state is RemoteArticlesError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemCount: state.articles!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var article = state.articles![index];

              int timestamp = article.datetime ?? 0;
              // Convert to DateTime
              DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
              // Format the date to 'dd MMMM yyyy'
              String formattedDate = DateFormat('dd MMMM yyyy').format(date);

              return Article(
                source: article.source,
                date: formattedDate,
                title: article.headline,
                imgUrl: article.image,
                url: article.url,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
