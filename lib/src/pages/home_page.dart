import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:qr_reader/src/pages/address_page.dart';
import 'package:qr_reader/src/pages/direcciones_pages.dart';
import 'package:qr_reader/src/pages/mapas_page.dart';

import 'package:qr_reader/src/pages/maps_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_reader/src/providers/scan_provider.dart';
import 'package:qr_reader/src/providers/ui/ui_provider_tabs.dart';
import 'package:qr_reader/src/widgets/custom_navigation_bar.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';
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
                  Provider.of<ScanProvider>(context, listen: false).deleteAll();
                })
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(),
        body: _HomePageBody(), //_callPage(currentIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ScanButton());
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProviderTabs>(context);
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);
    final currentIndex = uiProvider.currentIndex;
    switch (currentIndex) {
      case 0:
        scanProvider.loadScansByType('geo');
        return MapasPage();
      case 1:
        scanProvider.loadScansByType('http');

        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
