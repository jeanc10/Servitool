import 'package:flutter/material.dart';

class prueba extends StatelessWidget{
  var services=[
    "Fontaneria",
    "Electricista",
    "Refrigeracion",
    "Llantera",
    "Mecanica",
    "Construcion",
  ];
  var images=[
    "assents/fontanero.png",
    "assents/electricista.png",
    "assents/aire-acondicionado.png",
    "assents/llantas.png",
    "assents/mecanico.png",
    "assents/hombrefontanero.png"
  ];
  @override

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(6),
      child: GridView.builder(
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/2)
          ),
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(images[index],height: 50,width: 50,),
                  Padding(
                    padding: EdgeInsets.all(22),
                    child: Text(services[index], style: TextStyle(fontSize: 20,height: 1.2,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                    ,

                  ),

                ],
              ),
            );
          }
      ),
    );
  }
}