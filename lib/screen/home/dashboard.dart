import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Material myItems(IconData icon, String titulo, int color){
    return Material(

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StaggeredGridView.count(crossAxisCount: 2,
      crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myItems(Icons.graphic_eq,"TotalViewa",0xffed622b)

          //myItems
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 130.0)
        ],
      ),
    );
  }
}
