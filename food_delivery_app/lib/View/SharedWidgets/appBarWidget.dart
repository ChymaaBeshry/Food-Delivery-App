
import 'package:flutter/material.dart';

import '../SharedThemes/colorsManager.dart';
import '../SharedThemes/iconsManager.dart';
import '../sharedCombonent/component.dart';

class AppBarWidget extends StatelessWidget {
   AppBarWidget({Key? key,required this.title}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:  sharedIcon(
        color:ColorsManager.whiteColor,
        onPressed: (){
          Navigator.pop(context);
        },
        icon:IconsManager.leftIcon,
      ),
      title:Text(title),

    );
  }
}
