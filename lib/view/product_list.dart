import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end_test_kriya/component/shadow_container.dart';
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
  int totalProductQty = 0;
  int page = 1;
  Map<String, int> productInCart = {};

  Future<List<Product>> pageFetch(int currListSize) async {
    Http.Response json = await Http.get(
      Uri.parse('$baseUrl?$paginationArgs=$page'),
    );
    List<dynamic> jsonData = jsonDecode(json.body);
    final List<Product> nextProductsList = List.generate(
      jsonData.length,
      (int index) {
        Product _prod = Product.fromJson(
          jsonData[index],
          currListSize + index,
        );
        productInCart[_prod.productId] = 0;
        return _prod;
      },
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PaginationView(
                pageFetch: pageFetch,
                itemBuilder:
                    (BuildContext context, Product product, int index) {
                  return ShadowContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              tooltip: 'Remove',
                              onPressed: () => setState(
                                () => (() {
                                  if (productInCart[product.productId]! > 0) {
                                    productInCart[product.productId] =
                                        productInCart[product.productId]! - 1;
                                  }
                                }()),
                              ),
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              productInCart[product.productId].toString(),
                            ),
                            IconButton(
                              tooltip: 'Add',
                              onPressed: () => setState(
                                () => productInCart[product.productId] =
                                    productInCart[product.productId]! + 1,
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                onError: (dynamic error) => const Center(
                  child: Text('Some error occured'),
                ),
                onEmpty: const Center(
                  child: Text('Sorry! This is empty'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Checkout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
