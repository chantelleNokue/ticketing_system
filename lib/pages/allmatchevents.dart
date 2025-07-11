import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagersystem/services/bloc/users_bloc.dart';

class AllMatchEvents extends StatefulWidget {
  const AllMatchEvents({super.key});

  @override
  State<AllMatchEvents> createState() => _AllMatchEventsState();
}

class _AllMatchEventsState extends State<AllMatchEvents> {
  final UsersBloc matcheventarray = UsersBloc();
  @override
  void initState() {
    super.initState();
    matcheventarray.add(UserInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle_rounded),
          title: Column(
            children: [
              Text(
                'All Match Events',
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<UsersBloc, UsersState>(
                bloc: matcheventarray,
                listenWhen: (previous, current) => current is UsersActionState,
                buildWhen: ((previous, current) =>
                    current is! UsersActionState),
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case UsersFetchingLoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case UsersFetchingSuccessfulState:
                      final successState =
                          state as UsersFetchingSuccessfulState;
                      if (successState.matchevents.isEmpty) {
                        return Center(child: Text("No matchevents found"));
                      }
                      return ListView.builder(
                        itemCount: successState.matchevents.length,
                        itemBuilder: (BuildContext context, int index) {
                          final matchevent2 = successState.matchevents[index];
                          return ListTile(
                            title: Text(matchevent2.eventDate.toString()),
                          );
                        },
                      );
                    default:
                      return const SizedBox(
                        child: Text("Error Occured"),
                      );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
