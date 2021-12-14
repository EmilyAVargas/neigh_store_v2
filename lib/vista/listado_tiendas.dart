import 'package:flutter/material.dart';
//import 'package:neigh_stores/modelo/producto_DTO.dart';
import 'package:neigh_stores/modelo/tienda_DTO.dart';
import 'package:neigh_stores/persistencia/producto_DAO.dart';
import 'package:neigh_stores/persistencia/tienda_DAO.dart';
import 'package:neigh_stores/vista/listado_productos.dart';

class VistaTiendas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neigh Stores',
      home: VistaListadoTiendas(),
    );
  }
}

class VistaListadoTiendas extends StatefulWidget {
  @override
  State<VistaListadoTiendas> createState() {
    return _VistaListadoTiendasState();
  }
}

class _VistaListadoTiendasState extends State<VistaListadoTiendas> {
  final _stores = TiendaDao.Tiendas;
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiendas disponibles - NEIGH_STORES'),
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _stores.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          return _buildRow(_stores[index]);
        });
  }

  Widget _buildRow(Tienda st) {
    return ListTile(
      title: Text(
        st.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(
        st.direccion,
        style: TextStyle(fontSize: 15.0, color: Colors.deepOrange),
      ),
      leading: Image.network(
        'https://drive.google.com/uc?export=view&id=' + st.logo,
      ),
      trailing: Icon(
        Icons.add_business,
        color: Colors.amber,
        size: 45.0,
      ),
      onTap: () {
        var pDao = ProductoDao();
        pDao.ObtenerProductosdelServidor(st.id).then((lista_productos) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VistaProductos(lista_productos, st)),
              ),
            });
        print(st.nombre);
      },
    );
  }
}
