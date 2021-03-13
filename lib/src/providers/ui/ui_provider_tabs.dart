import 'package:flutter/material.dart';

class UiProviderTabs extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex {
    return this._currentIndex;
  }

  set currentIndex(int i) {
    this._currentIndex = i;
    notifyListeners();
  }
}
