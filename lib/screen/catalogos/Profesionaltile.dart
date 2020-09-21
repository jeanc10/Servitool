import 'package:servitools_app/models/userProfesionales.dart';
import 'package:flutter/material.dart';

class Profesionaltile extends StatelessWidget {
  final listProfesionales profesionales;
  Profesionaltile({ this.profesionales });



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green,
          ),
          title: Text(profesionales.nombreServicio),
          subtitle: Text(profesionales.ubicacion),
        ),
      ),

    );
  }
}
