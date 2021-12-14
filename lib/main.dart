import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neigh_stores/persistencia/tienda_DAO.dart';
import 'package:neigh_stores/vista/vista_principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  TiendaDao.AgregarTiendasdelServidor().then((value) => runApp(NeighStoresMainView()));
}

