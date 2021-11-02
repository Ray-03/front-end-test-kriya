import 'package:flutter/material.dart';
import 'package:front_end_test_kriya/view/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Front End Test Kriya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListView(),
    );
  }
}
