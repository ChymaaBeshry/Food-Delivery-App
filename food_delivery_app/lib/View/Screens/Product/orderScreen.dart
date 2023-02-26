import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/MapCubit/mapController.dart';
import 'package:food_delivery_app/Controller/MapCubit/mapStates.dart';
import 'package:food_delivery_app/View/SharedThemes/valuesManager.dart';
import 'package:food_delivery_app/View/sharedCombonent/component.dart';
import '../../../Controller/UserCubit/userController.dart';
import '../../../Controller/productCubit/productController.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedWidgets/TextFormFieldWidget.dart';
import '../../SharedWidgets/bottomSheetPayment.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  GlobalKey addressKey=GlobalKey<ScaffoldState>();
  TextEditingController addressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProductController productController= BlocProvider.of<ProductController>(context);
    MapController mapController= BlocProvider.of<MapController>(context);
    return  BlocBuilder<MapController,MapStates>(
        builder: (context,state){
           return Scaffold(
             body: Container(
               // height:AppSize.size700
               padding:const EdgeInsets.symmetric(
                 horizontal: AppSize.size5,
                 vertical: AppSize.size40,
               ),
               decoration: const BoxDecoration(
                   borderRadius: BorderRadiusDirectional.only(
                     topEnd:Radius.circular(AppSize.size40) ,
                     topStart:Radius.circular(AppSize.size40)  ,
                   ),
                   color: ColorsManager.whiteColor
               ),
               child:ListView(
                 children: [
                   textBackground(
                       title: "we will Deliver in  ${productController.totalTimeForPreparation+mapController.time}  minute to the address",
                       color: ColorsManager.blackColor),
                   for(int i=0; i<productController.cartProducts.length;i++)
                     ListTile(
                       //leading: circleContainer(img: productModel.productImg),
                       leading:circleAvatar(radius: AppSize.size40,img:productController.cartProducts[i].productImg),
                       trailing:Text("${productController.cartProducts[i].totalPrice} EGP",style: FontsManager.getTextStyleLight(),) ,
                       title:Text("${productController.cartProducts[i].productName} ",style: FontsManager.getTextStyleBold(),) ,
                       subtitle: Text("${productController.cartProducts[i].qty} item",style: FontsManager.getTextStyleLight(
                           color: ColorsManager.greyLightColor
                       ),),
                     ),


                   Text("\n        Address",style: FontsManager.getTextStyleBold(),),
                   InputField(model: InputModel(
                       key:addressKey ,
                       controller:addressController ,
                       validator:(addressController){} ,
                       width:AppSize.size150 ,
                       title: mapController.address,
                       onSubmitted:()async {
                        await mapController.getSearchLocation(addressController.text);
                       // await  mapController.getPlaceMarktoApp();
                        mapController.address=addressController.text;
                        BlocProvider.of<UserController>(context).user.userAddress=addressController.text;
                       }

                   )),
                   priceSection(
                       title:"Price",
                       price: "${productController.cartTotalPrice} EGP"
                   ),
                   ListTile(
                     //leading:circleAvatar(radius: AppSize.size40),
                     title:Text("\n Shipping",style: FontsManager.getTextStyleBold(),),
                     subtitle:Text("${mapController.address}, To ${mapController.placeApp}",style: FontsManager.getTextStyleLight(),) ,
                     trailing: Text("\n ${mapController.shipping} EGP",style: FontsManager.getTextStyleLight(
                         color: ColorsManager.greyLightColor
                     ),),
                   ),
                   priceSection(
                       title:"Total Price",
                       price: "${productController.cartTotalPrice+mapController.shipping} EGP"
                   ),
                   priceSection(
                       title:"Preparation Time",
                       price: "${productController.totalTimeForPreparation} min",
                   ),

                   priceSection(
                       title:"Delivery Time",
                       price: "${mapController.time} min",
                   ),

                   priceSection(
                       title:"Total Time",
                       price: "${productController.totalTimeForPreparation+mapController.time} min"
                   ),
                   sharedButton(
                     width:AppSize.size180 ,
                     onPressed:(){
                       showModalBottomSheet<void>(
                           backgroundColor: ColorsManager.transparentColor,
                           context: context,
                           builder: (BuildContext context) {
                             return  BottomSheetPayment();
                           });
                     },
                     title: "Done",),



                 ],
               ),

             ),
           );

    });

  }
}
