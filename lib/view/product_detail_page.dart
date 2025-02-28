import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/utils/ui_helper.dart';
import 'package:ecommerce_task/view/dash_board_pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/blocs/cart_bloc/cart_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  ProductModel productData;
   ProductDetailPage({required this.productData});

   MediaQueryData? mqData;

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0,left: 14,right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios)),
                SizedBox(
                  height: mqData!.size.height*0.04,
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                      child: Center(child: Image.network(productData.image!,width: 250,height: 250,fit: BoxFit.fill,))),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: mqData!.size.height*0.55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
              child: Stack(
                children: [
                  Positioned(
                    top:0,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: mqData!.size.height * 0.55, // Ensure it gets height
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productData.title!,style: mTextStyle14(mFontWeight: FontWeight.w600),),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                spacing: 5,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('\u{20B9} ${productData.price}',style: mTextStyle14(mFontWeight: FontWeight.w600),),

                                      Spacer(),
                                  Image.asset('assets/images/rating.png',width: 24,height: 24,),
                                  Text("${productData.rating!.rate!}",style: mTextStyle12(),),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text('${productData.rating!.count} Rating count',style: mTextStyle12(),),
                                ],
                              ),

                              const SizedBox(
                              height: 40,
                              ),

                              Text(productData.description.toString(),style: mTextStyle14(),),





                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: mqData!.size.width/7.5,
                    child: SizedBox(
                        width: mqData!.size.width*0.7,
                        child: ElevatedButton(onPressed: (){
                          context.read<CartBloc>().add(AddCartEvent(product: productData));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to cart!")));

                        }, child: Text('Add to Cart',style: mTextStyle14(mColor: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
