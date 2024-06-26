import 'package:assingment/provider/auth_provider.dart';
import 'package:assingment/provider/cart_provider.dart';
import 'package:assingment/provider/product_provider.dart';
import 'package:assingment/screens/Login_screen.dart';
import 'package:assingment/screens/check_out.dart';
import 'package:assingment/screens/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FakeStore App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          ProductListingScreen.routeName: (ctx) => ProductListingScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
        },
      ),
    );
  }
}
