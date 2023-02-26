import 'package:flutter/material.dart';

import '../../SharedThemes/StringManager.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedThemes/valuesManager.dart';
import '../../sharedCombonent/component.dart';




class PolicyScreen extends StatefulWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  List policyTitleList=StringsManager.policyTitleList;
  List policySubList=StringsManager.policySubList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        appBar:AppBar(
          leading:  sharedIcon(
            color:ColorsManager.whiteColor,
            onPressed: (){
              Navigator.pop(context);
            },
            icon:IconsManager.leftIcon,
          ),
          title: const Text("'Terms & Policy"),

        ),
        body: ListView(
          children: [
            /*Container(
              margin: EdgeInsetsDirectional.all(AppSize.size20),
                child: Text(StringsManager.policyDescription,style: SharedFonts.subOrangeFont,)),
            Container(
              margin: EdgeInsetsDirectional.all(AppSize.size20),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                color: SharedColors.GreykColor,
              ),
              child: Column(
                children: [
                  for(int i=0 ; i<=21; i++)
                  Text(policyDataList[i],style: SharedFonts.primaryBlackFont,),

                ],
              ),
            ),*/
            for(int i=0; i<6 ; i++)
                Column(
                  children: [
                        Text("\n${policyTitleList[i]}",style: FontsManager.getTextStyleBold(),textAlign: TextAlign.center,),
                  Container(
                      margin: const EdgeInsetsDirectional.all(AppSize.size20),
                      padding: const EdgeInsetsDirectional.all(AppSize.size20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
                          color:  ColorsManager.lightGreyColor,
      ),
                      child: Text(policySubList[i],style: FontsManager.getTextStyleBold(),))
    ]
    ),

          ],
        ),
    );
  }}