import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/hbutton.dart';
import 'package:frontend/core/widgets/hsplash_background.dart';
import 'package:frontend/core/widgets/htext_field.dart';


class LoginPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    Widget logoSection = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/h2clear_logo.jpg', height: isMobile ? 120 : 180),
        const SizedBox(height: 24),
        Text('"Trusted Credits for a Cleaner Future."', style: TextStyle(fontSize: isMobile ? 18 : 24, color: Colors.grey)),
      ],
    );

    Widget loginForm = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[700])),
        const SizedBox(height: 8),
        const Text('Sign in to continue', style: TextStyle(color: Colors.green)),
        const SizedBox(height: 28),
        HtextField(hintText: 'Name', controller: nameController),
        const SizedBox(height: 16),
        HtextField(hintText: 'Email', controller: emailController),
        const SizedBox(height: 16),
        HtextField(hintText: 'Password', controller: passwordController, obscureText: true),
        const SizedBox(height: 18),
        Hbutton(
          text: 'Sign in',
          onPressed: () {
            // Dispatch Bloc login event
          },
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {/* Navigator.pushNamed(context, '/register'); */},
          child: Text('Create New Account', style: TextStyle(color: Colors.green, decoration: TextDecoration.underline)),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {/* Navigator.pushNamed(context, '/forgot-password'); */},
          child: Text('Forgot Password', style: TextStyle(color: Colors.green, decoration: TextDecoration.underline)),
        ),
      ],
    );

    // Responsive Layout
    return Scaffold(
      backgroundColor: Colors.black,
      body: HsplashBackground(
        child: Center(
          child: isMobile
            ? SingleChildScrollView(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    logoSection,
                    const SizedBox(height: 32),
                    loginForm,
                  ],
                ),
            ))
            : Row(
                children: [
                  Expanded(child: logoSection),
                  Expanded(child: Center(child: SingleChildScrollView(child: SizedBox(width: 420, child: loginForm)))),
                ],
              ),
        ),
      ),
    );
  }
}
