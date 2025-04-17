class Experience {
  final String id;
  final String company;
  final String position;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final String location;
  final List<String> technologies;
  final String companyLogo;
  final bool isCurrent;

  Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.location,
    required this.technologies,
    required this.companyLogo,
    this.isCurrent = false,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String,
      company: json['company'] as String,
      position: json['position'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      location: json['location'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      companyLogo: json['companyLogo'] as String,
      isCurrent: json['isCurrent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'position': position,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'location': location,
      'technologies': technologies,
      'companyLogo': companyLogo,
      'isCurrent': isCurrent,
    };
  }
}
