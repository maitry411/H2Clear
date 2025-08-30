import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/hbutton.dart';
import 'package:frontend/core/widgets/hsplash_background.dart';
import 'package:frontend/core/widgets/htext_field.dart';


class RegisterPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();

  RegisterPage({super.key});

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

    Widget registerForm = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Create New Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
        const SizedBox(height: 28),
        HtextField(hintText: 'Name', controller: nameController),
        const SizedBox(height: 16),
        HtextField(hintText: 'Email', controller: emailController),
        const SizedBox(height: 16),
        HtextField(hintText: 'Password', controller: passwordController, obscureText: true),
        const SizedBox(height: 16),
        HtextField(hintText: 'Role', controller: roleController),
        const SizedBox(height: 18),
        Hbutton(
          text: 'Sign Up',
          onPressed: () {
            // Bloc sign up event can be dispatched here
          },
        ),
      ],
    );

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
                    registerForm,
                  ],
                ),
              ))
            : Row(
                children: [
                  Expanded(child: logoSection),
                  Expanded(child: Center(child: SingleChildScrollView(child: SizedBox(width: 420, child: registerForm)))),
                ],
              ),
        ),
      ),
    );
  }
}
