import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../services/driving_service.dart';
import '../services/auth_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LocationService _locationService = LocationService();
  final DrivingService _drivingService = DrivingService();
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    final position = await _locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'Current Location'),
          ),
        );
      });

      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          ),
        ),
      );
    }
  }

  Future<void> _toggleRecording() async {
    final user = context.read<AuthService>().user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    setState(() => _isRecording = !_isRecording);

    if (_isRecording) {
      await _drivingService.startSession(user.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Started recording route')),
      );
    } else {
      await _drivingService.endSession(
        user,                 // UserModel object
        'Default Route Name', // Replace with an actual route name input
        String,               // Replace with the appropriate type if needed
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Route recorded successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 2,
            ),
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Card(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search location...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
                onSubmitted: (value) {
                  // TODO: Implement location search
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'toggleRecording',
            onPressed: _toggleRecording,
            backgroundColor: _isRecording ? Colors.red : Colors.green,
            child: Icon(_isRecording ? Icons.stop : Icons.play_arrow),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'viewRoutes',
            onPressed: () {
              // TODO: Show saved routes
            },
            child: const Icon(Icons.route),
          ),
        ],
      ),
    );
  }
}
