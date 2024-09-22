part of 'search_stock_bloc.dart';

@immutable
abstract class SearchStockEvent {}

class SearchStock extends SearchStockEvent {
  final String query;

  SearchStock(this.query);
}
