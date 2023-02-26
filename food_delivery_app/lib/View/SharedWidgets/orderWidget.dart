import 'package:food_delivery_app/Model/orderModel.dart';
import 'package:food_delivery_app/View/SharedThemes/iconsManager.dart';
import 'package:food_delivery_app/View/SharedThemes/colorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/TicketCubit/ticketController.dart';
import '../SharedThemes/valuesManager.dart';
import '../sharedCombonent/component.dart';

class TicketWidget extends StatefulWidget {
  TicketWidget({Key? key, required this.orderModel}) : super(key: key);
  OrderModel orderModel;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children:[

        Container(
          margin: const EdgeInsetsDirectional.all(AppSize.size10),
          decoration: BoxDecoration(
            color: ColorsManager.greyLightColor,
            borderRadius: BorderRadiusDirectional.circular(AppSize.size10),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                listTilePrice(
                    title:widget.orderModel.userName,
                    subTitle:widget.orderModel.userPhone ,
                    trailing:"${widget.orderModel.orderPrice.toString()} EGP" ),
                listTilePrice(
                    title:widget.orderModel.userAddress ,
                    subTitle:widget.orderModel.appAddress ,
                    trailing:"${widget.orderModel.orderTime.toString()} min" ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("        View Items "),
                    PopupMenuButton(
                        shape:const RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorsManager.darkBlueColor,
                                width: AppSize.sizeD1,
                                style: BorderStyle.solid
                            )
                        ),
                      icon:const Icon( IconsManager.downIcon),
                        itemBuilder:(context)=><PopupMenuEntry<String>>[
                          for(int i=0; i<widget.orderModel.items.length; i++)
                           PopupMenuItem(
                              value:widget.orderModel.items[i].id,
                              child:Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  circleAvatar(radius: 20, img:widget.orderModel.items[i].img ),
                                  Expanded(child: Text("  ${widget.orderModel.items[i].name}  =>  ")),
                                  Text("${widget.orderModel.items[i].price} EGP ")
                                ],
                              ),
                          )
                        ])
                  ],
                )


              ]),
        ),   InkWell(onTap:  () async{
          BlocProvider.of<TicketController>(context).deleteOneTicket(widget.orderModel);
        },child: const Icon( IconsManager.deleteIcon , color:ColorsManager.blackColor,)),
      ],
    );

  }
}

/*
*  ListTile(
                  leading: CircleAvatar(
                    radius: AppSize.size40,
                    backgroundImage: AssetImage(ImagesManager.account),
                  ),
                  title: Text(widget.orderModel.userName),
                  subtitle: Text(widget.orderModel.userPhone),
                  trailing: Text("${widget.orderModel.orderPrice.toString()} EGP"),
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: AppSize.size40,
                    backgroundColor: ColorsManager.backGroundColor,
                    child: Text(
                      widget.orderModel.companyName,
                      style: FontsManager.getTextStyleBold(
                          color: ColorsManager.greenColor),
                    ),
                  ),
                  title: Text(widget.orderModel.companyLocationFrom),
                  subtitle: Text(widget.orderModel.companyLocationTo),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          "\n${widget.orderModel.companyStartTimeTrip.hour}: ${widget.orderModel.companyStartTimeTrip.minute}"),
                      Text(
                          "${widget.orderModel.companyEndTimeTrip.hour} :${widget.orderModel.companyEndTimeTrip.minute}"),
                    ],
                  ),
                ),*/