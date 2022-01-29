import 'package:flutter/material.dart';
import 'package:treasure_hunters/models/game.dart';
import 'package:treasure_hunters/services/api_services.dart';
import 'package:treasure_hunters/views/partial_widgets/submenu_tile.dart';

import 'game_info_view.dart';

class GamesSubmenuView extends StatefulWidget {
  const GamesSubmenuView({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<GamesSubmenuView> createState() => _GamesSubmenuViewState();
}

class _GamesSubmenuViewState extends State<GamesSubmenuView> {
  late Future<List<Game>> games;

  @override
  void initState() {
    super.initState();
    games = getAllGames();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: games,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Games'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: displayGames(snapshot.data),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  List<Widget> displayGames(games) {
    List<Widget> result = [];
    games.forEach((game) {
      result.add(TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GameInfoView(
                          token: widget.token,
                          game: game,
                        )));
          },
          child: SubmenuTile(
            label: game.title,
          )));
    });
    return result;
  }
}
