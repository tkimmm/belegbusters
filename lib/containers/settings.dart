import 'package:flutter/material.dart';
import 'package:belegbusters/containers/cart.dart';
import 'package:belegbusters/containers/catalog.dart';

class AppSettings extends StatelessWidget {
  @override
  _returnPath(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(2), children: <Widget>[
      Container(
        height: 50,
        color: Colors.amber[600],
        child: const Center(child: Text('Alternative Menu Style')),
      ),
      FlatButton(
        child: Text('Catalog'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCatalog()),
          );
        },
      ),
    FlatButton(
        child: Text('Cart'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCart()),
          );
        },
      ),
    ]);
  }

  @override
  build(BuildContext context) {
    return _returnPath(context);
  }
}
