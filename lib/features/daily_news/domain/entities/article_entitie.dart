import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int? id;
  final String? category;
  final int? datetime;
  final String? headline;
  final String? image;
  final String? related;
  final String? source;
  final String? summary;
  final String? url;

  const ArticleEntity({
    this.id,
    this.category,
    this.datetime,
    this.headline,
    this.image,
    this.related,
    this.source,
    this.summary,
    this.url,
  });

  @override
  List<Object?> get props => [
        id,
        category,
        datetime,
        headline,
        image,
        related,
        source,
        summary,
        url,
      ];
}
