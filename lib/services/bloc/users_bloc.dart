import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:usermanagersystem/models/matchevents.dart';
import 'package:http/http.dart' as http;

import '../tokenStore.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UserInitialFetchEvent>(usersInitialFetchEvent);
  }

  FutureOr<void> usersInitialFetchEvent(
      UserInitialFetchEvent event, Emitter<UsersState> emit) async {
    emit(UsersFetchingLoadingState());
    var client = http.Client();
    List<MatchEvents> posts = [];
    try {
      TokenStore tokenStore = TokenStore();

      print("tgggggoken ${tokenStore.token}");

      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer ${tokenStore.token}',
      };

      var response = await client.get(
          Uri.parse("http://140.82.25.196:8057/api/matchevents"),
          headers: headers);
      List newMatchArray = jsonDecode(response.body);
      print(response.statusCode);
      print('fgfhfh ${response}');

      for (int i = 0; i < newMatchArray.length; i++) {
        MatchEvents post =
            MatchEvents.fromMap(newMatchArray[i] as Map<String, dynamic>);
        posts.add(post);
      }
      print(posts);
      emit(UsersFetchingSuccessfulState(matchevents: posts));
    } catch (e) {
      emit(UsersFetchingErrorState());
    }
  }
}
