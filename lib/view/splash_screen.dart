import 'dart:async';

import 'package:ecommerce_task/utils/ui_helper.dart';
import 'package:ecommerce_task/view/dash_board_pages/bottom_nav_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiHelper.darkGreyColor,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Icon(Icons.shopping_cart,size: 70,color: Colors.deepPurple,)),
        Center(child: Text('Mini-Ecommerce',style: mTextStyle22(mFontWeight: FontWeight.bold),))
      ],
    ),
    );
  }
}
