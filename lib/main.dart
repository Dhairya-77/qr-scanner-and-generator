import 'package:flutter/material.dart';
import 'generate_qr.dart';
import 'scan_qr.dart';

//main function
void main() {
  runApp(const MyApp());
}

//stateful widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    //tabs- boxes
    Tab gen_qr_tab = Tab(text: "Generate QR",icon: Icon(Icons.qr_code),);
    Tab scan_qr_tab = Tab(text: "Scan QR",icon: Icon(Icons.qr_code_scanner),);

    //tab bar- add tabs in tab ba
    TabBar tabBar= TabBar(tabs: [scan_qr_tab,gen_qr_tab],indicatorColor: Colors.purpleAccent,);

    //tab bar view- which tab screen will show when click on tab
    //list function according to tab sequence
    TabBarView tabBarView= TabBarView(children: [ScanQr(),GenerateQr()]);

    //appbar- top bar
    AppBar appBar=AppBar(title:Text("QR Scan & Generate"),backgroundColor: Colors.purple);

    //scaffold
    Scaffold scaffold = Scaffold(appBar: appBar,body: tabBarView,bottomNavigationBar: tabBar,);

    //default tab when app is starting
    DefaultTabController defaultTab=DefaultTabController(length: 2, child: scaffold);

    //returning material app
    return MaterialApp(home: defaultTab,debugShowCheckedModeBanner: false,);
  }
}
