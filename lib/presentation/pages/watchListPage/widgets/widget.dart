import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant.dart';
import '../../../../data/database/storage.dart';
import '../../../bloc/watchList/watchlist_bloc.dart';

String shortenString(String input, int range) {
  if (input.length > range) {
    return '${input.substring(0, range)}...';
  } else {
    return input;
  }
}

Widget buildActionButton(bool isNeedIcon, BuildContext context, String symbol) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 50,
      width: 60,
      decoration: isNeedIcon
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: orange100)
          : BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: blue100),
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
                              await deleteStock(symbol);
                              // ignore: use_build_context_synchronously
                              context
                                  .read<WatchlistBloc>()
                                  .add(DeleteStockEvent(symbol));
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Successfully Deleted'),
                                backgroundColor: green200,
                              ));
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
                  backgroundColor: green200,
                ));
              },
              icon: const Icon(Icons.refresh)),
    ),
  );
}
