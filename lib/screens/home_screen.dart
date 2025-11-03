import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interview_task_assesment/constants/image_strings.dart';
import 'package:interview_task_assesment/constants/text_strings.dart';
import 'package:interview_task_assesment/screens/alarm_screen.dart';
import '../widget_theme/filled_button_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  //current location shows
  static const CameraPosition _baddaDhaka = CameraPosition(
    target: LatLng(23.780546, 90.426659),
    zoom: 14,
  );

  ///Declare variables
  final Set<Marker> _markers = {};
  Marker? currentPosition;
  DateTime currentDuration = DateTime.now();
  String? currentAddress = "";

  ///Loaded Data
  Future<void> loadedData() async {
    Position position = await _determinePosition();

    /// convert lat-lng to address name using geocoding
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks.first;
    currentAddress =
        "${place.locality}, ${place.subAdministrativeArea ?? ''}, ${place.country}";

    ///update camera & marker
    CameraPosition cameraPosition = CameraPosition(
      zoom: 14,
      target: LatLng(position.latitude, position.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: currentAddress),
      ),
    );

    currentPosition = Marker(
      markerId: const MarkerId('current_location'),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(title: currentAddress),
    );

    currentDuration = DateTime.now();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF0A2D73)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                ///Welcome text
                Text(
                  nWelcome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                //Schedule text
                Text(
                  nSchedule,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 20),
                ),
                const SizedBox(height: 30),

                /// Google Map
                Container(
                  height: 300,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: _markers,
                    initialCameraPosition: _baddaDhaka,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                const SizedBox(height: 100),

                /// User current location Button
                GestureDetector(
                  onTap: () async {
                    await loadedData();
                    print(currentAddress);
                    print(currentDuration);

                    ///Pass name instead of lat-lng
                    Get.to(
                      () => AlarmScreen(
                        locationName: currentAddress ?? "Unknown location",
                        dateTime: currentDuration,
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          nLocation,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Image.asset(location, height: 30),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Home Button
                SizedBox(
                  height: 60,
                  child: WidgetFilledButton(
                    text: const Text(nHome, style: TextStyle(fontSize: 20)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Determine Position on users
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
