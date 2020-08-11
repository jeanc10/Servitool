import 'package:flutter/material.dart';
import 'package:servitools_app/models/user.dart';
import 'package:servitools_app/screen/home/_home.dart';
import 'package:servitools_app/screen/authentication.dart';
import 'package:provider/provider.dart';
import 'package:servitools_app/screen/login_screen.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final user= Provider.of<User>(context);
    print(user);
    if(user==null){
      return LoginScreen();
    }
    else{
      return HomePage();
    }
  }
}