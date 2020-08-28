import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servitools_app/services/auth.dart';
import 'package:servitools_app/services/database.dart';
import 'package:provider/provider.dart';

import 'package:servitools_app/screen/home/register_list.dart';
import 'package:servitools_app/models/register.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Register>>.value(
        value: DatabaseService().register,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Servitools'),
            backgroundColor: Colors.brown[400],
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
            ],
          ),
          body: Stack(
            children: <Widget>[
              _showForm(context),
              //_showCircularProgress(),
            ],
          ),
        ));
  }

  Widget _showForm(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[


              showPrimaryButton(context),
              showSecondButton(context),
              showThirdButton(context)
              //  showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showPrimaryButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.green,
            child: Text('Fontaneria',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {},
          ),
        ));
  }

  Widget showSecondButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.green,
            child: Text('Electricidad',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {},
          ),
        ));
  }
  Widget showThirdButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.green,
            child: Text('Hogar',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {},
          ),
        ));
  }
}
