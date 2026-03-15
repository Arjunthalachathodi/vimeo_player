import 'package:flutter/material.dart';
import 'home/homepage.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  static const routeName = 'app-root';

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
