import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class MapPage extends StatefulWidget {

  final double destinationLatitude;
  final double destinationLongitude;
  const MapPage({Key? key, required this.destinationLatitude, required this.destinationLongitude}) : super(key: key);
  
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  late LocationData _locationData;
  GoogleMapController? _controller;

  final Location _currentLocation = Location();
  final Set<Marker> _markers = {};
  PolylinePoints? polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final String googleAPiKey = "AIzaSyD4Qdvrk2evUhs_EeBG9jVAPAMaya43yrs";
  PointLatLng? destination;
  PointLatLng? origin;
   
  @override
  void initState() {
    super.initState();
    setState(() {
      destination = PointLatLng(widget.destinationLatitude, widget.destinationLongitude);
      _markers.add(Marker(
          markerId: const MarkerId('Destination'),
          position: LatLng(widget.destinationLatitude, widget.destinationLongitude),
          infoWindow: const InfoWindow(title: 'Destination'),
        ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.destinationLatitude, widget.destinationLongitude),
                zoom: 19,
            ) ,
            onMapCreated: (controller) => _controller = controller,
            mapType: MapType.normal,
            markers: _markers,
            polylines: Set<Polyline>.of(polylines.values),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.directions,
          color: Colors.white,
        ),
        onPressed: () {
          _createPolylines();
        },
      ),
      
    );
  }
  
  _createPolylines() async {
    _locationData = await _currentLocation.getLocation();
    origin = PointLatLng(_locationData.latitude ?? 0.0, _locationData.longitude ?? 0.0);

    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          "assets/images/person.png",
    );

    /*setState(() {
      _markers.add(Marker(
          markerId: const MarkerId('Origin'),
          position: LatLng(_locationData.latitude!, _locationData.longitude!),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: markerbitmap,
        ));
    });*/

    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      googleAPiKey, // Google Maps API Key
      origin!,
      destination!,
      travelMode: TravelMode.walking,
    );
    if (result.status == "OK") {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    Marker marker = _markers.firstWhere((marker) => marker.markerId.value == "Destination");
    setState(() {
      _markers.remove(marker);
      _markers.add(Marker(
        markerId: const MarkerId('Destination'),
        position: LatLng(polylineCoordinates[polylineCoordinates.length-1].latitude, polylineCoordinates[polylineCoordinates.length-1].longitude),
        infoWindow: const InfoWindow(title: 'Destination'),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('Origin'),
        position: LatLng(polylineCoordinates[0].latitude, polylineCoordinates[0].longitude),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: markerbitmap
      ));
    });

    _addPolyLine();
    _currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 18.0,
      )));
    });
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
    
  }
}
