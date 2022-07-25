import 'package:flutter/material.dart' hide Image;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_dog_app/models/image_model.dart';
import 'package:my_dog_app/services/network_service.dart';
import 'package:my_dog_app/views/image_view.dart';

class GalleryView extends StatefulWidget {
  final int crossAxisCount;
  final String api;
  final Map<String, String> params;
  const GalleryView({Key? key, this.crossAxisCount = 2, required this.api, required this.params}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {

  List<Image> items = [];

  @override
  void initState() {
    super.initState();
    apiGetAllImage();
  }

  void apiGetAllImage() async {
    String? resAllImages = await NetworkService.GET(widget.api, widget.params);
    items = imageListFromJson(resAllImages!);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: widget.crossAxisCount,
      itemCount: items.length,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return ImageView(image: items[index]);
      },
    );
  }
}
