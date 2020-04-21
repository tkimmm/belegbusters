import 'package:belegbusters/containers/pdf/pdfpage.dart';
import 'package:flutter/material.dart';

import 'package:belegbusters/routing_constants.dart';
import 'package:belegbusters/containers/cart.dart';
import 'package:belegbusters/containers/catalog.dart';
import 'package:belegbusters/containers/main2.dart';
import 'package:belegbusters/containers/login.dart';

import 'package:camera/camera.dart';
import 'dart:async';
import 'package:belegbusters/containers/tf/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings);
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Login());
    case LoginRoute:
      return MaterialPageRoute(builder: (context) => MainBody());
    case CartRoute:
      return MaterialPageRoute(builder: (context) => MyCart());
    case CatalogRoute:
      return MaterialPageRoute(builder: (context) => MyCatalog());
    case DebugRoute:
      return MaterialPageRoute(builder: (context) => PdfPageTest());
    case MLRoute:
      main();
      return MaterialPageRoute(builder: (context) => HomePage(cameras));
    case 'pdf':
      return MaterialPageRoute(builder: (context) => MainBody());
    default:
      return MaterialPageRoute(builder: (context) => MainBody());
  }
}

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(cameras),
    );
  }
}
