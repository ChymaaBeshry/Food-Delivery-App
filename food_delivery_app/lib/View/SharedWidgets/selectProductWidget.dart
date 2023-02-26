import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/productCubit/productController.dart';
import 'package:food_delivery_app/Controller/productCubit/productStates.dart';
import 'package:food_delivery_app/View/SharedThemes/fontsManager.dart';

import '../../Model/productModel.dart';
import '../SharedThemes/colorsManager.dart';
import '../SharedThemes/iconsManager.dart';
import '../SharedThemes/valuesManager.dart';
import '../sharedCombonent/component.dart';
import 'bottomSheetDetails.dart';
class SelectProductWidget extends StatelessWidget {
  SelectProductWidget({Key? key,required this.cart,required this.productModel}) : super(key: key);
  ProductModel productModel;
bool cart=false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductController,ProductStates>(
      builder: (context,state){
        return Stack(
            alignment: Alignment.topRight,
            children:[
              decoration(
                marginBottom:AppSize.size0,
                width: double.infinity,
                smallHeight: AppSize.size100,
                widget:InkWell(
                  onTap: (){
                    showModalBottomSheet<void>(
                        backgroundColor: ColorsManager.transparentColor,
                        context: context,
                        builder: (BuildContext context) {
                          return  BottomSheetDetails(cart: cart,productModel: productModel,);
                        });
                  },
                  child: Row(
                    children: [
                     // circleContainer(img: productModel.productImg),
                      circleAvatar(radius: AppSize.size50,img: productModel.productImg),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(productModel.productName,style: FontsManager.getTextStyleBold(),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(child: textBackground(title: "${productModel.totalPrice} EGP", color: ColorsManager.blackColor)),
                                textBackground(title:cart==false?"${productModel.productDetailsValue[0].toString()} Kacl":"${productModel.qty} item", color: ColorsManager.blackColor),

                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              cart==true?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: sharedIcon(
                    icon: IconsManager.deleteIcon,
                    onPressed: (){
                      BlocProvider.of<ProductController>(context).removeCartProduct(productModel);
                    },
                    color: ColorsManager.blackColor),
              ):const SizedBox(),
            ]


        );
      },
    );
  }
}
