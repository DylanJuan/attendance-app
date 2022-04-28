// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayCheckIn = '';
  String displayCheckOut = '';

  double screenHeight = 0;
  double screenWidth = 0;

  var locationMessage = "";
  double distance = 0.0;

  void getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    var pinnedLocationLatitude = -6.174770996914018;
    var pinnedLocationLongitude = 106.79001339732508;
    //neo-soho buildings

    double distanceInMeters = Geolocator.distanceBetween(position.latitude,
        position.longitude, pinnedLocationLatitude, pinnedLocationLongitude);

    print(distanceInMeters);
    print(lastPosition);

    setState(() {
      locationMessage = "$position";
      distance = distanceInMeters;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendace App'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Center(
                    child: Text(
                        DateFormat('MM/dd/yyyy hh:mm:ss')
                            .format(DateTime.now()),
                        style: Theme.of(context).textTheme.bodyText1),
                  );
                },
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  "Today's Status",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.run_circle_outlined,
                        size: 40,
                      ),
                      iconColor: Colors.green,
                      title: const Text('Check-In : '),
                      subtitle: Text(displayCheckIn),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.exit_to_app_rounded,
                        size: 40,
                      ),
                      iconColor: Colors.orange,
                      title: const Text('Check-out : '),
                      subtitle: Text(displayCheckOut),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: screenWidth / 3,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                  // ignore: unnecessary_null_comparison
                  child: displayCheckIn == ''
                      ? TextButton(
                          onPressed: () {
                            distance <= 50.00
                                ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            title: const Text(
                                                'Check-In Completed'),
                                            content: const Text(
                                                "You've absent has been recorded"),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    displayCheckIn = DateFormat(
                                                            'hh:mm:ss')
                                                        .format(DateTime.now())
                                                        .toString();
                                                  });
                                                  Navigator.pop(context, 'Ok');
                                                },
                                                child: const Text('Ok'),
                                              ),
                                            ]))
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title:
                                              const Text("Attendance failed"),
                                          content: const Text(
                                              "You're not in 50 meter distance from pinned location"),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, "Ok");
                                                },
                                                child: const Text('Ok'))
                                          ],
                                        ));
                          },
                          child: Text(
                            'Check-In',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            distance <= 50
                                ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            title: const Text(
                                                'Check-Out Completed'),
                                            content: const Text(
                                                "You've absent has been recorded"),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    displayCheckOut =
                                                        DateFormat('hh:mm:ss')
                                                            .format(
                                                                DateTime.now())
                                                            .toString();
                                                  });
                                                  Navigator.pop(context, 'Ok');
                                                },
                                                child: const Text('Ok'),
                                              ),
                                            ]))
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title:
                                              const Text("Attendance failed"),
                                          content: const Text(
                                              "You're not in 50 meter distance from pinned location"),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, "Ok");
                                                },
                                                child: const Text('Ok'))
                                          ],
                                        ));
                          },
                          child: Text(
                            'Check-Out',
                            style: Theme.of(context).textTheme.bodyText2,
                          ))),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Current Location :',
                      style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: locationMessage != ""
                        ? Text(
                            locationMessage,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Pinned Location :',
                      style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Latitude : -6.174770996914018",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          "Longitude : 106.79001339732508",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
