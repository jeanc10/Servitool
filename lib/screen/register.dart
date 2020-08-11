import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:servitools_app/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email='',nombreUsuario='',apellido='',ubicacion='',nombreServicio='',orientacion='';
  String password='',direccion='';
  String error='';
  int telefono=0,rtn=0;

  bool _obscureText = true,tieneServicio=false,servicioDomicilio=false,poseeRtn=false;
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Registro'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),label: Text(''),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
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
                  onChanged: (val){
                    setState(() => email=val);
                  },
                  onSaved: (value) => email = value.trim(),
                ),
                SizedBox(height: 20.0),

                TextFormField(

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
                  onChanged: (val){
                    setState(() => password=val);
                  },
                  onSaved: (value) => password = value.trim(),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Nombres',
                      icon: Icon(
                        Icons.person,
                        color: Colors.green,
                      )),
                  validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
                  onChanged: (val){
                    setState(() => nombreUsuario=val);
                  },
                  onSaved: (value) => nombreUsuario = value.trim(),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Apellidos',
                      icon: Icon(
                        Icons.person,
                        color: Colors.green,
                      )),
                  validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
                  onChanged: (val){
                    setState(() => apellido=val);
                  },
                  onSaved: (value) => apellido = value.trim(),
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Ubicacion',
                      icon: Icon(
                        Icons.location_city,
                        color: Colors.green,
                      )),
                  validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
                  onChanged: (val){
                    setState(() => ubicacion=val);
                  },
                  onSaved: (value) => ubicacion = value.trim(),
                ),
                SizedBox(height: 20.0),
                Text('Tiene un servicio especializado que desea ofrecer?'),
                Switch(

                  value: tieneServicio,
                  onChanged: (value) {
                    setState(() {
                      tieneServicio = value;
                      print(tieneServicio);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.green,
                  child: Text('Unirse',style: TextStyle(color: Colors.white)),
                  onPressed: () async{
                  if(_formkey.currentState.validate()){
                    dynamic result= await _auth.registerWithEmailAndPass(email, password);
                    if(result== null){
                      setState(() => error = 'Ingrese un correo valido');
                    }else{ Navigator.pushNamed(context,'/home');}

                  }
                  },

                ),
                SizedBox(height: 12.0),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
              ],
            ),
          )
      ),
    );
  }
//  Widget showInfoEmpresa() {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
//      child: TextFormField(
//        maxLines: 1,
//        keyboardType: TextInputType.emailAddress,
//        autofocus: false,
//        decoration: InputDecoration(
//            hintText: 'Correo eléctronico',
//            icon: Icon(
//              Icons.email,
//              color: Colors.green,
//            )),
//        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
//        onSaved: (value) => _email = value.trim(),
//      ),
//    );
//  }
}
