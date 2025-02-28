part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

 class CartInitialState extends CartState {}

class CartLoadingState extends CartState{}
class CartLoadedState extends CartState{
final List<CartModel> cartItems;
final double totalPrice;
CartLoadedState({required this.cartItems,required this.totalPrice});
}
class CartErrorState extends CartState{
  String errMsg;
  CartErrorState({required this.errMsg});
}