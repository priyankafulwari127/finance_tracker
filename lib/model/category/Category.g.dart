// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 0;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      categoryName: fields[0] as String,
      iconPoints: fields[1] as int,
      fontFamily: fields[2] as String?,
      iconFontPackage: fields[3] as String?,
      categoryBudget: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.iconPoints)
      ..writeByte(2)
      ..write(obj.fontFamily)
      ..writeByte(3)
      ..write(obj.iconFontPackage)
      ..writeByte(4)
      ..write(obj.categoryBudget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CategoryAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
