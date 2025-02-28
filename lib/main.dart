import 'package:ecommerce_task/view/dash_board_pages/bottom_nav_screen.dart';
import 'package:ecommerce_task/view_model/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_task/view_model/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_task/view_model/data/remote/api_helper.dart';
import 'package:ecommerce_task/view_model/data/repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
      MultiBlocProvider(providers: [
        BlocProvider(create: (context) => ProductBloc(appRepository: AppRepository(apiHelper: ApiHelper()))),
        BlocProvider(create: (context)=> CartBloc(appRepository: AppRepository(apiHelper: ApiHelper())))
        
      ], child: MyApp())
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  BottomNavScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


