import 'package:flutter/material.dart';

Widget titleText(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

Widget contentText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      height: 1.3,
    ),
    textAlign: TextAlign.justify,
  );
}

Widget iconAndText(IconData icon, String text, Color color) {
  return Row(
    children: [
      Icon(
        icon,
        color: color,
      ),
      const SizedBox(
        width: 5,
      ),
      contentText(
        text,
      ),
    ],
  );
}
