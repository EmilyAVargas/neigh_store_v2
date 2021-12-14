class Producto {
  late int idTienda;
  late int id;
  late String nombre;
  late String unidad;
  late double precio;
  late int cantidadCompra;

  //#region Constructor
  Producto(
      {required this.idTienda,
       required this.id,
       required this.nombre,
       required this.unidad,
       required this.precio,
       required this.cantidadCompra});
  //#endregion

  //#region FromString
  //datos = 100;Salchichon;GRAMO;1000

  Producto.fromString(String datos){
    List<String> Tokens = datos.split(';');
    this.idTienda = int.parse(Tokens[0]);
    this.id = int.parse(Tokens[1]);
    this.nombre = Tokens[2];
    this.unidad = Tokens[3];
    this.precio = double.parse(Tokens[4]);
    this.cantidadCompra = 0;
  }
//#endregion

  //#region FromJSon
  Producto.fromJson(Map<String, dynamic> json)
      : idTienda = int.parse(json['idTienda'].toString()),
        id = int.parse(json['id'].toString()),
        nombre = json['nombre'].toString(),
        unidad = json['unidad'].toString(),
        precio = double.parse(json['precio'].toString()),
        cantidadCompra = int.parse(json['cantidadCompra'].toString());
  //#endregion

  //#region ToJSon
  Map<String, dynamic> toJson() => {
    "idTienda": idTienda,
    "id": id,
    "nombre": nombre,
    "unidad": unidad,
    "precio": precio,
    "cantidadCompra": cantidadCompra,
  };
  //#endregion

  String toString(){
    return this.nombre;
  }

}