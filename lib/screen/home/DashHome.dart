import 'package:flutter/material.dart';
import 'package:servitools_app/screen/home/homeDash.dart';
import 'package:servitools_app/services/auth.dart';
import 'package:servitools_app/services/database.dart';
import 'package:provider/provider.dart';
class DashHome_ extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _DashState();
  }
}
class _DashState extends State<DashHome_>{
  var _currentIndex=0;
  final AuthService _auth = AuthService();
  @override
  // TODO: implement widget
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Servitools'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Cerrar Sesion'),
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context, '/login');
            },
          )
        ],),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index){
        setState(() {
          _currentIndex= index;
        });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.settings),title: Text("Ajustes")),
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Nodefinido")),
        ],
      ),
      body: getBodyWidget(),
    );
    }

  getBodyWidget() {
    return (_currentIndex==0)? HomeDash():Container();
  }

  }
