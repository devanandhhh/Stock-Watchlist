import 'package:flutter/material.dart';
import 'package:stock_watchlist/data/database/storage.dart';
import 'package:stock_watchlist/pages/bottomNavigationPage/bottomnav_page.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter bindings are initialized
  await initializeDatabase(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock WatchList',
      theme: ThemeData(appBarTheme:const AppBarTheme(color: Colors.blue),
       
      ),
      home: const BottomNavigationPage(),debugShowCheckedModeBanner: false,
    );
  }
}
