part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

abstract class UsersActionState extends UsersState {}

class UsersInitial extends UsersState {}

class UsersFetchingLoadingState extends UsersState {}

class UsersFetchingErrorState extends UsersState {}

class UsersFetchingSuccessfulState extends UsersState {
  final List<MatchEvents> matchevents;
  UsersFetchingSuccessfulState({required this.matchevents});
}
