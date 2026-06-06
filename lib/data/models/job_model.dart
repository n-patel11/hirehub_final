class JobModel {
  final String title;
  final String companyName;
  final String location;
  final String description;
  final String url;
  final bool isFavorite;

  JobModel({
    required this.title,
    required this.companyName,
    required this.location,
    required this.description,
    required this.url,
    this.isFavorite = false,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      title: json['title'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      location: _parseLocation(json['location'] as Map<String, dynamic>?),
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  static String _parseLocation(Map<String, dynamic>? location) {
    if (location == null) return '';
    final parts = <String>[];
    if (location['city'] != null) parts.add(location['city'] as String);
    if (location['state'] != null) parts.add(location['state'] as String);
    if (location['country'] != null) parts.add(location['country'] as String);
    return parts.join(', ');
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company_name': companyName,
      'location': {
        'city': location.split(', ').firstOrNull ?? '',
        'country': location.split(', ').lastOrNull ?? '',
      },
      'description': description,
      'url': url,
    };
  }

  JobModel copyWith({
    String? title,
    String? companyName,
    String? location,
    String? description,
    String? url,
    bool? isFavorite,
  }) {
    return JobModel(
      title: title ?? this.title,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      description: description ?? this.description,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}