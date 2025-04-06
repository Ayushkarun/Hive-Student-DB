// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mydb_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MydbAdapter extends TypeAdapter<Mydb> {
  @override
  final int typeId = 0;

  @override
  Mydb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mydb(
      name: fields[0] as String,
      domain: fields[1] as String,
      age: fields[2] as String,
      place: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Mydb obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.domain)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.place);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MydbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
