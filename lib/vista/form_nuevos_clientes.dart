import 'package:flutter/material.dart';
import 'package:neigh_stores/persistencia/conexion_http.dart';

void main() => runApp(const VistaNuevoCliente());

class VistaNuevoCliente extends StatelessWidget {
  const VistaNuevoCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro de nuevo cliente';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const FormularioNuevoCliente(),
      ),
    );
  }
}

// Create a Form widget.
class FormularioNuevoCliente extends StatefulWidget {
  const FormularioNuevoCliente({Key? key}) : super(key: key);

  @override
  FormularioNuevoClienteState createState() {
    return FormularioNuevoClienteState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormularioNuevoClienteState extends State<FormularioNuevoCliente> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late final String _nombre, _direccion, _telefono, _email;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    const estiloEtiqueta = TextStyle(fontSize: 15.0, color: Colors.red);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nombre:', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su nombre.';
              } else {
                setState(() {
                  _nombre = value;
                });

                return null;
              }
            },
          ),
          const Text('Dirección:', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su dirección.';
              } else {
                setState(() {
                  _direccion = value;
                });

                return null;
              }
            },
          ),
          const Text('Teléfono:', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su teléfono.';
              } else {
                setState(() {
                  _telefono = value;
                });

                return null;
              }
            },
          ),
          const Text('Correo electrónico:', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su Correo electrónico.';
              } else {
                setState(() {
                  _email = value;
                });

                return null;
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  var con = ServerConnection();
                  con.insert(
                      'Customers',
                      _nombre +
                          ';' +
                          _direccion +
                          ';' +
                          _telefono +
                          ';' +
                          _email);
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Datos guardados')),
                  );
                }
              },
              child: const Text('Registrar cliente'),
            ),
          ),
        ],
      ),
    );
  }
}
