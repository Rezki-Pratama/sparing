part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadSuccessState extends FavouriteState {
  final Stream<List<Sport>> sport;

  FavouriteLoadSuccessState({this.sport});

  @override
  List<Object> get props => [sport];
}

class FavouriteFailState extends FavouriteState {
  final String message;

  FavouriteFailState(this.message);

  @override
  List<Object> get props => [];
}

class AddFavouriteSuccessState extends FavouriteState {}

class AddFavouriteFailState extends FavouriteState {
  final String message;

  AddFavouriteFailState(this.message);

  @override
  List<Object> get props => [];
}
