import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_task/models/cart_model.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/view_model/data/repository/app_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AppRepository appRepository;
  List<CartModel> _cartItems = [];
  CartBloc({required this.appRepository,}) : super(CartInitialState()) {
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        final prefs = await SharedPreferences.getInstance();
        final cartJson = prefs.getStringList("cart");
        if (cartJson != null) {
          _cartItems = cartJson.map((item) => CartModel.fromJson(jsonDecode(item))).toList();
        }
        emit(CartLoadedState(cartItems: _cartItems, totalPrice: _calculateTotal()));
      } catch (e) {
        emit(CartErrorState(errMsg: e.toString()));
      }
    });

    on<AddCartEvent>((event,emit) {
      int index = _cartItems.indexWhere((item) => item.product.id == event.product.id);
      if (index != -1) {
        _cartItems[index].quantity++;
      } else {
        _cartItems.add(CartModel(product: event.product));
      }
      _saveCart();
      emit(CartLoadedState(cartItems: _cartItems, totalPrice: _calculateTotal()));

    });
    on<RemoveCartEvent>((event,emit){
      _cartItems.removeWhere((item) => item.product.id == event.product.id);
      _saveCart();
      emit(CartLoadedState(cartItems: _cartItems, totalPrice: _calculateTotal()));
    });
    on<QuantityUpdateCartEvent>((event,emit){
      int index = _cartItems.indexWhere((item) => item.product.id == event.product.id);
      if (index != -1) {
        _cartItems[index].quantity = event.quantity;
      }
      _saveCart();
      emit(CartLoadedState(cartItems: _cartItems, totalPrice: _calculateTotal()));

    });


  }
  double _calculateTotal() {
    return _cartItems.fold(0, (total, item) => total + (item.product.price! * item.quantity));
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = _cartItems.map((item) => jsonEncode(item.toJson())).toList();
    prefs.setStringList("cart", cartJson);
  }
}
