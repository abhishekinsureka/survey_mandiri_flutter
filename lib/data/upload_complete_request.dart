class UploadComplete {
  final String baseUrl;
  final String name;
  final String relativeUrl;

  UploadComplete({
    required this.baseUrl,
    required this.name,
    required this.relativeUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'base_url': baseUrl,
      'name': name,
      'relative_url': relativeUrl,
    };
  }
}