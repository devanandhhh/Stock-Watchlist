import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_watchlist/data/api/search_stock.dart';
import 'package:stock_watchlist/data/database/storage.dart';
import 'package:stock_watchlist/data/model/search_model.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  final searchStockService = SearchStockService();

  List<SearchModel> searchResults = [];

  bool isLoading = false;

  void onSearchChanged(String value) async {
    if (value.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      // Fetch stock data from the service
      List<SearchModel> results =
          await searchStockService.searchStock(searchText: value);

      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Stocks ..',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: onSearchChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: searchResults.isNotEmpty
                        ? ListView.separated(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final stock = searchResults[index];
                              return ListTile(
                                title: Text(stock.name), // Display stock name
                                subtitle: Text(
                                    stock.matchScore), // Optionally show symbol
                                trailing: IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    addStock(stock);
                                    log('value added');
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Data added successfully'),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.green[200],
                                    ));
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          )
                        : const Center(child: Text('No results found')),
                  ),
          ],
        ),
      ),
    );
  }
}
