import 'package:awsilny_driver/services/auth.dart';
import 'package:awsilny_driver/shared/loading.dart';
import 'package:awsilny_driver/utils/current_location_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';

final AuthService _auth = AuthService();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    var location = [];
    List<Placemark> startPlace;
    List<Placemark> arrivePlace;
    return FutureBuilder<LocationData?>(
      future: currentLocation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
        if (snapchat.hasData) {
          final LocationData currentLocation = snapchat.data;
          return Scaffold(
            body: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                      center: LatLng(currentLocation.latitude!,
                          currentLocation.longitude!),
                      zoom: 15),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 100.0,
                          height: 100.0,
                          point: LatLng(currentLocation.latitude!,
                              currentLocation.longitude!),
                          builder: ((context) => const Icon(
                                Icons.location_on,
                                color: Colors.red,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}


          // ElevatedButton(
          //     onPressed: signOutFunction, child: const Text('Logout')),