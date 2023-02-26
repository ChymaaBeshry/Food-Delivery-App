import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/productCubit/productController.dart';
import 'package:food_delivery_app/View/SharedThemes/valuesManager.dart';
import 'package:food_delivery_app/View/sharedCombonent/component.dart';

import '../../../Controller/productCubit/productStates.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedWidgets/bottomSheetPayment.dart';
import '../../SharedWidgets/safeAreaAndFlexibleWidget.dart';
import '../../SharedWidgets/selectProductWidget.dart';
import 'orderScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key,}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ProductController productController=BlocProvider.of<ProductController>(context);
    return BlocBuilder<ProductController,ProductStates>(
      builder: (context,state){
        productController.getCartTotalPrice();
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /*SafeAreaAndFlexibleWidget(itemBuilder: productController.cartProducts,onPressed: (){
                Navigator.pop(context);
              },),*/
              SafeArea(

                  child:   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sharedIcon(
                            icon: IconsManager.leftIcon,
                            onPressed:(){
                              Navigator.pop(context);
                            },
                            color: ColorsManager.blackColor),
                        textBackground(
                            title: " ${productController.cartProducts.length} items",
                            color: ColorsManager.greyLightColor)
                      ]),),
              Flexible(
                  child: ListView.builder(
                    itemBuilder: (context, index) => SelectProductWidget(cart: true,productModel:productController.cartProducts[index]  ),
                    itemCount:productController.cartProducts.length,
                  )),
              Column(
                children: [
                  textBackground(title: "total Price ${productController.cartTotalPrice}EGP", color: ColorsManager.greyLightColor,),
                  textBackground(title: "PreparationTime ${productController.totalTimeForPreparation} min", color: ColorsManager.greyLightColor,),

                ],
              ),
              sharedButton(
                  onPressed: () {
                   /* showModalBottomSheet<void>(
                        backgroundColor: ColorsManager.transparentColor,
                        context: context,
                        builder: (BuildContext context) {
                          return BottomSheetPayment();
                        });*/
                    Navigator.pushNamed(context, "order");
                  },
                  title: "Order",
                  width: AppSize.size300)
            ],
          ),
        );

      },
    );
  }
}
