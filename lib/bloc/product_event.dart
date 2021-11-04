part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductUpdate extends ProductEvent {
  const ProductUpdate({required this.totalItemQty});
  final int totalItemQty;
  @override
  // TODO: implement props
  List<int> get props => [totalItemQty];
}
