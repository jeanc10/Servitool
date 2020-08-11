import 'package:flutter/material.dart';
import 'package:servitools_app/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Servitools'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Cerrar Sesion'),
            onPressed: (){
              _auth.signOut();
              Navigator.pushNamed(context,'/login');
            },
          )
        ],
      ) ,
      );

  }
}