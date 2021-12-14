import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neigh_stores/modelo/tienda_DTO.dart';

//void main() => runApp(MyApp());

class GoogleMapsView extends StatelessWidget {
  final Tienda _Tmaker;

  GoogleMapsView(this._Tmaker);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps',
      home: GoogleMapsLocator(_Tmaker),
    );
  }
}

class GoogleMapsLocator extends StatefulWidget {
  final Tienda _Tmaker;

  GoogleMapsLocator(this._Tmaker);

  @override
  State<GoogleMapsLocator> createState() => GoogleMapsLocatorState();
}

class GoogleMapsLocatorState extends State<GoogleMapsLocator> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final lalo = LatLng(double.parse(widget._Tmaker.coordenadas.split(",")[0]),
                        double.parse(widget._Tmaker.coordenadas.split(",")[1]));

    final CameraPosition _camaraPrincipal = CameraPosition(
      target: lalo,
      zoom: 18.3,
    );

    final mk = Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(widget._Tmaker.id),
      position: lalo,
      infoWindow: InfoWindow(
        title: widget._Tmaker.nombre,
        snippet: widget._Tmaker.tipo.toString().replaceAll('TipoNegocio.', ''),
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _camaraPrincipal,
        markers: {mk},
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("Presionaron el botón");
        },
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}

//AIzaSyBqK_HgEIUChCgtPZTfivG4l8EIGOiCY6w
