import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final int crossAxisCount;

  const ProfilePage({Key? key, this.crossAxisCount = 2}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? file;
  final ImagePicker _picker = ImagePicker();

  void _getImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: _gallery,
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text("Camera"),
              onTap: () {
                print("Camera");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _gallery() async {
    Navigator.of(context).pop();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Upload",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: GestureDetector(
                onTap: _getImage,
                child: file == null
                    ? Container(
                  alignment: const Alignment(0, 0.35),
                  constraints: const BoxConstraints(
                    minWidth: 250,
                    minHeight: 250,
                    maxHeight: 400,
                    maxWidth: 400,
                  ),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                              image:
                                  AssetImage("assets/images/place_holder.jpeg"),
                            )
                  ),
                  child: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 80,
                        ),
                )
                    : Container(
                    constraints: const BoxConstraints(
                      minWidth: 250,
                      minHeight: 250,
                      maxHeight: 400,
                      maxWidth: 400,
                    ),
                    child: Image.file(file!, fit: BoxFit.cover,),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const TextField(
                decoration: InputDecoration(hintText: "Title"),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
