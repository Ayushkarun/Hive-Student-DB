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
