import 'package:flutter/material.dart';

class CardInput extends StatelessWidget {
  const CardInput({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.isObsecure,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 6, top: 8),
          decoration: BoxDecoration(
            // color: const Color(0xffFED2AA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            obscureText: isObsecure,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
