class Article {
  final String title;
  final String abstractText;
  final String byline;
  final String publishedDate;
  final String url;
  final String? imageUrl;
  final List<String> locations;
  final List<String> keywords;

  Article({
    required this.title,
    required this.abstractText,
    required this.byline,
    required this.publishedDate,
    required this.url,
    this.imageUrl,
    this.locations = const [],
    this.keywords = const [],
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String? imgUrl;
    if (json['multimedia'] != null &&
        json['multimedia'] is List &&
        (json['multimedia'] as List).isNotEmpty) {
      final multimediaList = json['multimedia'] as List;
      final imageObj = multimediaList.firstWhere(
        (m) => m['type'] == 'image',
        orElse: () => null,
      );
      if (imageObj != null) {
        imgUrl = imageObj['url'];
      }
    }

    List<String> locs = [];
    if (json['geo_facet'] != null && json['geo_facet'] is List) {
      locs = List<String>.from(json['geo_facet']);
    }

    List<String> kwds = [];
    if (json['des_facet'] != null && json['des_facet'] is List) {
      kwds = List<String>.from(json['des_facet']);
    }

    return Article(
      title: json['title'] ?? '',
      abstractText: json['abstract'] ?? '',
      byline: json['byline'] ?? '',
      publishedDate: json['published_date'] ?? '',
      url: json['url'] ?? '',
      imageUrl: imgUrl,
      locations: locs,
      keywords: kwds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'abstract': abstractText,
      'byline': byline,
      'published_date': publishedDate,
      'url': url,
      'multimedia':
          imageUrl != null
              ? [
                {'url': imageUrl, 'type': 'image'},
              ]
              : [],
      'geo_facet': locations,
      'des_facet': keywords,
    };
  }
}
