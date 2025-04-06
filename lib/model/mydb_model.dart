
import 'package:hive/hive.dart';

import 'package:hive_flutter/adapters.dart';

part 'mydb_model.g.dart';

@HiveType(typeId: 0)
class Mydb
{

  @HiveField(0)
  late String name;

  @HiveField(1)
  late String domain;

  @HiveField(2)
  late String age;

  @HiveField(3)
  late String place;

  Mydb({required this.name,required this.domain,required this.age,required this.place,});

}
