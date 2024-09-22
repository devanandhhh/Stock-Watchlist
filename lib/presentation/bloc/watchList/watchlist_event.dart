part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent {}
class FetchStockEvent extends WatchlistEvent{}

class DeleteStockEvent extends WatchlistEvent{
  final String symbol ;

  DeleteStockEvent(this.symbol);
  
}
