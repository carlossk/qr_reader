import 'package:flutter/material.dart';
import 'package:qr_reader/src/pages/home_page.dart';
import 'package:qr_reader/src/pages/map_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_provider.dart';
import 'package:qr_reader/src/providers/ui/ui_provider_tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProviderTabs()),
        ChangeNotifierProvider(create: (_) => new ScanProvider())
      ],
      child: MaterialApp(
        title: 'Qr Reader',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'map': (BuildContext context) => MapShowPage()
        },
        theme: ThemeData(primaryColor: Colors.deepOrange),
      ),
    );
  }
}
