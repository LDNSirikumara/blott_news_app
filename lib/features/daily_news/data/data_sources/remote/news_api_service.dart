import 'package:blott_app/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../models/article_model.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/news')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("token") String? apiKey,
    @Query("category") String? category,
  });
}
