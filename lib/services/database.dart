import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:servitools_app/models/register.dart';
import 'package:servitools_app/models/cuidades.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference ServitoolsColletion = Firestore.instance.collection('register');
  final CollectionReference ServitoolsClienteColletion = Firestore.instance.collection('registerCliente');
  final CollectionReference ServitoolsListasColletion = Firestore.instance.collection('Listas');

  Future updateUserData( String nombreUsuario,
      String apellidos,
      String ubicacion,
      String nombreServicio,
      String orientacion,
      num telefono,
      DateTime fundacion,
      String direccion,
      num rtn,
      bool domicilio) async{
    return await ServitoolsColletion.document(uid).setData({
      'nombreUsuario' : nombreUsuario,
      'apellidos' : apellidos,
      'ubicacion' : ubicacion ,
      'nombreServicio': nombreServicio ,
      'orientacion': orientacion,
      'telefono': telefono ,
      'fundacion': fundacion ,
      'direccion': direccion ,
      'rtn': rtn,
      'domicilio': domicilio

    });
  }
  Future updateUserDataCliente( String nombreUsuario,
      String apellidos,
      String ubicacion,
      num telefono,
      String fechaNacimiento
     ) async{
    return await ServitoolsClienteColletion.document(uid).setData({
      'nombreUsuario' : nombreUsuario,
      'apellidos' : apellidos,
      'ubicacion' : ubicacion ,
      'telefono': telefono ,
      'Fecha_Nacimiento': fechaNacimiento ,

    });
  }
  //list form snapshot
  List<Register> _registerlistfromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Register(
        nombre: doc.data['nombre'] ?? '',
        password: doc.data['password'] ?? ''
      );
    }).toList();
  }

  List<ListaCuidades> _listCuidadfromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return ListaCuidades(
          ID: doc.data['ID'] ?? '',
          categoria: doc.data['categoria'] ?? '',
          valor: doc.data['valor'] ?? ''
      );
    }).toList();
  }



  // get data
  Stream<List<Register>> get register{
    return ServitoolsColletion.snapshots()
    .map(_registerlistfromSnapshot);
  }

  Stream<List<ListaCuidades>> get listaCuidades{
    return ServitoolsListasColletion.snapshots()
        .map(_listCuidadfromSnapshot);
  }
}