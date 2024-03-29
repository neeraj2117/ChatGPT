import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(TextEditingController controller, String text,
      IconData iconData, bool toHide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: FadeInDown(
        delay: const Duration(milliseconds: 600),
        duration: const Duration(milliseconds: 700),
        child: TextField(
          // focusNode: FocusNode(),
          controller: controller,
          obscureText: toHide,
          decoration: InputDecoration(
            hintText: text,
            suffixIcon: Icon(iconData),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  static Widget CustomPasswordField(
    TextEditingController controller,
    String text,
  ) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: _PasswordField(controller: controller, hintText: text),
      ),
    );
  }

  static CustomButton(VoidCallback voidCallback, String text) {
    return SizedBox(
      height: 50,
      width: 300,
      child: FadeInUp(
        delay: const Duration(milliseconds: 600),
        duration: const Duration(milliseconds: 700),
        child: ElevatedButton(
          onPressed: () {
            voidCallback();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 21,
                color: Colors.grey[900],
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const _PasswordField({
    required this.controller,
    required this.hintText,
  });

  @override
  __PasswordFieldState createState() => __PasswordFieldState();
}

class __PasswordFieldState extends State<_PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
