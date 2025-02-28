import 'package:ecommerce_task/models/product_model.dart';

class CartModel {
  ProductModel product;
  int quantity;

  CartModel({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "quantity": quantity,
  };

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductModel.fromJson(json["product"]),
      quantity: json["quantity"],
    );
  }
}
