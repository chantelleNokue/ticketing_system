part of 'checked_tickets_bloc.dart';

@immutable
abstract class CheckedTicketsState {}

abstract class CheckedTicketActionState extends CheckedTicketsState {}

final class CheckedTicketsInitial extends CheckedTicketsState {}

class CheckedTicketsFetchingLoadingState extends CheckedTicketsState {}

class CheckedTicketsFetchingErrorState extends CheckedTicketsState {}

class CheckedTicketsFetchingSuccessfulState extends CheckedTicketsState {
  ChecledTickets checked_tickets_event;
  CheckedTicketsFetchingSuccessfulState({required this.checked_tickets_event});
}
