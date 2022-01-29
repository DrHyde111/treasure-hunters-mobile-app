import 'package:flutter/material.dart';
import 'package:treasure_hunters/models/game.dart';
import 'package:treasure_hunters/services/api_services.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Main menu'),
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
