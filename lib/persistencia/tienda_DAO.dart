import 'package:neigh_stores/modelo/tienda_DTO.dart';
import 'conexion_http.dart';
import 'dart:convert' as JSON;

class TiendaDao {
  static final List<Tienda> Tiendas = [];

  static Future<void> AgregarTiendasdelServidor() async{
    var srvConn = ServerConnection();
    await srvConn.select('Tienda').then((stores_data) {
      var json = JSON.jsonDecode(stores_data);
      List records = json["data"];
      records.forEach((element) {
        Tiendas.add(Tienda.fromJson(element));
      });
    });
  }
}
