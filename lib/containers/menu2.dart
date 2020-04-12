import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/catalog.dart';
void main() => runApp(Menu2());

class Menu2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Item Description'),
          StackMenu(1, 'images/Burger.jpg', 'Beef Burger'),
          StackMenu(2, 'images/Paella.jpg', 'Seafood Paella'),
          StackMenu(3, 'images/Pasta.jpg', 'Pasta'),
          StackMenu(4, 'images/Steak.jpg', 'Sirloin Steak'),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return FlatButton(
      onPressed: cart.items.contains(item) ? null : () => cart.add(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    );
  }
}

class StackMenu extends StatelessWidget {
  final String imagePath;
  final String description;
  final int index;

  StackMenu(this.index, this.imagePath, this.description);

  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    var catalog = Provider.of<CatalogModel>(context);
    var item = catalog.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.title;
    return Stack(
      children: <Widget>[
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            imagePath,
            height: 300,
            width: 640,
            fit: BoxFit.fill,
          ),
          margin: EdgeInsets.all(0),
          elevation: 0.0,
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          width: 640,
          height: 300,
          alignment: Alignment.bottomRight,
          child: Card(
            elevation: 8.0,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                cart.items.contains(item) ? null : () => cart.add(item);
              },
              child: Container(
                width: 25,
                height: 25,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
