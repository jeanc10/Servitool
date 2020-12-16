import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:servitools_app/services/auth.dart';
class Registeruser extends StatefulWidget{
  @override

  _RegisteruserState createState() => _RegisteruserState();
}
class _RegisteruserState extends State<Registeruser> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email='',nombreUsuario='',apellido='',ubicacion='',nombreServicio='',orientacion='';
  String password='',direccion='',error='',fundacion='o';
  int telefono,rtn;
  String _errorMessage;
  bool _obscureText = true,servicioDomicilio=false,poseeRtn=false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _rtnController = TextEditingController();
  final _apellidos = TextEditingController();
  final _ubicacion= TextEditingController();
  final _nombreservicio= TextEditingController();
  TextEditingController _dateEditingController = TextEditingController();
  DateTime _fechafundacion = DateTime.now();



  bool _isLoading;

  bool _isLoginForm= false;
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
          dynamic result= await _auth.registerWithEmailAndPasswordEmpresa(
              email,
              password,
              nombreUsuario,
              apellido,
              ubicacion,
              nombreServicio,
              orientacion,
              telefono,
              _fechafundacion,
              direccion,
              rtn,
              servicioDomicilio,

          );
          if(result== null){

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
    _emailController.dispose();
    _passwordController.dispose();
    _nombreController.dispose();
    _apellidos.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _rtnController.dispose();
    _ubicacion.dispose();
    _nombreservicio.dispose();
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
              showNombreServicioInput(),
              showOrientacionInput(),
              showTelefonoInput(),
              showFechaFundacionInput(context),
              //_getDatePickerEnabled(),
              showDireccionInput(),
              showRTNInput(),
              showSelectorImagen(context),
              showDomicilioInput(),
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
        controller: _emailController,
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
        controller: _apellidos,
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
        controller: _ubicacion,
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
  Widget showNombreServicioInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        controller: _nombreservicio,
        maxLines: 1,
        keyboardType: TextInputType.text,
      //  autofocus: false,
        decoration: InputDecoration(
            hintText: 'Nombre del servicio',
            icon: Icon(
              Icons.business,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => nombreServicio = value.trim(),
      ),
    );
  }
  Widget showOrientacionInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
       // autofocus: false,
        decoration: InputDecoration(
            hintText: 'Especialidad del servicio',
            icon: Icon(
              Icons.pan_tool,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => orientacion = value.trim(),
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
        onSaved: (value) => telefono = num.parse(value),
      ),
    );
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fechafundacion,
        firstDate: DateTime.now(),
        lastDate: DateTime(1970),
        builder: (context,child){
          return SingleChildScrollView(child: child);
        }

    );
    if(picked!=null){
      setState(() {
        _fechafundacion=picked;
      });
    }
  }
  Widget showFechaFundacionInput(BuildContext context) {
    String _formateDate = new DateFormat.yMMMd().format(_fechafundacion);

    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child:
        TextFormField(
          readOnly: false,
          controller: _dateEditingController,
          decoration:
          InputDecoration(hintText: 'Fundacion: $_formateDate' ,prefixIcon: Icon(Icons.calendar_today)),
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime.now());
            if(date!=null){
              setState(() {
                _fechafundacion=date;
              });
            }
          },
        ));
  }
  Widget showSelectorImagen(BuildContext context)  {
    final picker = ImagePicker();

    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child:
        TextFormField(
          readOnly: false,
          controller: _dateEditingController,
          decoration:
          InputDecoration(hintText: 'Foto de perfil'),
          onTap: () async {
            final pickedFile = await picker.getImage(source: ImageSource.gallery);
          },
        ));
  }
//  Widget _getDatePickerEnabled() {
//    return InkWell(
//      onTap: () {
//        _selectDate(context);
//      },
//      child: InputDecorator(
//        decoration: InputDecoration(labelText: 'Fecha', enabled: true),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          mainAxisSize: MainAxisSize.max,
//          children: <Widget>[
//            Text(
//              DateFormat.yMMMd().format(_fechafundacion),
//            ),
//            Icon(Icons.arrow_drop_down,
//                color: Theme.of(context).brightness == Brightness.light
//                    ? Colors.grey.shade700
//                    : Colors.white70),
//          ],
//        ),
//      ),
//    );
//  }
//  Future<void> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: _fechafundacion,
//        firstDate: DateTime.now(),
//        lastDate: DateTime(1970));
//    }


  String _notEmptyField(String value) {
    if (value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  Widget showDireccionInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        controller: _direccionController,
        maxLines: 1,
        keyboardType: TextInputType.text,
      //  autofocus: false,
        decoration: InputDecoration(
            hintText: 'Direccion',
            icon: Icon(
              Icons.directions,
              color: Colors.green,
            )),
        validator: (value) => value.isEmpty ? 'El campo es requerido' : null,
        onSaved: (value) => direccion = value.trim(),
      ),
    );
  }
  Widget showRTNInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        controller: _rtnController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        //autofocus: false,
        decoration: InputDecoration(
            hintText: 'RTN',
            icon: Icon(
              Icons.card_membership,
              color: Colors.green,
            )),
        validator: (value) => value.length<1 ? 'El RTN debe tener mas digitos' : null,
        onSaved: (value) => rtn = num.parse(value),
      ),
    );
  }
  Widget showDomicilioInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),

      child: Column(
      children: <Widget>[
        Text('Posee servicio a domicilio?'),
        Switch(

        value: servicioDomicilio,
    onChanged: (value) {
    setState(() {
    servicioDomicilio = value;
    });
    },
    activeTrackColor: Colors.lightGreenAccent,
    activeColor: Colors.green,
    ),
    ],
    ));
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