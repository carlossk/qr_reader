import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/ui/ui_provider_tabs.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProviderTabs>(context);
    final currentIndex = uiProvider.currentIndex;
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int i) => {uiProvider.currentIndex = i},
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Directions')
        ]);
  }
}
