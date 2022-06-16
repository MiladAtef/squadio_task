// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PopularPersonModelAdapter extends TypeAdapter<PopularPersonModel> {
  @override
  final int typeId = 1;

  @override
  PopularPersonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PopularPersonModel(
      image: fields[0] as String,
      name: fields[1] as String,
      id: fields[2] as String,
      knownForDepartment: fields[3] as String,
      gender: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PopularPersonModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.knownForDepartment)
      ..writeByte(4)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopularPersonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
