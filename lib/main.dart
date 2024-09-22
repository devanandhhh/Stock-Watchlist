import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/data/database/storage.dart';
import 'package:stock_watchlist/presentation/bloc/searchBloc/search_stock_bloc.dart';
import 'package:stock_watchlist/presentation/bloc/watchList/watchlist_bloc.dart';
import 'package:stock_watchlist/presentation/pages/bottomNavigationPage/bottomnav_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchStockBloc(),
        ),
        BlocProvider(
          create: (context) => WatchlistBloc(),
        )
      ],
      child: const MaterialApp(
        title: 'Stock WatchList',
        home: BottomNavigationPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
