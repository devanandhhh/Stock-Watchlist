import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stock_watchlist/data/database/storage.dart';

import '../../../data/model/search_model.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
on<FetchStockEvent>(watchListFetched);
on<DeleteStockEvent>(deleteButtonClicked);


  }

  FutureOr<void> watchListFetched(FetchStockEvent event, Emitter<WatchlistState> emit) async{
    emit(WatchlistLoadingState());
    try{
      List<SearchModel>stock =await getAllStocks();
      emit(WatchlistloadedState(stock));
    }catch(e){
      WatchlistFaliureState(e.toString());
    }
  }

  FutureOr<void> deleteButtonClicked(DeleteStockEvent event, Emitter<WatchlistState> emit)async {
      emit(WatchlistLoadingState());
      try{
        await deleteStock(event.symbol);
        List<SearchModel> stocks = await getAllStocks();
          emit(WatchlistloadedState(stocks));
      }catch(e){
           emit(WatchlistFaliureState(e.toString()));
      }
  }
}
