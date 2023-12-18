import 'package:dogbreeds_app/model/dog.dart';
import 'package:hive/hive.dart';
import 'dog_api_client.dart';

class DogRepository {

  
  DogApiClient dogApiClient = DogApiClient();

  Future<List<Dog>> getDogList() async {

List<Dog> dogList = await dogApiClient.getDogList();

Box<Dog> dogBox = Hive.box<Dog>("dogs");

await dogBox.clear();

for (Dog dog in dogList) {

  dogBox.add(dog);
  
}
    return dogList;
  }
}