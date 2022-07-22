import 'package:flutter/material.dart' hide Image;
import 'package:flutter/scheduler.dart';
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
  int _page = 0;
  bool connecting = false;

  @override
  void initState() {
    super.initState();
    _loadMore(0);
  }

  void _loadMore(int index) {
    debugPrint(index.toString());
    if(imageList.isEmpty && _page == 0) {
      _apiGetImage(page: _page++);
    } else if(!connecting && (index == (imageList.length - 5))) {
      _apiGetImage(page: _page++);
    }
  }

  void _apiGetImage({required int page}) async {
    debugPrint("Serverga ketdi");
    connecting = true;
    if(mounted) setState(() {});

    String? resAllImages = await NetworkService.GET(NetworkService.API_IMAGE_LIST, NetworkService.paramsImageSearch(size: "full", limit: 20, page: page));
    imageList.addAll(imageListFromJson(resAllImages!));

    connecting = false;
    if(mounted) setState(() {});
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
          _loadMore(index);

          return ImageView(image: imageList[index]);
        },
      ),
    );
  }
}
