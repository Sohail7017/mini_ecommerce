part of 'cart_bloc.dart';
@immutable
sealed class CartEvent {}

/// ADD CART EVENT

class AddCartEvent extends CartEvent {
  final ProductModel product;
  AddCartEvent({required this.product});
}

/// REMOVE CART EVENT
class RemoveCartEvent extends CartEvent {
  final ProductModel product;
  RemoveCartEvent({required this.product});
}

///  CART QUANTITY UPDATE EVENT
class QuantityUpdateCartEvent extends CartEvent {
  final ProductModel product;
  final int quantity;
  QuantityUpdateCartEvent({required this.product, required this.quantity});
}


/// LOAD CART ITEM EVENT from SharedPreferences
class LoadCartEvent extends CartEvent {}
