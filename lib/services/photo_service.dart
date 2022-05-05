import 'package:rest_api_integration_flutter/models/photos.dart';
import 'package:http/http.dart' as http;

class PhotoService{
  Future<List<Photo>?> getPhotos() async{
    var client = http.Client();

    var uri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return postFromJson(json);
    }
  }
}