import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_test_kriya/bloc/product_bloc.dart';
import 'package:front_end_test_kriya/component/margined_elevated_button.dart';
import 'package:front_end_test_kriya/component/shadow_container.dart';
import 'package:front_end_test_kriya/const.dart';
import 'package:front_end_test_kriya/model/product.dart';
import 'package:front_end_test_kriya/view/checkout.dart';
import 'package:http/http.dart' as _http;
import 'package:pagination_view/pagination_view.dart';

class ProductListView extends StatefulWidget {
  static String id = 'product_list_view';

  const ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  int page = 1;
  Map<Product, int> productInCart = {};

  Future<List<Product>> pageFetch(int currListSize) async {
    //GET json from url
    _http.Response json = await _http.get(
      Uri.parse('$baseUrl?$paginationArgs=$page'),
    );
    List<dynamic> jsonData = jsonDecode(json.body);
    //create list of Product from [jsonData]
    final List<Product> nextProductsList = List.generate(
      jsonData.length,
      (int index) {
        Product _prod = Product.fromJson(
          jsonData[index],
          currListSize + index,
        );
        productInCart[_prod] = 0;
        return _prod;
      },
    );
    page = (currListSize / 10).round();
    return jsonData.isEmpty ? [] : nextProductsList;
  }

  Row _buildAddRemoveProductButton(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          tooltip: 'Remove',
          onPressed: () => setState(
            () => (() {
              if (productInCart[product]! > 0) {
                productInCart[product] = productInCart[product]! - 1;
              }
            }()),
          ),
          icon: const Icon(Icons.remove),
        ),
        Text(
          productInCart[product].toString(),
        ),
        IconButton(
          tooltip: 'Add',
          onPressed: () => setState(
            () => productInCart[product] = productInCart[product]! + 1,
          ),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductChanged) {
                return Text('Total Product qty = ${state.value}');
              } else if (state is ProductInitial) {
                return const Text('Total Product qty = -');
              }
              return const Text('Error');
            },
          ),
        ),
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //list of available products
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
                          //add-remove product button
                          _buildAddRemoveProductButton(product),
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
              //checkout button
              MarginedElevatedButton(
                onPressed: () {
                  Map<Product, int> _products = Map.from(productInCart);
                  _products.removeWhere((key, value) => value <= 0);
                  if (_products.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'You have to at least add 1 item before checkout',
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      CheckoutView.id,
                      arguments: _products,
                    );
                  }
                },
                text: 'Checkout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
