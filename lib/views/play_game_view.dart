import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
  LatLng currentQuestPosition = const LatLng(49.688919, 19.200649);
  String ErrorMessage = '';
  bool questPanelActive = false;
  int activeQuestPointIndex = 0;
  Location location = Location();
  Set<Marker> _markers = {};

  late GoogleMapController _googleMapController;
  late Marker currentQuestPointMarker;
  late Marker currentPlayerPositionMarker;

  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.game.points.isNotEmpty) {
      currentQuestPosition = LatLng(
          double.parse(widget.game.points[0].latitude),
          double.parse(widget.game.points[0].longitude));
      currentQuestPointMarker = Marker(
          markerId: const MarkerId("Current quest"),
          position: currentQuestPosition,
          infoWindow: const InfoWindow(title: "Current quest location"));
      _markers.add(currentQuestPointMarker);
      print(_markers);
      goToPlayerCurrentPosition();
      setState(() {
        setPlayerMarker();
      });
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
                        CameraPosition(target: currentQuestPosition, zoom: 15),
                    onMapCreated: (controller) =>
                        _googleMapController = controller,
                    markers: _markers,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget
                                  .game.points[activeQuestPointIndex].question,
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
      floatingActionButton: questPanelActive == false
          ? FloatingActionButton(
              onPressed: goToPlayerCurrentPosition,
              child: Icon(Icons.person_pin),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        if (isPlayerCloseEnough() == false) {
                          setState(() {
                            questPanelActive = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child:
                                    const Text('Too far from quest location'),
                              ),
                              duration: const Duration(milliseconds: 1500),
                              width: 280.0,
                              // Width of the SnackBar.
                              padding: const EdgeInsets.symmetric(
                                horizontal:
                                    8.0, // Inner padding for SnackBar content.
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
    for (var element in widget.game.points[activeQuestPointIndex].answers) {
      result.add(
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      if (checkIfCorrect(
                              widget.game.points[activeQuestPointIndex]
                                  .correctAnswer,
                              element) ==
                          true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: const Text('Correct answer'),
                            ),
                            duration: const Duration(milliseconds: 1500),
                            width: 280.0,
                            // Width of the SnackBar.
                            padding: const EdgeInsets.symmetric(
                              horizontal:
                                  8.0, // Inner padding for SnackBar content.
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        return proceedToNextQuest();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: const Text('Error answer try again'),
                          ),
                          duration: const Duration(milliseconds: 1500),
                          width: 280.0,
                          // Width of the SnackBar.
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
      if (activeQuestPointIndex == widget.game.points.length - 1) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => GameWonView(token: widget.token)),
          (Route<dynamic> route) => false,
        );
      }
      questPanelActive = false;
      activeQuestPointIndex++;
      currentQuestPosition = LatLng(
          double.parse(widget.game.points[activeQuestPointIndex].latitude),
          double.parse(widget.game.points[activeQuestPointIndex].longitude));
      currentQuestPointMarker = Marker(
          markerId: const MarkerId("Current quest"),
          position: currentQuestPosition,
          infoWindow: const InfoWindow(title: "Current quest location"));
      _markers.removeWhere(
          (element) => element.markerId == MarkerId("Current quest"));
      _markers.add(currentQuestPointMarker);
    });
  }

  void setPlayerMarker() async {
    location.onLocationChanged.listen((LocationData loc) {
      currentPlayerPositionMarker = Marker(
          markerId: MarkerId('Player'),
          position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
          infoWindow: const InfoWindow(title: "Your current location"));
      _markers.removeWhere((element) => element.markerId == MarkerId('Player'));
      setState(() {
        _markers.add(currentPlayerPositionMarker);
      });
    });
  }

  void goToPlayerCurrentPosition() async {
    var currentLocation = await location.getLocation();
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
      target: LatLng(
          currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
      zoom: 12.0,
    )));
  }

  bool isPlayerCloseEnough() {
    return calculateDistance(
            currentPlayerPositionMarker.position.latitude,
            currentPlayerPositionMarker.position.longitude,
            currentQuestPosition.latitude,
            currentQuestPosition.longitude) >
        0.05;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
