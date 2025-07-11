import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagersystem/services/bloc/users_bloc.dart';

import '../services/CheckedTickets.dart/bloc/checked_tickets_bloc.dart';

class CheckedAllTieckets extends StatefulWidget {
  const CheckedAllTieckets({super.key});

  @override
  State<CheckedAllTieckets> createState() => _CheckedAllTiecketsState();
}

class _CheckedAllTiecketsState extends State<CheckedAllTieckets> {
  final CheckedTicketsBloc matcheventarray = CheckedTicketsBloc();
  @override
  void initState() {
    super.initState();
    matcheventarray.add(CheckedFetchTicketsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle_rounded),
          title: Column(
            children: [
              Text(
                'Checked Tickets',
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
          actions: [
            Icon(
              Icons.account_balance_rounded,
              color: Colors.white,
            )
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextButton(onPressed: () {}, child: Text("Checked Tickets")),
            Expanded(
              child: BlocConsumer<CheckedTicketsBloc, CheckedTicketsState>(
                bloc: matcheventarray,
                listenWhen: (previous, current) =>
                    current is CheckedTicketActionState,
                buildWhen: ((previous, current) =>
                    current is! CheckedTicketActionState),
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case CheckedTicketsFetchingLoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case CheckedTicketsFetchingSuccessfulState:
                      final successState =
                          state as CheckedTicketsFetchingSuccessfulState;
                      if (successState.checked_tickets_event.data!.isEmpty) {
                        return Center(
                            child: Text(
                          "No matchevents found",
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ));
                      }
                      return ListView.builder(
                        itemCount:
                            successState.checked_tickets_event.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final matchevent2 =
                              successState.checked_tickets_event.data![index];
                          return ListTile(
                            title: Text(matchevent2.barcode.toString()),
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
