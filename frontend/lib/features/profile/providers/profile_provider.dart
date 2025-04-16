import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wendakoon/core/services/github_service.dart';
import 'package:wendakoon/features/profile/models/github_profile.dart';
import 'package:wendakoon/features/profile/models/github_repository.dart';

final githubServiceProvider = Provider((ref) => GitHubService());

final profileProvider = FutureProvider<GitHubProfile>((ref) async {
  final service = ref.watch(githubServiceProvider);
  final data = await service.getUserProfile();
  return GitHubProfile.fromJson(data);
});

final repositoriesProvider =
    FutureProvider<List<GitHubRepository>>((ref) async {
  final service = ref.watch(githubServiceProvider);
  final data = await service.getRepositories();
  return data.map((repo) => GitHubRepository.fromJson(repo)).toList();
});

final statsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(githubServiceProvider);
  return service.getStats();
});
