import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:qr_reader/src/pages/address_page.dart';
import 'package:qr_reader/src/pages/maps_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_reader/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scanBloc = ScansBloc();
  int currentIndex = 0;
  String _title = 'Geolocation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                scanBloc.deleteScans();
              })
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.map, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _title = 'Geolocation';
                            currentIndex = 0;
                          });
                        })),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.devices_other,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _title = 'Others';
                            currentIndex = 1;
                          });
                        }))
              ],
            ),
          )),
      body: _callPage(currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _scanQr(context);
        },
        child: Icon(Icons.filter_center_focus),
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions), title: Text('Address'))
      ],
    );
  }

  _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapPage();
        break;
      case 1:
        return AddressPage();
        break;
    }
  }

  void _scanQr(BuildContext context) async {
    var futureString;
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = null;
    }
    if (futureString.rawContent != '') {
      final scan = ScanModel(valor: futureString.rawContent);
      print('...,.,.,.,.,.,<><><');
      print(futureString.type);
      print(futureString.rawContent); // The barcode content
      print(futureString.format); // The barcode format (as enum)
      print(futureString.formatNote);
      scanBloc.addScan(scan);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.launchURL(context, scan);
        });
      } else {
        utils.launchURL(context, scan);
      }
    }
  }
}
