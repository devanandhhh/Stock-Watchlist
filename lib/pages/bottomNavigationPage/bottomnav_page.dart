import 'package:flutter/material.dart';
import 'package:stock_watchlist/core/widgets/widgets.dart';
import 'package:stock_watchlist/pages/homePage/home_page.dart';
import 'package:stock_watchlist/pages/watchListPage/watchlist_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentIndex = 0;
  final pages = [ HomePage(),const WatchlistPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSessionDecorate('Stock Watchlist'),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Watchlist')
        ],
      ),
    );
  }
}
