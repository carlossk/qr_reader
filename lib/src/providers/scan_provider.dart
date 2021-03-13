import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String optionSelected = 'http';

  createScan(String value) async {
    final newScan = new ScanModel(valor: value);
    final id = await DBProvider.db.createScan(newScan);
    newScan.id = id;
    if (this.optionSelected == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }
  }

  loadScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans];
    this.optionSelected = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteScanAll();
    this.scans = [];
    notifyListeners();
  }

  deleteByID(int id) async {
    await DBProvider.db.deleteScan(id);
    this.loadScansByType(this.optionSelected);
    //notifyListeners();
  }
}
