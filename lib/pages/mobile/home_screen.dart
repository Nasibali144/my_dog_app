import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int crossAxisCount;
  const HomeScreen({Key? key, this.crossAxisCount = 2}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ButtonsType type = ButtonsType.all;

  void pressButton(ButtonsType type) {
    this.type = type;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // #all
            ElevatedButton(
              onPressed: () => pressButton(ButtonsType.all),
              style: ElevatedButton.styleFrom(
                primary: type == ButtonsType.all ? Colors.black : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: const StadiumBorder(),
              ),
              child: Text("All", style: TextStyle(color: type == ButtonsType.all ? Colors.white : Colors.black, fontSize: 20),),
            ),

            // #me
            ElevatedButton(
              onPressed: () => pressButton(ButtonsType.me),
              style: ElevatedButton.styleFrom(
                primary: type == ButtonsType.me ? Colors.black : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: const StadiumBorder(),
              ),
              child: Text("My Dogs", style: TextStyle(color: type == ButtonsType.me ? Colors.white : Colors.black, fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonsType {
  all,
  me,
}
