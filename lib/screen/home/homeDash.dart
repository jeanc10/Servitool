import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeDash  extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _HomeDashState();
  }
}
class _HomeDashState extends State<HomeDash> {
  Widget build(BuildContext context) {
    var services = [
      "Fontaneria",
      "Electricista",
      "Refrigeracion",
      "Llantera",
      "Mecanica",
      "Construcion",
    ];
    var images = [
      "assents/fontanero.png",
      "assents/electricista.png",
      "assents/aire-acondicionado.png",
      "assents/llantas.png",
      "assents/mecanico.png",
      "assents/hombrefontanero.png"
    ];
    var myGridView = new GridView.builder(
      itemCount: services.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            child: new Column(
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
          ),
          onTap: () {
            Dirigir(index);
          },
        );
      },
    );
    return new Scaffold(
      body: myGridView,
    );
  }
  Dirigir(int indexs){
    if(indexs==0){
      Navigator.pushNamed(context,'/fontaneria');
    }
    else if(indexs==1){
      Navigator.pushNamed(context,'/electricidad');
    }
    else if(indexs==2){
      Navigator.pushNamed(context,'/refrigeracion');
    }

  }
}