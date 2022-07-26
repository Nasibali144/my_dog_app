import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_dog_app/models/image_model.dart' as model;
import 'package:my_dog_app/services/network_service.dart';
import 'package:my_dog_app/views/gallery_view.dart';

class DetailPage extends StatefulWidget {
  final int crossAxisCount;
  final model.Image image;

  const DetailPage({Key? key, required this.image, this.crossAxisCount = 2}) : super(key: key);

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

  int get limit {
    return widget.crossAxisCount * 15;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.1),
                  ]
                )
              ),
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
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: GalleryView(
                api: NetworkService.API_IMAGE_LIST,
                crossAxisCount: widget.crossAxisCount,
                params: NetworkService.paramsImageSearch(size: "full", breedId: image.breedIds,
                    limit: limit,
                ),
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
