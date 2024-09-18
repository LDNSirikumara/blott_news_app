import '../../domain/entities/article_entitie.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.id,
    required super.category,
    required super.datetime,
    required super.headline,
    required super.image,
    required super.related,
    required super.source,
    required super.summary,
    required super.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] ?? '',
      category: map['category'] ?? '',
      datetime: map['datetime'] ?? '',
      headline: map['headline'] ?? '',
      image: map['image'] ?? '',
      related: map['related'] ?? '',
      source: map['source'] ?? '',
      summary: map['summary'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
