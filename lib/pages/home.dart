import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle_rounded),
        title: Column(
          children: [
            Text(
              'List of Users',
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(left: 13, bottom: 15, right: 13, top: 45),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Glucose Average Range",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 40),
                ListTile(
                  title: Text('Ashton Mapunga'),
                ),
                ListTile(
                  title: Text('Ashton Mapunga'),
                ),
                ListTile(
                  title: Text('Ashton Mapunga'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
