import 'package:flutter/material.dart';
import 'generate_qr.dart';
import 'scan_qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    Tab gen_qr_tab = Tab(text: "Generate QR",icon: Icon(Icons.qr_code),);
    Tab scan_qr_tab = Tab(text: "Scan QR",icon: Icon(Icons.qr_code_scanner),);

    TabBar tabBar= TabBar(tabs: [scan_qr_tab,gen_qr_tab],indicatorColor: Colors.purpleAccent,);

    TabBarView tabBarView= TabBarView(children: [ScanQr(),GenerateQr()]);

    AppBar appBar=AppBar(title:Text("QR Scan & Generate"),backgroundColor: Colors.purple);

    Scaffold scaffold = Scaffold(appBar: appBar,body: tabBarView,bottomNavigationBar: tabBar,);

    DefaultTabController defaultTab=DefaultTabController(length: 2, child: scaffold);

    return MaterialApp(home: defaultTab,debugShowCheckedModeBanner: false,);
  }
}
