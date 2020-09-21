import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:servitools_app/models/register.dart';
import 'package:servitools_app/models/cuidades.dart';
import 'package:servitools_app/models/userProfesionales.dart';
import 'package:provider/provider.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference ServitoolsColletion = Firestore.instance.collection('register');
  final CollectionReference ServitoolsClienteColletion = Firestore.instance.collection('registerCliente');
  final CollectionReference ServitoolsListasColletion = Firestore.instance.collection('Listas');

  Future updateUserData(String uid, String nombreUsuario,
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
      'uid': uid,
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
  Future updateUserDataCliente(String uid, String nombreUsuario,
      String apellidos,
      String ubicacion,
      num telefono,
      DateTime fechaNacimiento
     ) async{
    return await ServitoolsClienteColletion.document(uid).setData({
      'uid': uid,
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
          nombreUsuario: doc.data['nombre'] ?? ''
      );
    }).toList();
  }
  ///Lista de profesionales
  List<listProfesionales> _registerlistProfesionalesfromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return listProfesionales(
          uid: doc.data['nombreUsuario'] ?? '' ,
          nombreUsuario: doc.data['nombreUsuario'] ?? '',
          apellidos: doc.data['apellidos'] ?? '',
          nombreServicio: doc.data['nombreServicio'] ?? '',
          orientacion: doc.data['orientacion'] ?? '',
          ubicacion: doc.data['ubicacion'] ?? '',
          direccion: doc.data['direccion'] ?? '',
          telefono: doc.data['telefono'] ?? '',
          domicilio: doc.data['domicilio'] ?? '',
          fundacion: doc.data['fundacion'] ?? '',
          calificacion: doc.data['calificacion'] ?? ''
      );
    }).toList();
  }
  ///fin

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
  Stream<List<listProfesionales>> get listaProfesionales{
    return ServitoolsColletion.snapshots()
        .map(_registerlistProfesionalesfromSnapshot);
  }
  getDataProfesionales() async{
    return await Firestore.instance.collection('register').getDocuments();
  }
}