import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/View/SharedThemes/fontsManager.dart';
import '../../Controller/UserCubit/userController.dart';
import '../SharedThemes/colorsManager.dart';
import '../SharedThemes/iconsManager.dart';
import '../SharedThemes/imagesManager.dart';
import '../SharedThemes/valuesManager.dart';
import '../sharedCombonent/component.dart';
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    UserController userController = BlocProvider.of<UserController>(context);

    return  Drawer(
      backgroundColor: ColorsManager.whiteColor,
      width: AppSize.size250,
      elevation: AppSize.size25,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
            color: ColorsManager.blackColor, width: AppSize.size5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.size150),
          bottomRight: Radius.circular(AppSize.size150)
          // bottomRight: Radius.circular(0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSize.size50),
        child: Column(
          children: [
            circleAvatar2(
                img:ImagesManager.logo ,
                radius: AppSize.size55
            ),
            Text(" ${userController.user.userName} ",style: FontsManager.getTextStyleBold(),),
            Text("${userController.user.userEmail}  \n",style: FontsManager.getTextStyleLight(color: ColorsManager.greyLightColor),),
            divider(ColorsManager.greyLightColor),
            listTileDrawer(title: settingsData[0]["title"],screen: settingsData[0]["screen"]),
            Text("settings\n",style: FontsManager.getTextStyleBold(),),
            divider(ColorsManager.greyLightColor),
            for(int i=1; i<6; i++)
            listTileDrawer(title:settingsData[i]["title"],screen: settingsData[i]["screen"], ),
            sharedTextButton(title: "LOG OUT", onPressed:(){
            //  print("dgggggggggggggg");
              Navigator.popAndPushNamed(context, "login");
            }, color: ColorsManager.redColor)


          ],
        ),
      ),
    );
  }
  List<Map<String,dynamic>> settingsData=[
    {
      "title":"My Account",
      "screen":"account",
    },
    {
      "title":"orders List",
      "screen":"ticket",
    },
    {
      "title":"Settings",
      "screen":"settings",
    },
    {
      "title":"Contact US",
      "screen":"contact",
    },
    {
      "title":"About US",
      "screen":"about",
    },
    {
      "title":"Policy & Terms",
      "screen":"policy",
    },
  ];
  ListTile listTileDrawer({ required String title, required String screen})=> ListTile(
  title:Text(title,style: FontsManager.getTextStyleBold(),),
  trailing:  sharedIcon(icon: title == "My Account" ?  IconsManager.personIcon: IconsManager.iconRight,
      onPressed: title == "My Account" ? (){
    Navigator.pushNamed(context,screen);

      }:(){
  Navigator.pushNamed(context,screen);

  }, color: ColorsManager.blackColor)
  );
}
