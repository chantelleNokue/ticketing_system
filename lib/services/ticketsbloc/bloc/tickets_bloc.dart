import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usermanagersystem/models/tickets.dart';
import 'package:http/http.dart' as http;
import 'package:usermanagersystem/services/tokenStore.dart';

part 'tickets_event.dart';
part 'tickets_state.dart';

class TicketsBloc extends Bloc<TisketsEvent, TicketsState> {
  TicketsBloc() : super(TicketsInitial()) {
    on<TicketInitialFetchEvent>(ticketsInitialFetchEvent);
  }

  FutureOr<void> ticketsInitialFetchEvent(
      TicketInitialFetchEvent event, Emitter<TicketsState> emit) async {
    emit(TicketsFetchingLoadingState());
    var client = http.Client();
    Tickets ticket;
    try {
      TokenStore tokenStore = TokenStore();

      print("tgggggoken ${tokenStore.token}");

      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer ${tokenStore.token}',
      };

      var response = await client.get(
          Uri.parse(
              "http://140.82.25.196:8057/api/tickets?PageNumber=3&PageSize=25"),
          headers: headers);
      var newMatchArray = jsonDecode(response.body);
      print(response.statusCode);
      print('fgfhfh ${newMatchArray}');

      Tickets post = Tickets.fromMap(newMatchArray);
      print(post);
      emit(TicketsFetchingSuccessfulState(matchevents: post));
    } catch (e) {
      emit(TicketsFetchingErrorState());
    }
  }
}
