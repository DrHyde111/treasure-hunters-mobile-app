import 'package:flutter/material.dart';
import 'package:treasure_hunters/models/game.dart';

class PlayGameView extends StatefulWidget {
  const PlayGameView({Key? key, required this.token, required this.game})
      : super(key: key);

  final String token;
  final Game game;

  @override
  _PlayGameViewState createState() => _PlayGameViewState();
}

class _PlayGameViewState extends State<PlayGameView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
