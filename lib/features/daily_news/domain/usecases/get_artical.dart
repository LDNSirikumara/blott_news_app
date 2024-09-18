import 'package:blott_app/core/resources/data_state.dart';
import 'package:blott_app/core/usecase/usecase.dart';
import 'package:blott_app/features/daily_news/domain/repository/article_repository.dart';
import '../entities/article_entitie.dart';

class GetArticleUseCase implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);
  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
