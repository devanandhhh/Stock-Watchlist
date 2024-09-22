part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoadingState extends WatchlistState{}

class WatchlistloadedState extends WatchlistState{
  final List<SearchModel> stock;

  WatchlistloadedState(this.stock);

}
class WatchlistFaliureState extends WatchlistState{
  final String error;

  WatchlistFaliureState(this.error);

}