import 'package:flutter/material.dart';
import 'package:front_end_test_kriya/component/shadow_container.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) => ShadowContainer(
            //todo: change with item name and purchase qty
            child: Text(
              index.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
