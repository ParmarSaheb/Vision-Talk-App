import 'package:visiontalk/auth/auth_stream.dart';
import 'package:visiontalk/auth/login_page.dart';
import 'package:visiontalk/connectivity/check_connectivity.dart';
import 'package:visiontalk/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:visiontalk/auth/signup_page.dart';

class RouteGenerator {
  static const String authStream = '/authStream';
  static const String checkConnectivity = '/';
  static const String loginPage = '/login';
  static const String signUpPage = '/signUp';
  static const String profilePage = '/profile';
  // static const String verifyPhonePage = '/verifyPhone';

  static Route<dynamic> generatRoute(RouteSettings settings) {

    switch (settings.name) {
      case authStream:
        return MaterialPageRoute(builder: (_) => const AuthStream());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signUpPage:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case checkConnectivity:
        return MaterialPageRoute(builder: (_) => const ConnectionChecker());
      
      default:
        throw const FormatException('Route not Found');
    }
  }
}

class RouteException implements Exception {
  final String message;
  RouteException(this.message);
}
