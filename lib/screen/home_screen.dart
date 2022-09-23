import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Todo List'),
        backgroundColor: const Color(0xff333333),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff333333),
      ),
    );
  }
}
