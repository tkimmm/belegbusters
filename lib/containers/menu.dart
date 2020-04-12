import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  Widget _buildMenuItems() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.orange[100 * (index % 9)],
                child: Text('Beleg Buster Menu Item $index'),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return _buildMenuItems();
  }
}
