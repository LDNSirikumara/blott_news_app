import 'package:blott_app/core/resources/data_state.dart';
import '../entities/article_entitie.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
