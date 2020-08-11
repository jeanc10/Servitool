import 'package:flutter/material.dart';
import 'package:servitools_app/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignIn  createState() => _SignIn();

}

class _SignIn extends State<SignIn> {
  final AuthService _auth = AuthService();

  //Text field
  String email='';
  String password='';
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Unirse a Servitools'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
          TextFormField(
            onChanged: (val){
              setState(() => email=val);
            },
              ),
              SizedBox(height: 20.0),

              TextFormField(
                obscureText: true,
                onChanged: (val){
                  setState(() => password=val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.green,
                child: Text('Unirse',style: TextStyle(color: Colors.white)),
                onPressed: () async{
                print(email);
                print(password);
                },

              )
            ],
          ),
        )
      ),
    );
  }
}