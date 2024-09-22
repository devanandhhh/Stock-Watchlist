import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/api/search_stock.dart';
import '../../../data/model/search_model.dart';

part 'search_stock_event.dart';
part 'search_stock_state.dart';

class SearchStockBloc extends Bloc<SearchStockEvent, SearchStockState> {
  SearchStockService searchStockService = SearchStockService();
  SearchStockBloc() : super(SearchStockInitial()) {
    on<SearchStock>(onSearchedValue);
  }

  FutureOr<void> onSearchedValue(
      SearchStock event, Emitter<SearchStockState> emit) async {
    emit(SearchStockLoadingState());
    try {
      if (event.query.isNotEmpty) {
        final results =
            await searchStockService.searchStock(searchText: event.query);
        emit(SearchStockLoadedState(searchResult: results));
      } else {
        emit(SearchStockInitial());
      }
    } catch (e) {
      emit(SearchStockFaliure('Error loading stock data'));
    }
  }
}
