import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servitools_app/models/register.dart';


class RegisterList extends StatefulWidget {
  @override
  _RegisterListState createState() => _RegisterListState();
}

class _RegisterListState extends State<RegisterList> {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<List<Register>>(context);
    //print(register.documents);
//    for(var doc in register.documents){
//      print(doc.data);
//    }
    register.forEach((Register) { 
      print(Register.nombre);
      print(Register.password);
    });
    return Container();
  }
}
