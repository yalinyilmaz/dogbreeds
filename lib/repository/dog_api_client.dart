import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/dog.dart';

class DogApiClient {
  static const baseUrl1 = "https://dog.ceo/api/breeds";
  static const baseUrl2 = "https://dog.ceo/api/breed/";

  Future<List<Dog>> getDogList() async {
    const breedListURL = "$baseUrl1/list/all";
    final gelenCevap = await http.get(Uri.parse(breedListURL));

    if (gelenCevap.statusCode != 200) {
      throw Exception("Veri Getirilemedi");
    }

    final gelenCevapJSON = (jsonDecode(gelenCevap.body)) as Map;

    List breedList = (gelenCevapJSON["message"] as Map)
        .entries
        .map((e) => {e.key: e.value})
        .toList();

    List<String> dogimages = [];

    for (var element in breedList) {
      String eachBreed = (element as Map).keys.toList()[0].toString();

      var imgListURL = "$baseUrl2$eachBreed/images";

      final response = await http.get(Uri.parse(imgListURL));

      if (response.statusCode != 200) {
        throw Exception("Veri Getirilemedi");
      }

      final responseJSON = (jsonDecode(response.body)) as Map;

      dogimages.add(responseJSON["message"][0]);
    }

    //Aşağıdaki dosyalar API'dan 404 hatası alıp hatalı geliyordu, o yüzden kendim setledi

    dogimages[5] =
        "https://media.istockphoto.com/id/493885769/tr/foto%C4%9Fraf/running-purebred-dog.jpg?s=1024x1024&w=is&k=20&c=7h8dbQovOXwkJPsyDTAcLN-eJHMa6uAemv1YMgo3ZT4=";
    dogimages[6] = dogimages[19] = dogimages[21] = dogimages[41] =
        dogimages[43] = dogimages[50] = dogimages[54] = dogimages[62] =
            dogimages[64] = dogimages[69] = dogimages[74] = dogimages[77] =
                dogimages[80] = dogimages[90] = dogimages[94] = dogimages[96] =
                    "https://dogisworld.com/wp-content/uploads/2020/11/Cover-3.png";

  

    List<Dog> dogs = List.generate(breedList.length,
        (index) => Dog(breed: breedList[index], img: dogimages[index]));


    return dogs;
  }
}
