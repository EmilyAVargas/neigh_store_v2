import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:neigh_stores/modelo/tienda_DTO.dart';
import 'package:neigh_stores/persistencia/base_datos.dart';
import 'package:neigh_stores/vista/form_nuevos_clientes.dart';
import 'package:neigh_stores/vista/listado_tiendas.dart';

//Esto fue editado el día 13 de diciembre del 2021
class NeighStoresMainView extends StatefulWidget{
  @override
  State<NeighStoresMainView> createState() => _NeighStoresMainView(); 
}

class _NeighStoresMainView extends State<NeighStoresMainView> {
  List<String> images = [
    "images/listado_tiendas.png",
    "images/registro_clientes.png",
    "images/realizar_pedidos.png",
    "images/configuracion.png"
  ];

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          print(message.notification!.body);
          print(message.notification!.title);
        }
        print(message);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (messagge) {
        final routeMessagge = messagge.data["route"];
        print(routeMessagge);
      },
    );
    super.initState();
  }

  Widget _buildCelda(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VistaTiendas()),
          );
        }
        else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VistaNuevoCliente()),
          );
        }
        else if (index== 2){
          //TODO no olvide implementar esta funcion - Vista pedidos
        }
        else if (index== 3){
          //TODO no olvide implementar esta funcion - Vista configuración
          //var t1 = Tienda(id: "110", nombre: "gato", direccion: "Galicia", telefono: "111", correo: "gatito@gmial.com", tipo: TipoNegocio.Tienda, logo: "xx");
         // var t2 = Tienda(id: "111", nombre: "hamster", direccion: "Estancia", telefono: "222", correo: "hamster@gmial.com", tipo: TipoNegocio.Pizzeria, logo: "xx");
          //BaseDatos.db.insertarTienda(t1);
          //BaseDatos.db.insertarTienda(t2);
          BaseDatos.db.selectTiendas("SELECT * FROM Tienda").then((value) => print(value));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Image.asset(images[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Neigh Stores"),
          backgroundColor: Colors.red,
        ),
        body: Container(
            padding: EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) => _buildCelda(context, index),
            )),
      ),
    );
  }
}
