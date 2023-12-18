import "package:hive/hive.dart";
part 'dog.g.dart';

@HiveType(typeId: 1)
class Dog extends HiveObject {

  @HiveField(0)
  Map breed;

  @HiveField(1)
  String img;
  
  
  Dog({required this.breed,required this.img});

}
