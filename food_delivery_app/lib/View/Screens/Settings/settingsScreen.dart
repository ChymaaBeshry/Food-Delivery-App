import 'package:flutter/material.dart';


import '../../SharedThemes/StringManager.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedThemes/valuesManager.dart';
import '../../sharedCombonent/component.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final popKey=GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          leading:  sharedIcon(
            color:ColorsManager.whiteColor,
            onPressed: (){
              Navigator.pop(context);
            },
            icon:IconsManager.leftIcon,
          ),
          title:const Text("settings"),

        ),
        body: Column(children: [

         for(int i=0 ;i<3;i++)
           accountSection(
             settingsSectionDetails[i]["icon1"],
             settingsSectionDetails[i]["title"],
             settingsSectionDetails[i]["title2"],
             settingsSectionDetails[i]["notification"],
             settingsSectionDetails[i]["key"],
             settingsSectionDetails[i]["data"],
             context),

        ],),
    );
  }
  Padding accountSection(IconData icon1, String title, String title2,
      bool isNotification, Key key, List data, context) =>
      Padding(
        padding: const EdgeInsets.all(AppSize.size20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon1,
                  color: ColorsManager.blackColor,
                ),
                Text(
                  title,
                  style: FontsManager.getTextStyleBold(),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  title2,
                  style: FontsManager.getTextStyleBold(),
                ),
                isNotification == true
                    ? IconButton(
                  icon: const Icon(IconsManager.leftIcon),
                  onPressed: () {},
                )
                    : PopupMenuButton(
                    key: key,
                    elevation: AppSize.size10,
                    icon: const Icon(IconsManager.menuIcon),
                    itemBuilder: (context) => [
                      for (int i = 0; i < 5; i++)
                        PopupMenuItem(
                          child: Text(data[i]),
                          //value: Categorytitle[0] ,
                        ),
                    ]),
              ],
            ),
          ],
        ),
      );
  List<Map<String, dynamic>> settingsSectionDetails = [
    {
      "icon1": IconsManager.locationIcon,
      "title": "Country",
      "title2": "Egypt",
      "key": GlobalKey<PopupMenuButtonState>(),
      "data": [
        "Helwan , Egypt ",
        "Cairo , Egypt",
        "Giza , Egypt",
        "Maadi , Egypt",
        "Aswan , Egypt",
      ],
      "notification": false,
    },
    {
      "icon1": IconsManager.iconInfo,
      "title": StringsManager.language,
      "title2": StringsManager.arabic,
      "key": GlobalKey<PopupMenuButtonState>(),
      "data": [
        StringsManager.english,
        StringsManager.arabic,
        StringsManager.german,
        StringsManager.spanish,
        StringsManager.french,
      ],
      "notification": false,
    },
    {
      "icon1": IconsManager.locationIcon,
      "title": StringsManager.notification,
      "title2": "4 ",
      "key": GlobalKey<PopupMenuButtonState>(),
      "data": [
        "Helwan , Egypt ",
        "Cairo , Egypt",
        "Giza , Egypt",
        "Maadi , Egypt",
        "Aswan , Egypt",
      ],
      "notification": true,
    },
  ];
}