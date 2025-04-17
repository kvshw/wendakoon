class Skill {
  final String name;
  final String category;
  final String? iconUrl;
  final int proficiency; // 1-5 scale
  final String description;

  const Skill({
    required this.name,
    required this.category,
    this.iconUrl,
    required this.proficiency,
    required this.description,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] as String,
      category: json['category'] as String,
      iconUrl: json['iconUrl'] as String?,
      proficiency: json['proficiency'] as int,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'iconUrl': iconUrl,
      'proficiency': proficiency,
      'description': description,
    };
  }
}
