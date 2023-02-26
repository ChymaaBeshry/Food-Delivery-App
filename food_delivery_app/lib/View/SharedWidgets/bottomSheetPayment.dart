import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/TicketCubit/ticketController.dart';
import 'package:food_delivery_app/View/SharedThemes/fontsManager.dart';
import 'package:food_delivery_app/View/sharedCombonent/component.dart';
import '../../Controller/MapCubit/mapController.dart';
import '../../Controller/UserCubit/userController.dart';
import '../../Controller/productCubit/productController.dart';
import '../SharedThemes/colorsManager.dart';
import '../SharedThemes/valuesManager.dart';
class BottomSheetPayment extends StatelessWidget {
   BottomSheetPayment({Key? key}) : super(key: key);
GlobalKey addressKey=GlobalKey<ScaffoldState>();
TextEditingController addressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProductController productController= BlocProvider.of<ProductController>(context);
    MapController mapController= BlocProvider.of<MapController>(context);
    UserController userController=BlocProvider.of<UserController>(context);

    return decoration(
      width:double.infinity ,
      smallHeight:700 ,
      marginBottom:0 ,
      widget:ListView(
        children: [
          textBackground(
              title: "we will Deliver in ${productController.totalTimeForPreparation+mapController.time} minute to the address",
              color: ColorsManager.blackColor),

          for(int i=0; i<productController.cartProducts.length;i++)
            listTilePrice(
                title:productController.cartProducts[i].productName ,
                trailing:"    ${productController.cartProducts[i].productPrice} EGP",
                subTitle:"    ${productController.cartProducts[i].qty} item",
            ),
          listTilePrice(
              title:"Address ",
              trailing:"\n\n To ${mapController.placeApp}",
              subTitle:" ${mapController.address}",
          ),
          listTilePrice(
            title:userController.user.userName,
            trailing:"\n\n ${userController.user.userEmail}",
            subTitle:" ${userController.user.userPhone}",
          ),
          priceSection(title: "Total price", price:"${productController.cartTotalPrice+mapController.shipping} EGP"),
          priceSection(
              title:"Total Time",
              price: "${productController.totalTimeForPreparation+mapController.time} min"
          ),
          sharedButton(
            width:AppSize.size180 ,
            onPressed:()async{
              await BlocProvider.of<TicketController>(context).addUserTicket(
                 user:  userController.user,
                  price:  productController.cartTotalPrice+mapController.shipping ,
                   time: productController.totalTimeForPreparation+mapController.time,
                   appAddress: mapController.placeApp,
                    cartList:productController.cartProducts );
              Navigator.pushNamed(context,"ticket");
            },
            title: "Done",),



        ],
      ),

    );
  }


}
