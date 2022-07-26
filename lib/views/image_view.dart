import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_dog_app/models/image_model.dart' as model;

class ImageView extends StatefulWidget {
  final model.Image image;

  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late model.Image image;
  double ratio = 16 / 9;

  @override
  void initState() {
    super.initState();
    _convertData();
  }

  void _convertData() {
    image = widget.image;
    if (image.width != null && image.height != null) {
      ratio = image.width! / image.height!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(image.toJson().toString());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        // #image
        GestureDetector(
          onDoubleTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: ratio,
              child: CachedNetworkImage(
                imageUrl: image.url!,
                placeholder: (context, url) => Container(
                  color: Colors.primaries[Random().nextInt(18) % 18],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),

        // #image_data

        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(bottom: 10, top: 5, left: 5),
          title: image.breeds != null && image.breeds!.isNotEmpty
              ? Text(image.breeds!.first.name ?? "", maxLines: 1, overflow: TextOverflow.ellipsis,) : null,
          subtitle: image.breeds != null && image.breeds!.isNotEmpty
              ? Text(image.breeds!.first.temperament ?? "", maxLines: 2, overflow: TextOverflow.ellipsis,) : null,
          trailing: IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_outlined),
          ),
        ),
      ],
    );
  }
}
