part of 'tickets_bloc.dart';

@immutable
abstract class TicketsState {}

abstract class TicketsActionState extends TicketsState {}

class TicketsInitial extends TicketsState {}

class TicketsFetchingLoadingState extends TicketsState {}

class TicketsFetchingErrorState extends TicketsState {}

class TicketsFetchingSuccessfulState extends TicketsState {
  final Tickets matchevents;
  TicketsFetchingSuccessfulState({required this.matchevents});
}
