part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductChanged extends ProductState {
  final int value;

  const ProductChanged({required this.value});
  @override
  List<Object?> get props => [value];
}
