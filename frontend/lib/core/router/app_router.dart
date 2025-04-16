import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wendakoon/features/profile/screens/profile_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
