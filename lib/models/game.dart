import 'package:treasure_hunters/models/point.dart';

class Game {
  int _id;
  String description;
  String creator;
  List<Point> points;

  Game(this._id, this.description, this.creator, this.points);

  Game.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        description = json['description'],
        creator = json['creator'],
        points = json['points'];
}
