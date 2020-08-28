import 'package:firebase_auth/firebase_auth.dart';
import 'package:servitools_app/models/user.dart';
import 'package:servitools_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj
  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid): null;
  }
  // auth change user steam
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFireBaseUser);
  }

  // sign in with email y pass
    Future signInAnon() async {
      try{
        AuthResult result = await _auth.signInAnonymously();
        FirebaseUser user = result.user;
        return _userFromFireBaseUser(user);
      }catch(e){
        print(e.toString());
        return null;

      }
    }
  // Sign in
  Future signinWithEmailAndPass(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;


      return _userFromFireBaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register in with email y pass cliente
  Future registerWithEmailAndPass(String email,
      String password,
      String nombreUsuario,
      String apellidos,
      String ubicacion,
      num telefono,
      String fechanacimiento    ) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      await DatabaseService(uid: user.uid).updateUserDataCliente(nombreUsuario, apellidos, ubicacion, telefono, fechanacimiento);
      return _userFromFireBaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // register in with email y pass empresa
  Future registerWithEmailAndPasswordEmpresa(String email,
      String password,
      String nombreUsuario,
      String apellidos,
      String ubicacion,
      String nombreServicio,
      String orientacion,
      num telefono,
      DateTime fundacion,
      String direccion,
      num rtn,
      bool domicilio

      ) async{
    try{
      print('entro1');
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('entro2');
      FirebaseUser user=result.user;
      print('entro3');
      await DatabaseService(uid: user.uid).updateUserData(nombreUsuario, apellidos, ubicacion, nombreServicio, orientacion, telefono, fundacion, direccion, rtn,domicilio);
      print('entro4');
      return _userFromFireBaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //Registar datos adicionales


  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}