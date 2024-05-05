
class LanguageResponseModel {
  final bool error;
  final List<Language> data;

  LanguageResponseModel({
    required this.error,
    required this.data,
  });

  factory LanguageResponseModel.fromJson(Map<String, dynamic> json) =>
      LanguageResponseModel(
        error: json['error'] as bool,
        data: (json['data'] as List<dynamic>)
            .map((dynamic item) => Language.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

class Language {
  final String createdAt;
  final bool deleted;
  final bool isAfrican;
  final String languageCode;
  final String languageIcon;
  final String languageName;
  final String languageId;
  final bool? published;
  final int? totalModules;

  Language({
    required this.createdAt,
    required this.deleted,
    required this.isAfrican,
    required this.languageCode,
    required this.languageIcon,
    required this.languageName,
    required this.languageId,
    this.published,
    this.totalModules,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    createdAt: json['created_at'] as String,
    deleted: json['deleted'] as bool,
    isAfrican: json['isAfrican'] as bool,
    languageCode: json['languageCode'] as String,
    languageIcon: json['languageIcon'] as String,
    languageName: json['languageName'] as String,
    languageId: json['language_id'] as String,
    published: json['published'] as bool?,
    totalModules: json['totalModules'] as int?,
  );
}
