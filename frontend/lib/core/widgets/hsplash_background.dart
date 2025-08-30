import 'package:flutter/material.dart';

class HsplashBackground extends StatelessWidget {
  final Widget child;
  const HsplashBackground({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            isMobile ? 'assets/green_splash_mobile.png' : 'assets/green_splash_desktop.png',
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
