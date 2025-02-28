part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

 class ProductInitialState extends ProductState {}
 class ProductLoadingState extends ProductState {}
 class ProductLoadedState extends ProductState {
  List<ProductModel> productModel;
  ProductLoadedState({required this.productModel});
 }
 class ProductErrorState extends ProductState {
  String errorMsg;
  ProductErrorState({required this.errorMsg});
 }
