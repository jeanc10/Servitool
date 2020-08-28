import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:servitools_app/screen/sign_in.dart';
import 'package:servitools_app/services/auth.dart';
import 'globals.dart' as globals;
import 'package:servitools_app/extensions.dart';
class Register extends StatefulWidget{
  @override

  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email='',nombreUsuario='',apellido='',ubicacion='',nombreServicio='',orientacion='';
  String password='',direccion='',error='',fundacion='o';
  num telefono,rtn;
  String _errorMessage;
  bool _obscureText = true,servicioDomicilio=false,poseeRtn=false;
  final _passwordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  TextEditingController _dateEditingController = TextEditingController();
  bool _isLoading;
  bool _isLoginForm= false;
  List<String> _Cuidades=<String>[
    'El progreso','San pedro Sula','Tegucigalpa'
  ];


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
          dynamic result= await _auth.registerWithEmailAndPass(
              email,
              password,
              nombreUsuario,
              apellido,
              ubicacion,
              telefono,
              'fecha'
          );
          if(result== null){
            setState(() => _errorMessage = 'Cuenta invalida');
            Fluttertoast.showToast(
                msg: _errorMessage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }else{ Navigator.pushNamed(context,'/home');}

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
    _nombreController.dispose();
    _nombreController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

//  void resetForm() {
//    _formKey.currentState.reset();
//    _errorMessage = "";
//  }

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
      title: Text('ServiTools - Unirse'),
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
              showEmailInput(),
              showPasswordInput(),
              showNombreInput(),
              showApellidoInput(),
              showUbicacionInput(),

              showTelefonoInput(),
              //showFechaFundacionInput(),

              showPrimaryButton(context),
              showErrorMessage(),
            ],
          ),
        ));
  }


  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        //autofocus: false,
        decoration: InputDecoration(
            hintText: 'Correo eléctronico',
            icon: Icon(
              Icons.email,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => email = value.trim(),
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
        //autofocus: false,
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
        onSaved: (value) => password = value.trim(),
      ),
    );
  }
  Widget showNombreInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        controller: _nombreController,
        maxLines: 1,
        keyboardType: TextInputType.text,
//        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Nombre',
            icon: Icon(
              Icons.person,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => nombreUsuario = value.trim(),
      ),
    );
  }
  Widget showApellidoInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        //autofocus: false,
        decoration: InputDecoration(
            hintText: 'Apellidos',
            icon: Icon(
              Icons.person,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => apellido = value.trim(),
      ),
    );
  }
  Widget showUbicacionInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        //autofocus: false,
        decoration: InputDecoration(
            hintText: 'Ubicacion',
            icon: Icon(
              Icons.location_city,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => ubicacion = value.trim(),
      ),
    );
  }

  Widget showTelefonoInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        controller: _telefonoController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        // autofocus: false,
        decoration: InputDecoration(
            hintText: 'Telefono',
            icon: Icon(
              Icons.phone,
              color: Colors.green,
            )),
        validator: (value) => value.length<1 ? 'El telefono debe tener mas digitos' : null,
        onSaved: (value) => telefono = num.parse(value)
      ),
    );
  }
//  Widget showFechaFundacionInput() {
//    return Padding(
//        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//        child:
//        TextFormField(
//          readOnly: false,
//          controller: _dateEditingController,
//          decoration:
//          InputDecoration(hintText: 'Fecha de fundacion',prefixIcon: Icon(Icons.calendar_today)),
//          onTap: () async {
//            var date = await showDatePicker(
//                context: context,
//                initialDate: DateTime.now(),
//                firstDate: DateTime(1970),
//                lastDate: DateTime.now());
//
//            _dateEditingController.text = date.plainText();
//
//            print(date.plainText());
//          },
//        ));
//  }




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
            child: Text('Unirse',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }

//  void toggleFormMode() {
//    //resetForm();
//    setState(() {
//      _isLoginForm = !_isLoginForm;
//    });
//  }

}