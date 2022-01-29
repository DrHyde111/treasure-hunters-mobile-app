import 'package:flutter/material.dart';
import 'package:treasure_hunters/models/game.dart';
import 'package:treasure_hunters/views/play_game_view.dart';

class GameInfoView extends StatefulWidget {
  const GameInfoView({Key? key, required this.token, required this.game})
      : super(key: key);

  final String token;
  final Game game;

  @override
  _GameInfoViewState createState() => _GameInfoViewState();
}

class _GameInfoViewState extends State<GameInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game info'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.game.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Text(
                'Description',
                textAlign: TextAlign.center,
              ),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.game.description),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text("Creator"),
              ),
              Text(
                widget.game.creator,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayGameView(
                                  token: widget.token, game: widget.game)));
                    },
                    child: const Text('Start Game')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
