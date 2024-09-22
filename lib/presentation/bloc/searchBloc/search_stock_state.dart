part of 'search_stock_bloc.dart';

@immutable
abstract class SearchStockState {}

final class SearchStockInitial extends SearchStockState {}

final class SearchStockLoadingState extends SearchStockState {}

final class SearchStockLoadedState extends SearchStockState {
  final List<SearchModel> searchResult;

  SearchStockLoadedState({required this.searchResult});
}

final class SearchStockFaliure extends SearchStockState {
  final String error;

  SearchStockFaliure(this.error);
}
