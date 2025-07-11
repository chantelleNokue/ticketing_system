import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagersystem/pages/allmatchevents.dart';
import 'package:usermanagersystem/services/bloc/users_bloc.dart';
import 'package:usermanagersystem/services/ticketsbloc/bloc/tickets_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/Barcode.dart';
import '../services/tokenStore.dart';
import 'checked_tickets.dart';

class TicketsAll extends StatefulWidget {
  const TicketsAll({super.key});

  @override
  State<TicketsAll> createState() => _TicketsAllState();
}

class _TicketsAllState extends State<TicketsAll> {
  final TicketsBloc matcheventarray = TicketsBloc();
  @override
  void initState() {
    super.initState();
    matcheventarray.add(TicketInitialFetchEvent());
  }

  Future<void> PostBarcode(
    String Barcodes,
  ) async {
    var body = {
      "barcode": Barcode,
    };
    TokenStore tokenStore = TokenStore();

    var url = Uri.parse(
        "http://140.82.25.196:8057/api/tickets/$Barcodes?api-version=1.0.0");

    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer ${tokenStore.token}',
    };

    var response = await http.get(url, headers: headers);
    print("prince $response");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Barcode mapBarcode = Barcode.fromMap(jsonResponse);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Container(
              width: 300,
              height: 100,
              child: Column(
                children: [
                  Text("Barcode: ${mapBarcode.barcode}"),
                  Text("ProductPrice: ${mapBarcode.productPrice}"),
                  Text("Barcode: ${mapBarcode.status}"),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle_rounded),
          title: Column(
            children: [
              Text(
                'All Tickets',
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllMatchEvents()),
                );
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckedAllTieckets()),
                  );
                },
                child: Text(
                  "Checked Tickets ",
                  style: TextStyle(fontSize: 27),
                )),
            Expanded(
              child: BlocConsumer<TicketsBloc, TicketsState>(
                bloc: matcheventarray,
                listenWhen: (previous, current) =>
                    current is TicketsActionState,
                buildWhen: ((previous, current) =>
                    current is! TicketsActionState),
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case TicketsFetchingLoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case TicketsFetchingSuccessfulState:
                      final successState =
                          state as TicketsFetchingSuccessfulState;
                      if (successState.matchevents == null) {
                        return Center(child: Text("No matchevents found"));
                      }
                      return ListView.builder(
                        itemCount: successState.matchevents.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final matchevent2 =
                              successState.matchevents.data[index];
                          return ListTile(
                            title: Text(matchevent2.barcode.toString()),
                            leading: TextButton(
                                onPressed: () {
                                  PostBarcode(matchevent2.barcode.toString());
                                },
                                child: Text("View if Used")),
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
