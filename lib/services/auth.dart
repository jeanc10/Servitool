import 'package:firebase_auth/firebase_auth.dart';
import 'package:servitools_app/models/user.dart';

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

  // register in with email y pass
  Future registerWithEmailAndPass(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userFromFireBaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

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