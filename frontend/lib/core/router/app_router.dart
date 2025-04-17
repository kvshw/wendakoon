import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wendakoon/features/navigation/screens/navigation_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NavigationScreen(),
    ),
  ],
);
