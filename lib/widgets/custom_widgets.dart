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

Widget reviewerDateText(String text) {
  return Text(
    'Date Posted: $text',
    style: const TextStyle(
      fontSize: 10,
      height: 1.3,
    ),
    textAlign: TextAlign.justify,
  );
}

Widget reviewerReviewText(String text) {
  return Text(
    '"$text"',
    style: const TextStyle(
      fontSize: 14,
      height: 1.3,
    ),
    textAlign: TextAlign.justify,
  );
}

Widget reviewerNameText(String text) {
  return Text(
    '- $text',
    style: const TextStyle(
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.justify,
  );
}

Widget iconAndTextRow(IconData icon, String text, Color color) {
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

Widget iconAndTextColumn(IconData icon, String text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 50,
        ),
        contentText(text),
      ],
    ),
  );
}
