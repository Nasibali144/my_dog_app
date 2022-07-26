import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_dog_app/models/image_model.dart' as model;

class DetailPage extends StatefulWidget {
  final model.Image image;

  const DetailPage({Key? key, required this.image}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
    return Scaffold(

      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 35,
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_outlined, size: 30,),
          )
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: AspectRatio(
              aspectRatio: ratio,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: image.url!,
                placeholder: (context, url) => Container(
                  color: Colors.primaries[Random().nextInt(18) % 18],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
