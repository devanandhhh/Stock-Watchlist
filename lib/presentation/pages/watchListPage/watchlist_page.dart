import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/core/constant.dart';

import '../../../data/database/storage.dart';
import '../../bloc/watchList/watchlist_bloc.dart';
import 'widgets/widget.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();

    context.read<WatchlistBloc>().add(FetchStockEvent());
  }

  Future<void> deleteStockFromList(String symbol) async {
    await deleteStock(symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          buildTableHeader(context),
          Expanded(child: BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
              if (state is WatchlistLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistloadedState) {
                return buildWatchListView(state, context);
              } else if (state is WatchlistFaliureState) {
                return Center(
                  child: Text('Failed to load data: ${state.error}'),
                );
              } else {
                return const Center(child: Text('No Data'));
              }
            },
          ))
        ],
      ),
    );
  }

  Container buildTableHeader(BuildContext context) {
    return watchListContainer(
        companyName: 'Company Name',
        stockPrice: 'Stock Price',
        baseColor: Colors.orange,
        context: context);
  }

  Container watchListContainer(
      {required companyName,
      required stockPrice,
      String symbol = '',
      required Color baseColor,
      required BuildContext context,
      bool isNeedIcon = false}) {
    return Container(
      height: 60,
      width: 400,
      color: baseColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildStockInfo(isNeedIcon ? green100 : blue100, companyName),
          buildStockInfo(isNeedIcon ? green100 : blue100, stockPrice),
          buildActionButton(isNeedIcon, context, symbol)
        ],
      ),
    );
  }

  Padding buildStockInfo(Color? color, companyName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Center(child: Text(companyName)),
      ),
    );
  }

  Widget buildWatchListView(WatchlistloadedState state, BuildContext context) {
    return state.stock.isNotEmpty
        ? ListView.builder(
            itemCount: state.stock.length,
            itemBuilder: (context, index) {
              final stock = state.stock[index];
              return watchListContainer(
                companyName: shortenString(stock.name, 15),
                stockPrice: stock.matchScore,
                isNeedIcon: true,
                symbol: stock.symbol,
                baseColor: orange200 ?? Colors.orange,
                context: context,
              );
            },
          )
        : Container(
            height: 400,
            width: 400,
            color: orange200,
            child: const Center(
              child: Text('No Data available'),
            ),
          );
  }
}
