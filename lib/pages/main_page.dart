import 'package:flutter/material.dart';
import 'package:my_dog_app/pages/home_phone_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        // if(boxConstraints.maxWidth < 600) {
        //   // phone
        //   return ;
        // } if(boxConstraints.maxWidth < 1025) {
        //   // tablet
        //   return ;
        // } else {
        //   // desktop
        //   return ;
        // }

        return const HomePhonePage();
      }
    );
  }
}
