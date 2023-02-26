import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/productCubit/productController.dart';
import 'package:food_delivery_app/Controller/productCubit/productStates.dart';
import 'package:food_delivery_app/View/SharedThemes/colorsManager.dart';
import 'package:food_delivery_app/View/SharedThemes/fontsManager.dart';
import 'package:food_delivery_app/View/sharedCombonent/component.dart';

import '../../Model/productModel.dart';
import '../SharedThemes/iconsManager.dart';
import '../SharedThemes/valuesManager.dart';
class BottomSheetDetails extends StatefulWidget {
   BottomSheetDetails({Key? key,required this.cart,required this.productModel}) : super(key: key);
  bool cart=false;
   ProductModel productModel;

  @override
  State<BottomSheetDetails> createState() => _BottomSheetDetailsState();
}

class _BottomSheetDetailsState extends State<BottomSheetDetails> {
@override
  void initState() {
  BlocProvider.of<ProductController>(context).getPopTitle(widget.productModel);
    super.initState();
  }
  String subTitle="small";
  @override
  Widget build(BuildContext context) {
    ProductController productController= BlocProvider.of<ProductController>(context);
    return BlocBuilder<ProductController,ProductStates>(
        builder:(context,state){
          return decoration(
            width:double.infinity ,
            smallHeight:5000 ,
            marginBottom:0 ,
            widget:ListView(
              children:[
                //circleContainer(img:productModel.productImg ),
                circleAvatar(radius: AppSize.size150, img:widget.productModel.productImg),
                Text("\n${widget.productModel.productName}\n",style: FontsManager.getTextStyleBold(size: AppSize.size30),textAlign:TextAlign.center),
                Text(" ${widget.productModel.productDescription} \n ",
                    style: FontsManager.getTextStyleLight(color: ColorsManager.greyLightColor),textAlign:TextAlign.center),
                decoration(
                    widget: ListView.builder(
                      itemBuilder: (context,index)=> Column(
                        children: [
                          textBackground(title: widget.productModel.productDetailsValue[index].toString(), color: ColorsManager.greyLightColor),
                          Text(widget.productModel.productDetailsName[index],style: FontsManager.getTextStyleRegular(),)
                        ],
                      ),
                      itemCount: widget.productModel.productDetailsValue.length,
                      scrollDirection: Axis.horizontal,
                    ),
                    smallHeight: AppSize.size50,
                    width: double.infinity,
                    marginBottom:AppSize.size0
                ),
                ListTile(
                  title:Text("Size",style: FontsManager.getTextStyleBold(),) ,
                  subtitle:Text(subTitle,),
                  trailing: PopupMenuButton(
                    shape:const StadiumBorder(
                        side: BorderSide(
                            color: ColorsManager.darkBlueColor,
                            width: AppSize.sizeD1,
                            style: BorderStyle.solid
                        )
                    ),
                    elevation: 10,
                    itemBuilder: (context) =><PopupMenuEntry<int>> [
                      for(int i=0;i<widget.productModel.categoryNameSizes.length;i++)
                      PopupMenuItem(
                        value:  widget.productModel.categoryValueSizes[i],
                        child:Text(widget.productModel.categoryNameSizes[i]),
                        onTap: (){
                            widget.productModel.selectedSize=widget.productModel.categoryNameSizes[i];
                            subTitle =widget.productModel.selectedSize;
                            productController.calcPriceSize(sizeValue: widget.productModel.categoryValueSizes[i],
                            productModel: widget.productModel);
                        },
                      ),

                    ],
                  ),
                ),
                Row(
                  children: [
                    widgetBackground(
                      color: ColorsManager.greyLightColor,
                      widget: Row(
                        children: [
                          sharedIcon(
                              icon: IconsManager.subtractIcon,
                              onPressed: (){
                                productController.decQtyProduct(productModel: widget.productModel);
                              },
                              color: ColorsManager.whiteColor),
                          Text("${widget.productModel.qty}",style: FontsManager.getTextStyleLight(size: AppSize.size25),),
                          sharedIcon(
                              icon: IconsManager.addIcon,
                              onPressed: (){
                                productController.incQtyProduct(productModel: widget.productModel);
                              },
                              color: ColorsManager.whiteColor),
                        ],
                      ),
                    ),
                    Expanded(
                      child: sharedButton(
                        width:AppSize.size180 ,
                        onPressed:widget.cart==false? (){
                         BlocProvider.of<ProductController>(context).cartProducts.add(widget.productModel);
                          Navigator.pushNamed(context, "cart");
                        }:(){
                          Navigator.pop(context);
                        },
                        title:widget.cart==false?
                        "    ADD TO CART \n      ${widget.productModel.totalPrice} EGP":
                        " ${widget.productModel.totalPrice} EGP",),
                    ),
                  ],
                )

              ],
            ),

          );
        }

    );
  }
}
/*    // height:AppSize.size700
     /* padding:const EdgeInsets.symmetric(
        horizontal: AppSize.size5,
        vertical: AppSize.size40,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topEnd:Radius.circular(AppSize.size40) ,
          topStart:Radius.circular(AppSize.size40)  ,
        ),
        color: ColorsManager.whiteColor
      ),*/*/