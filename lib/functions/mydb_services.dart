import 'package:adder/model/mydb_model.dart';
import 'package:hive/hive.dart';

class MydbServices {
  Box<Mydb>? _mydbBox;

  Future<void> openBox() async {
    _mydbBox = await Hive.openBox<Mydb>('mydb_box');
  }

  Future<void> closeBox() async {
    await _mydbBox!.close();
  }

  Future<void> addMydb(Mydb mydb) async {
    //          ↑         ↑      ↑
    //     function   class   variable
    //       name      name     name
    if (_mydbBox == null) {
      await openBox();
    }
    await _mydbBox!.add(mydb);
  }

  Future<List<Mydb>> getMydb() async {
    if (_mydbBox == null) {
      await openBox();
    }
    return _mydbBox!.values.toList();
  }

  Future<void> updateMydb(int index, Mydb mydb) async {
    if (_mydbBox == null) {
      await openBox();
    }

    await _mydbBox!.putAt(index, mydb);
  }

  Future<void> deleteMydb(int index) async{
        if (_mydbBox == null) {
      await openBox();
    }
    await _mydbBox!.deleteAt(index);
  }
}
