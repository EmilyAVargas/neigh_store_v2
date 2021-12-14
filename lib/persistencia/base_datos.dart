import 'dart:io';

import 'package:neigh_stores/modelo/producto_DTO.dart';
import 'package:neigh_stores/modelo/tienda_DTO.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDatos {
  static late Database _database;
  final String _dataBaseName = "neighStoresApp.db";
  BaseDatos._();
  static final BaseDatos db = BaseDatos._();
  var init = false;

  //#region Creacion de tablas
  static final String _CREATE_TIENDAS =
      "CREATE TABLE Tienda("
      "id INTEGER PRIMARY KEY, "
      "nombre TEXT,"
      "direccion TEXT,"
      "telefono TEXT,"
      "correo TEXT,"
      "tipo TEXT,"
      "logo TEXT,"
      "coordenadas TEXT"
      ")";

  static final String _CREATE_PEDIDO =
      "CREATE TABLE Pedido("
      "idTienda INTEGER,"
      "id INTEGER, "
      "nombre TEXT,"
      "unidad TEXT,"
      "precio REAL,"
      "cantidadCompra INTEGER"
      ")";
  //#endregion

  Future<Database> get database async {
    if (init) {
      return _database;
    }
    else {
    _database = await iniciarBaseDatos();
    }
    return _database;
  }

  //#region Iniciar base de datos
  iniciarBaseDatos() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _dataBaseName);

    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(_CREATE_TIENDAS);
          await db.execute(_CREATE_PEDIDO);
          init = true;
        }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if(oldVersion < newVersion) {
            await db.execute("DROP TABLE IF EXISTS Tienda");
            await db.execute(_CREATE_TIENDAS);
            await db.execute("DROP TABLE IF EXISTS Pedido");
            await db.execute(_CREATE_PEDIDO);
          }
        });
}
//endregion

  //#region Tiendas y Pedidos

  //#region Insertar
  insertarTienda(Tienda td) async {
    final db = await database;
    var res = await db.insert("Tienda", td.toJson());
    return res;
  }

  insertarProducto(Producto pdt) async {
    final db = await database;
    var res = await db.insert("Producto", pdt.toJson());
    return res;
  }
  //#endregion

  //#region Consultar
  Future<List<Tienda >> selectTiendas(String query) async {
    final db = await database;
    var res = await db.rawQuery(query);
    List<Tienda> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Tienda.fromJson(t));
      }
    }
    return list;
  }

  Future<List<Producto >> selectPedido() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM Pedido');
    List<Producto> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Producto.fromJson(t));
      }
    }
    return list;
  }
//#endregion

  //#region Eliminar del pedido

//#endregion

//#endregion
}