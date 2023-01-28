import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    Key? key,
    this.obscureText,
    this.hintText,
    this.controller,
  }) : super(key: key);

  final bool? obscureText;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText ?? false,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
