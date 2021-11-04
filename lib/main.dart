import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_test_kriya/bloc/product_bloc.dart';
import 'package:front_end_test_kriya/route.dart';
import 'package:front_end_test_kriya/view/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: MaterialApp(
        title: 'Front End Test Kriya',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        // home: const ProductListView(),
        routes: route,
        initialRoute: ProductListView.id,
      ),
    );
  }
}
