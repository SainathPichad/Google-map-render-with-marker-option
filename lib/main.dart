import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final CameraPosition _cameraPosition=CameraPosition(target: LatLng(24.903623,67.198367));

  late GoogleMapController mapController;
  final List<Marker>markers=[];
  
  addmarker(cordinates){
    int id=Random().nextInt(100);
    setState(() {
      markers.add(

          Marker(
            position: cordinates,
            markerId: MarkerId(id.toString()),

            infoWindow: InfoWindow(
              title: cordinates.toString()
            )
          )

      );
      
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controler){
          setState(() {

            mapController=controler;
          });
        },
        // markers: markers.toSet(),
        markers: markers.toSet(),
        onTap: (cordinates){
          mapController.animateCamera(CameraUpdate.newLatLng(cordinates));

       addmarker(cordinates);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            mapController.animateCamera(CameraUpdate.zoomOut());
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.zoom_out),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
