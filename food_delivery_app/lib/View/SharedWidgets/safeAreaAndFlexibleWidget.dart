import 'package:flutter/material.dart';
import 'package:food_delivery_app/Model/productModel.dart';
import 'package:food_delivery_app/View/SharedWidgets/selectProductWidget.dart';

import '../SharedThemes/colorsManager.dart';
import '../SharedThemes/fontsManager.dart';
import '../SharedThemes/iconsManager.dart';
import '../sharedCombonent/component.dart';
class SafeAreaAndFlexibleWidget extends StatelessWidget {
  SafeAreaAndFlexibleWidget({Key? key,required this.itemBuilder,required this.onPressed}) : super(key: key);
 List<ProductModel> itemBuilder;
 VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      SafeArea(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sharedIcon(
                  icon: IconsManager.leftIcon,
                  onPressed:onPressed,
                  color: ColorsManager.blackColor),
              textBackground(
                  title: "${itemBuilder.length} items",
                  color: ColorsManager.greyLightColor)
            ]),
      ),

      Flexible(
  child: ListView.builder(
    scrollDirection: Axis.vertical,
  itemBuilder: (context, index) => SelectProductWidget(cart: true,productModel:itemBuilder[index]  ),
  itemCount:itemBuilder.length,
  )),
    ],
    );
  }
}
