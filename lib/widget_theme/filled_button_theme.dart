import 'package:flutter/material.dart';

class WidgetFilledButton extends StatelessWidget {
  final Widget text;
  final VoidCallback onPressed;

  const WidgetFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        fixedSize: Size.fromWidth(double.maxFinite),
        backgroundColor: Color(0xFF5200FF),
      ),
      onPressed: onPressed,
      child: text,
    );
  }
}
