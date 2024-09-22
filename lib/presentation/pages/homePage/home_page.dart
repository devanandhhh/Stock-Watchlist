import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_watchlist/data/database/storage.dart';
import 'package:stock_watchlist/presentation/bloc/searchBloc/search_stock_bloc.dart';

import '../../../core/constant.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            h20,
            h20,
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Here ...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                context.read<SearchStockBloc>().add(SearchStock(value));
              },
            ),
            h20,
            Expanded(
              child: BlocBuilder<SearchStockBloc, SearchStockState>(
                builder: (context, state) {
                  if (state is SearchStockLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchStockLoadedState) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          final stock = state.searchResult[index];
                          return ListTile(
                            title: Text(stock.name),
                            subtitle: Text(stock.matchScore),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                handleAddStock(context, stock);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: state.searchResult.length);
                  } else if (state is SearchStockFaliure) {
                    return const Center(child: Text('Issue From Network'));
                  } else if (state is SearchStockInitial) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 290,
                            width: 290,
                            child: Image.network(
                                'https://static.vecteezy.com/system/resources/previews/007/434/000/original/two-hands-holding-binoculars-concept-illustration-for-search-information-looking-for-something-observe-spy-illustration-in-flat-cartoon-style-vector.jpg'),
                          ),
                          h20,
                          Text(
                            'Search Stock ',
                            style: GoogleFonts.aBeeZee(fontSize: 50),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No results found'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
