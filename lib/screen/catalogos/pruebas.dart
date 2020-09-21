import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servitools_app/models/userProfesionales.dart';
import 'package:provider/provider.dart';
import 'package:servitools_app/services/database.dart';
class profesionalesList extends StatefulWidget {
  @override
  _profesionalesListState createState() => _profesionalesListState();
}

class _profesionalesListState extends State<profesionalesList> {
  //DatabaseService crudObj = new DatabaseService();
  QuerySnapshot profesionales;
@override
  void initState(){
    getDataProfesional().then((result){
    setState(() {
      profesionales=result;
    });

    });
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: GridView.builder(
          itemCount: profesionales.documents.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/2)
          ),
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  //Image.asset(images[index],height: 50,width: 50,),
                  Padding(
                    padding: EdgeInsets.all(22),
                    child: Text(profesionales.documents[index].data['nombreUsuario'], style: TextStyle(fontSize: 20,height: 1.2,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                    ,

                  ),

                ],
              ),
            );
          }
      ),
    );
  }
  getDataProfesional() async{
    return await Firestore.instance.collection('register').where('orientacion',isEqualTo: 'electricidad').getDocuments();
  }
}
