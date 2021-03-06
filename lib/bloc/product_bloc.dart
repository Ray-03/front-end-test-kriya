import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());
  int totalProductQty = 0;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductUpdate) {
      totalProductQty += event.totalItemQty;
      yield ProductChanged(value: totalProductQty);
    }
  }
}
