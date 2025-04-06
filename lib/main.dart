import 'package:adder/Home.dart';
import 'package:adder/functions/mydb_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:adder/model/mydb_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(MydbAdapter()); // Register model adapter
  await MydbServices().openBox(); ////calling open box through mydbservice
  //class beacuse it has openbox function  Hive.openBox<Mydb>('mydb_box');
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      title: 'Mydb',
    );
  }
}

/*
// 1. Importing necessary packages and files
import 'package:adder/Home.dart';          // Your main screen widget
import 'package:flutter/material.dart';    // Flutter's material design package
import 'package:hive_flutter/hive_flutter.dart'; // Hive database package
import 'package:adder/models/mydb_model.dart'; // Your data model

// 2. Main function - entry point of the app
void main() async {  // Marked as async because we'll use await
  // 3. Initialize Hive and connect to Flutter's file system
  await Hive.initFlutter();
  
  // 4. Register your model's adapter
  // This tells Hive how to store/retrieve your Mydb objects
  Hive.registerAdapter(MydbAdapter());
  
  // 5. Open (or create if doesn't exist) a Hive box named 'mydb_box'
  // This is like opening a database table that will hold Mydb objects
  await Hive.openBox<Mydb>('mydb_box');


The <Mydb> in await Hive.openBox<Mydb>('mydb_box')
 refers to your model class that you defined in
  mydb_model.dart.

final box = await Hive.openBox<Mydb>('mydb_box');

// This works because we're adding a Mydb object
box.add(Mydb(name: "Alice", domain: "alice.com"));

*/
