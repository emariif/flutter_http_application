import 'package:flutter/material.dart';
import 'package:flutter_http_application/home_page_delete.dart';
import 'package:flutter_http_application/home_page_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageDelete(),
    );
  }
}
