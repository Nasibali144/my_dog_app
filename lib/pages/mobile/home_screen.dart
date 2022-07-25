import 'package:flutter/material.dart' hide Image;
import 'package:my_dog_app/models/image_model.dart';
import 'package:my_dog_app/services/network_service.dart';
import 'package:my_dog_app/views/gallery_view.dart';

class HomeScreen extends StatefulWidget {
  final int crossAxisCount;
  const HomeScreen({Key? key, this.crossAxisCount = 2}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();
  int currentScreen = 0;
  List<Image> allImage = [];

  void pressButton(int screen) {
    currentScreen = screen;
    controller.jumpToPage(screen);
    setState(() {});
  }

  void onScreenChanged(int screen) {
    currentScreen = screen;
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // #all
            ElevatedButton(
              onPressed: () => pressButton(0),
              style: ElevatedButton.styleFrom(
                primary: currentScreen == 0 ? Colors.black : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: const StadiumBorder(),
              ),
              child: Text("All", style: TextStyle(color: currentScreen == 0 ? Colors.white : Colors.black, fontSize: 20),),
            ),

            // #me
            ElevatedButton(
              onPressed: () => pressButton(1),
              style: ElevatedButton.styleFrom(
                primary: currentScreen == 1 ? Colors.black : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: const StadiumBorder(),
              ),
              child: Text("My Dogs", style: TextStyle(color: currentScreen == 1 ? Colors.white : Colors.black, fontSize: 20),),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: onScreenChanged,
        children: [
          GalleryView(api: NetworkService.API_IMAGE_LIST, crossAxisCount: widget.crossAxisCount, params: NetworkService.paramsImageSearch(size: "full"),),
          Container(color: Colors.cyan,),
        ],
      ),
    );
  }
}

