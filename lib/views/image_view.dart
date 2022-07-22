import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:my_dog_app/models/image_model.dart';

class ImageView extends StatefulWidget {
  final Image image;
  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  late Image image;
  double ratio = 16 / 9;

  @override
  void initState() {
    super.initState();
    _convertData();
  }

  void _convertData() {
    image = widget.image;
    if(image.width != null && image.height != null) {
      ratio = image.width! / image.height!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: CachedNetworkImage(
        imageUrl: image.url!,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
