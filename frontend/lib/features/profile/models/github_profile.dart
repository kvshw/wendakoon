class GitHubProfile {
  final String name;
  final String username;
  final String avatarUrl;
  final String bio;
  final String location;
  final String email;
  final int publicRepos;
  final int followers;
  final int following;

  GitHubProfile({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.location,
    required this.email,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GitHubProfile.fromJson(Map<String, dynamic> json) {
    return GitHubProfile(
      name: json['name'] ?? '',
      username: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      bio: json['bio'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }
}
