class Point {
  String _id;
  String longitude;
  String latitude;
  int index;
  String question;
  String correctAnswer;
  List<dynamic> answers;

  Point(this._id, this.longitude, this.latitude, this.index, this.question,
      this.correctAnswer, this.answers);

  Point.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        longitude = json['longitude'] ?? '',
        latitude = json['latitude'] ?? '',
        index = json['index'] ?? 0,
        question = json['question'] ?? '',
        correctAnswer = json['correctAnswer'] ?? '',
        answers = json['answers'] ?? [];
}
