import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GitHubService {
  static const String _baseUrl = 'https://api.github.com';
  static const String _username = 'kvshw';

  // Get token from environment variables
  static String get _token => dotenv.env['GITHUB_TOKEN'] ?? '';

  final _headers = {
    'Accept': 'application/vnd.github.v3+json',
    if (_token.isNotEmpty) 'Authorization': 'Bearer $_token',
  };

  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$_username'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<List<Map<String, dynamic>>> getRepositories() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$_username/repos?sort=updated&per_page=10'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  Future<Map<String, dynamic>> getStats() async {
    final profile = await getUserProfile();
    final repos = await getRepositories();

    int totalStars = 0;
    for (var repo in repos) {
      totalStars += (repo['stargazers_count'] as int);
    }

    return {
      'repositories': profile['public_repos'],
      'followers': profile['followers'],
      'stars': totalStars,
      'projects': repos.length,
    };
  }
}
