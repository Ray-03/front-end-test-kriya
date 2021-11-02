import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end_test_kriya/const.dart';
import 'package:front_end_test_kriya/model/product.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:http/http.dart' as Http;

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  int page = 1;
  int totalProductQty = 0;

  Future<List<Product>> pageFetch(int currListSize) async {
    Http.Response json = await Http.get(
      Uri.parse('$baseUrl?$paginationArgs=$page'),
    );
    List<dynamic> jsonData = jsonDecode(json.body);
    final List<Product> nextProductsList = List.generate(
      jsonData.length,
      (int index) => Product.fromJson(
        jsonData[index],
        currListSize + index,
      ),
    );
    page = (currListSize / 10).round();
    return jsonData.isEmpty ? [] : nextProductsList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Total Product qty = $totalProductQty'),
        ),
        body: PaginationView(
          pullToRefresh: true,
          itemBuilder: (BuildContext context, Product product, int index) {
            return ListTile(
              title: Text(product.name),
            );
          },
          pageFetch: pageFetch,
          onError: (dynamic error) => const Center(
            child: Text('Some error occured'),
          ),
          onEmpty: const Center(
            child: Text('Sorry! This is empty'),
          ),
        ),
      ),
    );
  }
}
