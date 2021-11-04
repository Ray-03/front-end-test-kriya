import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_test_kriya/bloc/product_bloc.dart';
import 'package:front_end_test_kriya/component/margined_elevated_button.dart';
import 'package:front_end_test_kriya/component/shadow_container.dart';
import 'package:front_end_test_kriya/model/product.dart';
import 'package:front_end_test_kriya/view/product_list.dart';

class CheckoutView extends StatelessWidget {
  static String id = 'checkout_view';

  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<Product, int> _prodInCart =
        ModalRoute.of(context)!.settings.arguments as Map<Product, int>;
    final ProductBloc _productBloc = BlocProvider.of<ProductBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ProductBloc, ProductState>(
          bloc: _productBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ShadowContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_outlined,
                        size: MediaQuery.of(context).size.width * 0.4,
                        color: Colors.yellow,
                      ),
                      const Text(
                        'Please re-check before checkout!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _prodInCart.keys.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ShadowContainer(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _prodInCart.keys.elementAt(index).name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          Text(
                            _prodInCart.values.elementAt(index).toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                MarginedElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Back',
                  strong: false,
                ),
                MarginedElevatedButton(
                  onPressed: () {
                    int totalVal = _prodInCart.values.reduce(
                      (sum, element) => sum + element,
                    );
                    _productBloc.add(
                      ProductUpdate(
                        totalItemQty: totalVal,
                      ),
                    );
                    Navigator.popUntil(context, (route) => false);
                    Navigator.pushNamed(context, ProductListView.id);
                  },
                  text: 'Confirm checkout',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
