import 'package:flutter/material.dart';

import '../../data/database/storage.dart';
import '../../data/model/search_model.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List<SearchModel> stockList = [];

  @override
  void initState() {
    super.initState();
    fetchStocksFromDatabase(); // Fetch stocks when the widget is initialized
  }

  Future<void> fetchStocksFromDatabase() async {
    List<SearchModel> stocksFromDb =
        await getAllStocks(); // Assuming getAllStocks returns List<SearchModel>
    setState(() {
      stockList = stocksFromDb;
    });
  }

  Future<void> deleteStockFromList(String symbol) async {
    await deleteStock(symbol); // Call your database delete method
    fetchStocksFromDatabase(); // Refresh the stock list
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          watchListContainer(
              companyName: 'Company Name',
              stockPrice: 'Stock Price',
              baseColor: Colors.orange),
          Expanded(
              child: stockList.isNotEmpty
                  ? ListView(
                      children: stockList.map((stock) {
                        return watchListContainer(
                            companyName: stock.name,
                            stockPrice: stock.matchScore,
                            isNeedIcon: true,
                            symbol: stock.symbol,
                            baseColor: Colors.orange[200] ?? Colors.orange);
                      }).toList(),
                    )
                  : Container(
                      height: 400,
                      width: 400,
                      color: Colors.orange[200],
                      child: const Center(
                        child: Text('No Data available'),
                      ),
                    )),
        ],
      ),
    );
  }

  Container watchListContainer(
      {required companyName,
      required stockPrice,
      String symbol = '',
      required Color baseColor,
      bool isNeedIcon = false}) {
    return Container(
      height: 60,
      width: 400,
      color: baseColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 130,
              decoration: isNeedIcon
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green[100])
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[100]),
              child: Center(child: Text(companyName)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 130,
              decoration: isNeedIcon
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green[100])
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[100]),
              child: Center(
                child: Text(stockPrice),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 60,
              decoration: isNeedIcon
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange[100])
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[100]),
              child: isNeedIcon
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do You want to delete'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () async {
                                      await deleteStockFromList(symbol);
                                      setState(() {
                                        fetchStocksFromDatabase();
                                      });
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'))
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete))
                  : IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Refresh the Data'),
                          backgroundColor: Colors.green[200],
                        ));
                      },
                      icon: const Icon(Icons.refresh)),
            ),
          )
        ],
      ),
    );
  }
}
