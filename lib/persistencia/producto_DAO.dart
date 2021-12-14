import 'package:neigh_stores/modelo/producto_DTO.dart';

import 'conexion_http.dart';

class ProductoDao {

  Future<List<Producto>> ObtenerProductosdelServidor(String idTienda) async{
    final List<Producto> productos = [];
    var srvConn = ServerConnection();
    await srvConn.getProducts(idTienda).then((datos_productos) {
      var records = datos_productos.split("|");
      records.forEach((element) {
        productos.add(Producto.fromString(idTienda + ';' + element));
      });
    });
    return productos;
  }
}