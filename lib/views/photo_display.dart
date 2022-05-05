import 'package:flutter/material.dart';
import 'package:rest_api_integration_flutter/models/post.dart';
import 'package:rest_api_integration_flutter/services/photo_service.dart';
import 'package:rest_api_integration_flutter/models/photos.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<Photo>? photos;

  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    photos = await PhotoService().getPhotos();
    if (photos != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Photos'),
      ),
      body: Visibility(
        visible: isloaded,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          photos![index].url,
                        )),
                  ),
                  Container(
                    child: Text(photos![index].title),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
        replacement: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
