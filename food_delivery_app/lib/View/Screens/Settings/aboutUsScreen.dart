import 'package:flutter/material.dart';

import '../../SharedThemes/StringManager.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedThemes/valuesManager.dart';



class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
 static List<dynamic> aboutUsList=StringsManager.aboutUsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        appBar: AppBar(
          leading:   IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(IconsManager.leftIcon,color: ColorsManager.whiteColor,size: AppSize.size25,),

          ),
          title: Text(
            "About Us",
            style: FontsManager.getTextStyleBold(color: ColorsManager.whiteColor),
          ),
        ),
        body: Column(
          children: [
                for(int i=0 ; i<=4 ; i++)
                  aboutUsSection(i),

          ],
        ),
    );
  }
Row aboutUsSection(index)=>Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children:[
    Text(aboutUsList[index],style: FontsManager.getTextStyleSemiBold(),),
    IconButton(onPressed: (){},icon: const Icon(IconsManager.downIcon,color: ColorsManager.blackColor,))
  ],
);
}