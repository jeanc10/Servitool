import 'package:flutter/material.dart';
import 'package:servitools_app/models/user.dart';
import 'package:servitools_app/screen/login_screen.dart';
import 'package:servitools_app/screen/register_user.dart';
import 'package:servitools_app/screen/register.dart';
import 'package:servitools_app/screen/DefinirUsuario.dart';
import 'package:servitools_app/screen/home/_home.dart';
import 'package:servitools_app/screen/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:servitools_app/services/auth.dart';
import 'package:servitools_app/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          "/login" : (BuildContext context) => LoginScreen(),
          "/registerUsuario" : (BuildContext context) => Registeruser(),
          "/home" : (BuildContext context) => HomePage(),
          "/registerEmpresa" : (BuildContext context) => HomePage(),
          "/definirUsuario" : (BuildContext context) => DefinirUsuario(),

        } ,
        home: Wrapper(),
      )

      );

  }
}
