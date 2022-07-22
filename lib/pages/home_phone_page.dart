import 'package:flutter/material.dart' hide Image;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_dog_app/models/image_model.dart';
import 'package:my_dog_app/services/network_service.dart';
import 'package:my_dog_app/views/image_view.dart';

class HomePhonePage extends StatefulWidget {
  const HomePhonePage({Key? key}) : super(key: key);

  @override
  State<HomePhonePage> createState() => _HomePhonePageState();
}

class _HomePhonePageState extends State<HomePhonePage> {
  List<Image> imageList = [];

  @override
  void initState() {
    super.initState();
    _apiGetImage();
  }

  void _apiGetImage() async {
    String? resAllImages = await NetworkService.GET(NetworkService.API_IMAGE_LIST, NetworkService.paramsImageSearch(size: "full", limit: 100));
    imageList = imageListFromJson(resAllImages!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("For Learn and Testing"),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: MasonryGridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return ImageView(image: imageList[index]);
        },
      ),
    );
  }
}
