import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sell_smart/feature/auth/view/login_view.dart';
import 'package:sell_smart/feature/auth/view/signup_view.dart';
import 'package:sell_smart/feature/splash/splash_view.dart';

/// Centralized GoRouter configuration
final class AppRoutes {
  const AppRoutes._();

  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  static GoRouter router = GoRouter(
    initialLocation: login,
    routes: <RouteBase>[
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) => const SplashView(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (BuildContext context, GoRouterState state) => const LoginView(),
      ),
      GoRoute(
        path: signup,
        name: 'signup',
        builder: (BuildContext context, GoRouterState state) => const SignupView(),
      ),
    ],
  );
}
