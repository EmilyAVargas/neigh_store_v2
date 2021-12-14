import 'package:flutter/material.dart';
import 'package:neigh_stores/modelo/producto_DTO.dart';
import 'package:neigh_stores/modelo/tienda_DTO.dart';
import 'package:neigh_stores/persistencia/base_datos.dart';
import 'package:neigh_stores/vista/vista_pedidos.dart';

import 'google_maps.dart';

class VistaProductos extends StatelessWidget {
  final List<Producto> Productos;
  final Tienda _Tmaker;

  VistaProductos(this.Productos, this._Tmaker);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neigh Stores',
      home: VistaListadoProductos(Productos, _Tmaker),
    );
  }
}

class VistaListadoProductos extends StatefulWidget {
  final List<Producto> Productos;
  final Tienda _Tmaker;
  VistaListadoProductos(this.Productos, this._Tmaker);

  @override
  State<StatefulWidget> createState() {
    return _VistaListadoProductosState();
  }
}

class _VistaListadoProductosState extends State<VistaListadoProductos> {
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.red);

  void handleClick(int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GoogleMapsView(widget._Tmaker)),
        );
        print("Seleccionó Google Maps");
        break;
      case 1:
        BaseDatos.db.selectPedido().then((lista_productos) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VistaPedido(lista_productos)),
          );
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos disponibles - NEIGH_STORES'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Ver en Google Maps')),
              PopupMenuItem<int>(
                  value: 1, child: Text('Ver carrito de compra')),
            ],
          ),
        ],
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.Productos.length * 2,
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
        style: TextStyle(fontSize: 15.0, color: Colors.deepOrange),
      ),
      leading: Icon(
        Icons.add_shopping_cart_sharp,
        color: Colors.black,
        size: 40.0,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.add_shopping_cart_sharp,
          color: Colors.white,
          size: 40.0,
        ),
        onPressed: () {
          pdt.cantidadCompra = 1;
          BaseDatos.db.insertarProducto(pdt);
        },
      ),
    );
  }
}
