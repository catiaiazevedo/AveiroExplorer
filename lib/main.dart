import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aveiroexplorer/screens/homescreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AAAAnx-fTQ8:APA91bFOaPWbDjCxrLQ09k6AejirotbbotFJ-xosiJFN8atxjniYQkwLLHbo6b-eESdR5IxyCf7Zi8uWklpIRkdi279Ag-yTuphZHqc38pscWKSOHuuYxdi43q-7RqgwNJ8xZ3g9rKSj",
                             appId: "1:683430333711:android:b8e504b9ddaa2dfd99427a", 
                             messagingSenderId: "683430333711", 
                             projectId: "aveiroexplorericm")
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}