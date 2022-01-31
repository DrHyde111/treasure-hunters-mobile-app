import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_hunters/models/game.dart';
import 'package:treasure_hunters/views/game_won_view.dart';

class PlayGameView extends StatefulWidget {
  const PlayGameView({Key? key, required this.token, required this.game})
      : super(key: key);

  final String token;
  final Game game;

  @override
  _PlayGameViewState createState() => _PlayGameViewState();
}

class _PlayGameViewState extends State<PlayGameView> {
  LatLng currentPosition = const LatLng(49.688919, 19.200649);
  String ErrorMessage = '';
  bool questPanelActive = false;
  int activePointIndex = 0;

  late GoogleMapController _googleMapController;
  late Marker currentPoint;

  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.game.points.isNotEmpty) {
      currentPosition = LatLng(double.parse(widget.game.points[0].latitude),
          double.parse(widget.game.points[0].longitude));
      currentPoint = Marker(
          markerId: const MarkerId("Current quest"),
          position: currentPosition,
          infoWindow: const InfoWindow(title: "Current quest location"));
    } else {
      ErrorMessage = "Game has no points!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title),
      ),
      body: SafeArea(
        child: ErrorMessage == ''
            ? !questPanelActive
                ? GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: currentPosition, zoom: 15),
                    onMapCreated: (controller) =>
                        _googleMapController = controller,
                    markers: {currentPoint},
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.game.points[activePointIndex].question,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: displayOptions(),
                      )
                    ],
                  )
            : Column(
                children: [
                  Text(ErrorMessage),
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: questPanelActive == true
                    ? () {
                        setState(() {
                          questPanelActive = false;
                        });
                      }
                    : null,
                child: Text("Map")),
            ElevatedButton(
                onPressed: questPanelActive != true
                    ? () {
                        setState(() {
                          questPanelActive = true;
                        });
                      }
                    : null,
                child: Text("Quest"))
          ],
        ),
      ),
    );
  }

  List<Widget> displayOptions() {
    List<Widget> result = [];
    int index = 1;
    for (var element in widget.game.points[activePointIndex].answers) {
      result.add(
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      if (checkIfCorrect(
                              widget
                                  .game.points[activePointIndex].correctAnswer,
                              element) ==
                          true) {
                        return proceedToNextQuest();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Error answer try again'),
                          duration: const Duration(milliseconds: 1500),
                          width: 280.0, // Width of the SnackBar.
                          padding: const EdgeInsets.symmetric(
                            horizontal:
                                8.0, // Inner padding for SnackBar content.
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
                      return;
                    },
                    child: Text(
                      index.toString() + ".    " + element,
                      textAlign: TextAlign.start,
                    ))),
          ],
        ),
      );
      index++;
    }
    return result;
  }

  bool checkIfCorrect(String correct, String current) {
    return correct == current;
  }

  void proceedToNextQuest() {
    setState(() {
      if (activePointIndex == widget.game.points.length - 1) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => GameWonView(token: widget.token)),
          (Route<dynamic> route) => false,
        );
      }
      questPanelActive = false;
      activePointIndex++;
      currentPosition = LatLng(
          double.parse(widget.game.points[activePointIndex].latitude),
          double.parse(widget.game.points[activePointIndex].longitude));
      currentPoint = Marker(
          markerId: const MarkerId("Current quest"),
          position: currentPosition,
          infoWindow: const InfoWindow(title: "Current quest location"));
    });
  }
}
