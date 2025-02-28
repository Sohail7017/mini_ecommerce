import 'package:ecommerce_task/models/cart_model.dart';
import 'package:ecommerce_task/utils/ui_helper.dart';
import 'package:ecommerce_task/view_model/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  MediaQueryData? mqData;



  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: UiHelper.darkGreyColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: mqData!.size.height * 0.18,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mqData!.size.height * 0.040,
                    ),
                    Text('Cart',
                      style: mTextStyle20(mFontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: mqData!.size.height * 0.72,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: mqData!.size.height * 0.030,
                  ),



                  /// CART ITEM SECTION
                  Expanded(
                    child: BlocBuilder<CartBloc, CartState>(builder: (_, state) {
                      if (state is CartLoadingState) {
                        return Center(child: CircularProgressIndicator(),);
                      } else if (state is CartErrorState) {
                        return Center(child: Text(state.errMsg),);
                      } else if (state is CartLoadedState) {
                        return ListView.builder(
                            itemCount: state.cartItems.length,
                            itemBuilder: (_, index) {
                              var eachCart = state.cartItems[index];
                              return cartUi(
                                  productImage: eachCart.product.image!,
                                  productTitle: eachCart.product.title!,
                                  price: eachCart.product.price.toString(),
                                  quantity: eachCart.quantity,
                                  onIncrement: (){
                                    context.read<CartBloc>().add(QuantityUpdateCartEvent(product: eachCart.product, quantity: eachCart.quantity + 1));


                                  },
                                  onDecrement: (){
                                    if (eachCart.quantity > 1) {
                                      context.read<CartBloc>().add(QuantityUpdateCartEvent(product: eachCart.product, quantity: eachCart.quantity - 1));
                                    }

                    
                                  },
                                  onDelete: (){context.read<CartBloc>().add(RemoveCartEvent(product: eachCart.product));
                                  });
                            });
                      }
                      return Container();
                    }),
                  )

                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              height: mqData!.size.height * 0.080,
              color: UiHelper.darkGreyColor,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        double totalPrice = 0.0;  // Default total price
                        if (state is CartLoadedState) {
                          totalPrice = state.totalPrice; // Get total from state
                        }
                        return Text('Total \$ ${totalPrice.toStringAsFixed(2)}',
                          style: mTextStyle16(),
                        );
                      },
                    ),
                      SizedBox(
                        width: mqData!.size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            // Checkout action
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple
                          ),
                          child: Text(
                            'Check out',
                            style: mTextStyle14(mColor: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cartUi({required String productImage,
    required String productTitle,
    required String price,
    required int quantity,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    required VoidCallback onDelete,
  }) {
    return Container(
      height: mqData!.size.height * 0.16,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Row(

          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: UiHelper.darkGreyColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Center(child: Image.network(
                productImage, width: 75, height: 75, fit: BoxFit.fill,)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productTitle, style: mTextStyle14(),),
                    Text('\$ ${price}',
                      style: mTextStyle14(mFontWeight: FontWeight.w600),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: mqData!.size.width * 0.25,
                          height: mqData!.size.height * 0.030,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: onDecrement,
                                  child: Image.asset(
                                    'assets/images/decrement.png', height: 24,
                                    width: 24, color: Colors.red,),
                                ),
                                Container(
                                  height: 30,
                                  width: 2,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  quantity.toString(), style: mTextStyle14(),),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 30,
                                  width: 2,
                                  color: Colors.grey.shade300,
                                ),
                                InkWell(
                                    onTap: onIncrement,
                                    child: Icon(
                                      Icons.add, color: Colors.green,))

                              ],
                            ),
                          ),
                        ),

                        InkWell(
                            onTap: onDelete,
                            child: Icon(Icons.delete, color: Colors.red,))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
