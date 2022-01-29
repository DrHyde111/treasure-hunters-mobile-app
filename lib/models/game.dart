import 'package:treasure_hunters/models/point.dart';

class Game {
  String _id;
  String title;
  String description;
  String creator;
  List<Point> points;

  Game(this._id, this.title, this.description, this.creator, this.points);

  Game.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        creator = json['creator'] ?? '',
        points = List<Point>.from(
            json['points'].map((point) => Point.fromJson(point)));
}
