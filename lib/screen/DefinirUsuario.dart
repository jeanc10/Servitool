import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals.dart' as globals;

class DefinirUsuario extends StatefulWidget{
  @override
  _DefinirUsuarioState createState() => _DefinirUsuarioState();
}
class _DefinirUsuarioState extends State<DefinirUsuario> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading=false;
  String _errorMessage='';
  @override


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
      title: Text('ServiTools - Definir Usuario'),
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
              showtitle(),
              showLogoCliente(),
              showPrimaryButton(context),
              showLogoEmprendedor(),
              showSecondButton(context)
              // showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showLogoCliente() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80.0,
          child: Image.asset('assents/usuario.jpg'),
        ),
      ),
    );
  }
  Widget showLogoEmprendedor() {
    return Hero(
      tag: 'hero1',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80.0,
          child: Image.asset('assents/tools1.jpg'),
        ),
      ),
    );
  }
  Widget showtitle() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
        child: Text('Define como deseas registrarte'
          ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), textAlign: TextAlign.center,
        )

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
            child: Text('Registrarse como cliente final',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: enviarClienteFinal,
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
              child: Text('Registrarse como emprendedor',
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: enviarEmpresa
          ),
        ));
  }

  Future enviarClienteFinal() async {
    globals.isUser='clienteFinal';
    Navigator.pushNamed(context,'/registerUsuario');
  }
  Future enviarEmpresa() async {
    globals.isUser='Emprendedor';
    Navigator.pushNamed(context,'/registerEmpresa');
  }

}