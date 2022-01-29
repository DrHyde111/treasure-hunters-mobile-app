class Point {
  int _id;
  String longitude;
  String latitiude;
  int index;
  String question;
  String correctAnswer;
  List<String> answers;

  Point(this._id, this.longitude, this.latitiude, this.index, this.question,
      this.correctAnswer, this.answers);

  Point.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        longitude = json['longitude'],
        latitiude = json['latitiude'],
        index = json['index'],
        question = json['question'],
        correctAnswer = json['correctAnswer'],
        answers = json['answers'];
}
