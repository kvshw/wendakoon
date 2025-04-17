class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String githubUrl;
  final String liveUrl;
  final List<String> categories;
  final DateTime createdAt;
  final bool isFeatured;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.githubUrl,
    this.liveUrl = '',
    required this.categories,
    required this.createdAt,
    this.isFeatured = false,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      githubUrl: json['githubUrl'] as String,
      liveUrl: json['liveUrl'] as String? ?? '',
      categories: List<String>.from(json['categories'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'categories': categories,
      'createdAt': createdAt.toIso8601String(),
      'isFeatured': isFeatured,
    };
  }
}
