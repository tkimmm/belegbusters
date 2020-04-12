import 'package:belegbusters/containers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:belegbusters/containers/nfc.dart' as nfcmodule;
import 'package:belegbusters/services/dataservice.dart';
import 'package:belegbusters/containers/menu.dart';
import 'package:belegbusters/containers/menu2.dart';
import 'package:belegbusters/containers/cart.dart';
import 'package:belegbusters/themes/theme.dart';

void main() => runApp(MainBody());

class MainBody extends StatelessWidget {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beleg Busters',
        theme: appTheme,
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DefaultTabController(
        length: 6,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: height / 5,
                floating: false,
                pinned: true,
                snap: false,
                actionsIconTheme: IconThemeData(opacity: 0.0),
                flexibleSpace: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        "./images/Fruits.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    isScrollable: true,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                      icon: Icon(Icons.local_dining),
                      ),
                      Tab(
                        icon: Icon(Icons.local_dining),
                      ),
                      Tab(
                        icon: Icon(Icons.restaurant_menu),
                      ),
                      Tab(
                        icon: Icon(Icons.nfc),
                      ),
                      Tab(
                        icon: Icon(Icons.cloud_download),
                      ),
                      Tab(
                        icon: Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              MenuItems(),
              Menu2(),
              MyCatalog(),
              Center(
                child: nfcmodule.RFIDReader(),
              ),
              DataService(),
              MyCart()
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(child: _tabBar, color: Colors.white);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
