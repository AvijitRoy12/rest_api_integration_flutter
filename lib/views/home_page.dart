// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rest_api_integration_flutter/models/photos.dart';
import 'package:rest_api_integration_flutter/models/post.dart';
import 'package:rest_api_integration_flutter/services/photo_service.dart';
import 'package:rest_api_integration_flutter/services/remote_service.dart';
import 'package:rest_api_integration_flutter/views/photo_display.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  List<Photo>? photos;

  var isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
    getPhotoData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  getPhotoData() async {
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                  child: Text("API Integration",
                      style: TextStyle(fontSize: 20, color: Colors.white))),
            ),
            ListTile(
              leading: Icon(Icons.emoji_transportation),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (c) => HomePage()),
                    (route) => false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_transportation),
              title: Text('Photos'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (c) => HomePage()),
                    (route) => false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhotoPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Information'),
      ),
      body: Visibility(
        visible: isloaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          photos![index].url ?? '',
                        )),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts![index].title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          posts![index].body ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        replacement: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
