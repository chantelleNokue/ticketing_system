import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usermanagersystem/models/CheckedTickets.dart';

import '../../../pages/checked_tickets.dart';
import '../../tokenStore.dart';

part 'checked_tickets_event.dart';
part 'checked_tickets_state.dart';

class CheckedTicketsBloc
    extends Bloc<CheckedTicketsEvent, CheckedTicketsState> {
  CheckedTicketsBloc() : super(CheckedTicketsInitial()) {
    on<CheckedFetchTicketsEvent>(checkedFetchTicketsEvent);
  }

  Future<void> checkedFetchTicketsEvent(
      CheckedFetchTicketsEvent event, Emitter<CheckedTicketsState> emit) async {
    emit(CheckedTicketsFetchingLoadingState());
    var client = http.Client();
    ChecledTickets ticket;
    try {
      TokenStore tokenStore = TokenStore();

      print("tgggggoken ${tokenStore.token}");

      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer ${tokenStore.token}',
      };

      var response = await client.get(
          Uri.parse(
              "http://140.82.25.196:8057/api/tickets/all checked in?PageNumber=4&PageSize=30"),
          headers: headers);
      var newMatchArray = jsonDecode(response.body);
      print(response.statusCode);
      print('fgfhfh ${newMatchArray}');

      ChecledTickets post = ChecledTickets.fromMap(newMatchArray);
      print("post $post");
      emit(CheckedTicketsFetchingSuccessfulState(checked_tickets_event: post));
    } catch (e) {
      emit(CheckedTicketsFetchingErrorState());
    }
  }
}
