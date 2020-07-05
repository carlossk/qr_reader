import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:latlong/latlong.dart';

class MapShowPage extends StatefulWidget {
  MapShowPage({Key key}) : super(key: key);

  @override
  _MapShowPageState createState() => _MapShowPageState();
}

class _MapShowPageState extends State<MapShowPage> {
  MapController mapCtrl = new MapController();
  String typeMap = 'satellite-v9';
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapCtrl.move(scan.getLatLang(), 13);
              })
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapCtrl,
      options: MapOptions(
        center: scan.getLatLang(),
        zoom: 13.0,
      ),
      layers: [_createLayer(), _createMarker(scan)],
    );
  }

  _createLayer() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiY2FybG9zc2siLCJhIjoiY2tjNDl0ZnRrMDVyNTJybXJzcmIyeWlzMyJ9.Uxr1VOLrE8Z7mbL00qoNIw',
          'id': 'mapbox/$typeMap'

          //mapbox/satellite-v9 streets-v11
        });
  }

  _createMarker(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          point: scan.getLatLang(),
          height: 100,
          width: 100,
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        typeMap = 'streets-v11';
        setState(() {});
      },
      child: Icon(Icons.color_lens),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
