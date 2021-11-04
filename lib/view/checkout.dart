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
      child: BlocBuilder<ProductBloc, ProductState>(
        bloc: _productBloc,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: (() {
              if (state is ProductChanged) {
                return Text('Total Product qty = ${state.value}');
              } else if (state is ProductInitial) {
                return const Text('Total Product qty = -');
              }
              return const Text('Error');
            }()),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //warning and list of items
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShadowContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.warning_amber_outlined,
                              size: 100,
                              color: Colors.yellow,
                            ),
                            Text(
                              'Please re-check before checkout!',
                              textAlign: TextAlign.center,
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
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                    ],
                  ),
                ),
              ),
              //back button
              MarginedElevatedButton(
                onPressed: () => Navigator.pop(context),
                text: 'Back',
                strong: false,
              ),
              //confirm button
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
          ),
        ),
      ),
    );
  }
}
