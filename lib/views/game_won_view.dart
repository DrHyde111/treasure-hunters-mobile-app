import 'package:flutter/material.dart';
import 'package:treasure_hunters/views/menu_view.dart';

class GameWonView extends StatelessWidget {
  const GameWonView({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game ended!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Success!",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            "You finished the game.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuView(token: token)),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text("Back to main menu"))
        ],
      ),
    );
  }
}
