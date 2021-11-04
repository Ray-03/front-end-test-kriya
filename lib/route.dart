import 'package:front_end_test_kriya/view/checkout.dart';
import 'package:front_end_test_kriya/view/product_list.dart';

///[route] is list of route of the app

var route = {
  ProductListView.id: (context) => const ProductListView(),
  CheckoutView.id: (context) => const CheckoutView(),
};
