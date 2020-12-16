import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/rating/gf_rating.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class ScreenFontaneria extends StatefulWidget {
  @override
  _ScreenFontaneriaState createState() => _ScreenFontaneriaState();
}

class _ScreenFontaneriaState extends State<ScreenFontaneria> {
  //DatabaseService crudObj = new DatabaseService();
  var images = [
    "assents/fontanero.png",
    "assents/electricista.png",
    "assents/aire-acondicionado.png",
    "assents/llantas.png",
    "assents/mecanico.png",
    "assents/hombrefontanero.png"
  ];
  QuerySnapshot profesionales;
  double _rating=1;
  final _ratingController = TextEditingController();
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
    return Scaffold( appBar: AppBar(
      title: Text('Refrigeracion'),
      centerTitle: true,
      backgroundColor: Colors.green,

    ),
        body: Stack(
          children: <Widget>[
            show(),
          ],
        )
    );
  }
  Widget show() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: GridView.builder(
          itemCount: profesionales.documents.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/2)
          ),
          itemBuilder: (BuildContext context, int index){
            return Card(
              margin: const EdgeInsets.only(left: 46.0,right: 46.0,bottom: 30.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color:Colors.blue ,
              shadowColor: Colors.black12,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Image.asset(images[index],height: 50,width: 50,),
                  Padding(padding: EdgeInsets.all(8)),
                  Text('Usuario: ' + profesionales.documents[index].data['nombreUsuario'] + ' ' + profesionales.documents[index].data['apellidos'],
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  Text('Nombre servicio: ' + profesionales.documents[index].data['nombreServicio'],
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  Text('Ubicacion: ' + profesionales.documents[index].data['ubicacion'],
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  Text('Direccion: ' + profesionales.documents[index].data['direccion'],
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  Text('Fundacion: ' + DateFormat('dd/MM/yyyy').format(profesionales.documents[index].data['fundacion'].toDate()),
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  Text('Telefono: ' + profesionales.documents[index].data['telefono'].toString(),
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  Text((profesionales.documents[index].data['domicilio'].toString())=='false' ? 'Servicio domicilio: No': 'Servicio domicilio: Si',
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  Text('RTN: ' + profesionales.documents[index].data['rtn'].toString(),
                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontWeight: FontWeight.w500)),
                  GFRating(
                    color: Colors.yellow,
                    value: double.tryParse(profesionales.documents[index].data['calificacion']),

                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)) ,
                    color: Colors.white,
                    onPressed: (){
                      _openPopup(context);
                    },

                    child: Text('Calificar'),
                  )

                ],
              ),
            );
          }
      ),
    );
  }
  getDataProfesional() async{
    return await Firestore.instance.collection('register').where('orientacion',isEqualTo: 'Fontaneria').getDocuments();
  }
  _openPopup(context) {
    showDialog(
      context: context,
      builder: (context) {
        String contentText = "Segun la experiencia en el servicio brindado";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0), ) ,
              title: Text("Califica al profesional", style: TextStyle(fontWeight: FontWeight.bold ),),
              content: Text(contentText),
              actions: <Widget>[
                GFRating(
                  controller: _ratingController,
                  color: Colors.yellow,
                  value: _rating,
                  onChanged: (value){
                    setState(() {
                      _rating=value;

                    });
                  },
                ),
                DialogButton(
                  onPressed: () {
                    print(_rating);
                    Navigator.pop(context);},
                  child: Text(
                    "Enviar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]
              ,
            );
          },
        );
      },
    );
  }
}
