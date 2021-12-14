import 'package:flutter/material.dart';
import 'package:neigh_stores/modelo/producto_DTO.dart';
import 'package:neigh_stores/modelo/tienda_DTO.dart';
import 'package:neigh_stores/persistencia/base_datos.dart';

import 'google_maps.dart';

class VistaPedido extends StatelessWidget {
  final List <Producto> Productos;

  VistaPedido(this.Productos);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neigh Stores',
      home: VistaListadoPedido(Productos),
    );
  }

}

class VistaListadoPedido extends StatefulWidget{

  final List <Producto> Productos;
  VistaListadoPedido(this.Productos);

  @override
  State<StatefulWidget> createState() {
    return _VistaListadoPedidoState();
  }

}

class _VistaListadoPedidoState extends State<VistaListadoPedido>{

  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos disponibles - NEIGH_STORES'),
      ),
      body: _buildStoresList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pedido enviado')),
          );
        },
        label: Text('Confirmar pedido'),
        icon: Icon(Icons.check),
      ),
    );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.Productos.length*2,
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          return _buildRow(widget.Productos[index]);
        });
  }

  Widget _buildRow(Producto pdt) {
    return ListTile(
      title: Text(
        pdt.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(
        pdt.precio.toString(),
        style: TextStyle(fontSize: 15.0, color: Colors.deepOrange),),
      leading: Icon(
        Icons.add_shopping_cart_sharp,
        color: Colors.black,
        size: 40.0,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_forever,
          color: Colors.red.shade500,
          size: 40.0,
        ),
        onPressed:() {
          print(pdt.nombre);
        } ,
      ),
      onTap: () {
        //pdt.cantidadCompra = 1;
        //BaseDatos.db.insertarProducto(pdt);
        BaseDatos.db.selectPedido().then((value) {
          print(value);
        });
      },
    );
  }
}