part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddCartEvent extends CartEvent {
  final ProductModel product;
  AddCartEvent({required this.product});
}

class RemoveCartEvent extends CartEvent {
  final ProductModel product;
  RemoveCartEvent({required this.product});
}

class QuantityUpdateCartEvent extends CartEvent {
  final ProductModel product;
  final int quantity;
  QuantityUpdateCartEvent({required this.product, required this.quantity});
}

class LoadCartEvent extends CartEvent {} // Load cart from SharedPreferences
