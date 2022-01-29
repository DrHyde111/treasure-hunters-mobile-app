import 'package:flutter/material.dart';
import 'package:treasure_hunters/views/games_submenu_view.dart';
import 'package:treasure_hunters/views/partial_widgets/submenu_tile.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main menu'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamesSubmenuView(
                                token: token,
                              )));
                },
                child: const SubmenuTile(
                  label: 'Games',
                ))
          ],
        ),
      ),
    );
  }
}
