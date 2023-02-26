import 'package:flutter/material.dart';

import '../../SharedThemes/StringManager.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedThemes/valuesManager.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}
class _ContactUsScreenState extends State<ContactUsScreen> {

  List contactIcons=[
    IconsManager.iconMessage,
    IconsManager.locationIcon,
    IconsManager.phoneIcon,
    IconsManager.iconWatch,
  ];
  List contactTitle=[
    StringsManager.emailApp,
    StringsManager.addressApp,
    StringsManager.phoneApp,
    StringsManager.timeApp,
  ];

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
          centerTitle: true,
          elevation:  AppSize.size0,
          backgroundColor: ColorsManager.blackColor,
          title: Text(
            "Contact Us",
            style: FontsManager.getTextStyleBold(color:  ColorsManager.whiteColor),
          ),
        ),
        body:Column(
          children: [
           //apartmentDetail(contactUsList[0]["title"], contactUsList[0]["icon"]),
            for(int i=0 ; i<=3 ;i++)
            cantactSection(contactIcons[i],contactTitle[i]),

          ],
        ),
    );
  }
Container cantactSection(IconData icon,String title)=> Container(
  margin: const EdgeInsetsDirectional.all( AppSize.size20),
  child: Row(

    children: [
      Icon(icon,color: ColorsManager.blackColor,size:  AppSize.size25,),
      Text(title,style: FontsManager.getTextStyleLight(),)
    ],
  ),
);
}