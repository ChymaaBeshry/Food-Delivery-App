import 'package:flutter/material.dart';
import 'package:food_delivery_app/View/SharedThemes/colorsManager.dart';
import 'package:food_delivery_app/View/SharedThemes/valuesManager.dart';
import 'package:food_delivery_app/View/sharedCombonent/component.dart';
import '../../Model/productModel.dart';
import '../SharedThemes/fontsManager.dart';
import 'bottomSheetDetails.dart';
class HomeProductWidget extends StatelessWidget {
   HomeProductWidget({Key? key,required this.productModel}) : super(key: key);
  ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        showModalBottomSheet<void>(
            backgroundColor: ColorsManager.transparentColor,
            context: context,
            builder: (BuildContext context) {
              return  BottomSheetDetails(cart: false,productModel: productModel,);
            });
      },
      child: Container(
        color: ColorsManager.transparentColor,
        margin:const EdgeInsetsDirectional.only(
            top: AppSize.size20,
            start: AppSize.size10
        ),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              height: AppSize.size250,
              margin:const EdgeInsetsDirectional.only(
                top: AppSize.size20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(AppSize.size30),
                  gradient:const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      ColorsManager.blackColor,
                      ColorsManager.whiteColor
                    ],
                  )
              ),
              alignment: Alignment.bottomCenter,
              child:Padding(
                padding:const EdgeInsets.symmetric(vertical: AppSize.size25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Text("  ${productModel.productName}",style: FontsManager.getTextStyleBold(),)),
                    textBackground(
                      title: "${productModel.productPrice} GEP",
                      color: ColorsManager.blackColor
                    ),
                  ],
                ),
              ),
            ),
           // circleContainer(img: productModel.productImg),

            circleAvatar(radius: AppSize.size70,img:productModel.productImg ),

//Directional
          ],
        ),
      ),
    );
  }
}
