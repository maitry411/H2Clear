import 'package:flutter/material.dart';

class Hbutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Hbutton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 180),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green[700],
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      child: Text(text),
    );
  }
}
