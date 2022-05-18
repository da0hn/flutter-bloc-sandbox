import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'BLoC Proof Of Concept',
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark(),
    home: const HomePage(),
  ));
}
