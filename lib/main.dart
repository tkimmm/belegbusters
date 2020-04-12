import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:belegbusters/models/cart.dart';
import 'package:belegbusters/models/catalog.dart';
import 'package:belegbusters/containers/cart.dart';
import 'package:belegbusters/containers/catalog.dart';
import 'package:belegbusters/containers/main2.dart';
import 'package:belegbusters/containers/login.dart';
import 'package:belegbusters/themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'test',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/main': (context) => MainBody(),
          '/cart': (context) => MyCart(),
          '/catalog': (context) => MyCatalog(),
        },
      ),
    );
  }
}