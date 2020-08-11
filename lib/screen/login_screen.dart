import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servitools_app/screen/sign_in.dart';
import 'package:servitools_app/services/auth.dart';
class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
final _formKey = GlobalKey<FormState>();
final AuthService _auth = AuthService();
  String _email;
  String _password;
  String _errorMessage;
  final _passwordController = TextEditingController();

  bool _isLoading;
  bool _obscureText = true;
  bool _isLoginForm= false;
final SignIn _signIn = SignIn();
bool validateAndSave() {
  final form = _formKey.currentState;
  if (form.validate()) {
    form.save();
    return true;
  }
  setState(() {
    _isLoading = false;
  });

  return false;
}
Future validateAndSubmit() async {
  setState(() {
    _errorMessage = "";
    _isLoading = true;
  });
  if (validateAndSave()) {
    try {
      if(_formKey.currentState.validate()){
        dynamic result= await _auth.signinWithEmailAndPass(_email, _password);
        if(result==null){
          setState(() => _errorMessage = 'Cuenta invalida');
          Fluttertoast.showToast(
              msg: _errorMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }else{Navigator.pushNamed(context,'/home');}

      }


    } catch (e) {
      _passwordController.clear();
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _isLoading = false;
        _password = "";
      });
    }

      setState(() {
        _isLoading = false;
      });

  }
}
@override
void dispose() {
  _passwordController.dispose();
  super.dispose();
}

@override
void initState() {
  _errorMessage = "";
  _isLoading = false;
  super.initState();
}

void resetForm() {
  _formKey.currentState.reset();
  _errorMessage = "";
}

Widget _showCircularProgress() {
  if (_isLoading) {
    return Center(child: CircularProgressIndicator());
  }
  return Container(
    height: 0.0,
    width: 0.0,
  );
}
  @override
  Widget build(BuildContext context){
    return Scaffold( appBar: AppBar(
      title: Text('ServiTools - Login'),
      centerTitle: true,
      backgroundColor: Colors.brown,
    ),
      body: Stack(
        children: <Widget>[
          _showForm(context),
          _showCircularProgress(),
        ],
      )
    );
  }
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.bold),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
  Widget _showForm(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showtitle(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(context),
              showSecondButton(context)
             // showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80.0,
          child: Image.asset('assents/herramienta.jpg'),
        ),
      ),
    );
  }
  Widget showtitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
        child: Text('Bienvenido - tu especialista a tu alcance'
    ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), textAlign: TextAlign.center,
          )

      );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Correo eléctronico',
            icon: Icon(
              Icons.email,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        controller: _passwordController,
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Contaseña',
            icon: Icon(
              Icons.lock,
              color: Colors.green,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                 _obscureText = !_obscureText;
               });
             },
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showPrimaryButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.green,
            child: Text('Iniciar sesión',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
  Widget showSecondButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.green,
            child: Text('Registrarse',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: enviaregistrar
          ),
        ));
  }
  void toggleFormMode() {
    //resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }
  Future enviaregistrar() async {
    Navigator.pushNamed(context,'/definirUsuario');
  }

}