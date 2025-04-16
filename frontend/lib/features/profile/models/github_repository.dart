class GitHubRepository {
  final String name;
  final String description;
  final String language;
  final int stars;
  final String url;
  final bool isFork;
  final DateTime updatedAt;

  GitHubRepository({
    required this.name,
    required this.description,
    required this.language,
    required this.stars,
    required this.url,
    required this.isFork,
    required this.updatedAt,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? 'Unknown',
      stars: json['stargazers_count'] ?? 0,
      url: json['html_url'] ?? '',
      isFork: json['fork'] ?? false,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Helper method to get language color
  static Map<String, int> languageColors = {
    'JavaScript': 0xFFF1E05A,
    'Python': 0xFF3572A5,
    'Dart': 0xFF00B4AB,
    'TypeScript': 0xFF2B7489,
    'HTML': 0xFFE34C26,
    'CSS': 0xFF563D7C,
    'Java': 0xFFB07219,
    'Unknown': 0xFF808080,
  };

  int get languageColor =>
      languageColors[language] ?? languageColors['Unknown']!;
}
