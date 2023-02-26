import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/TicketCubit/ticketStates.dart';
import '../../../Controller/TicketCubit/ticketController.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedThemes/valuesManager.dart';
import '../../SharedWidgets/orderWidget.dart';
import '../../sharedCombonent/component.dart';


class OrdersList extends StatefulWidget {
  const OrdersList({Key? key,}) : super(key: key);
  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  void initState() {
    BlocProvider.of<TicketController>(context).getUserTicket();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorsManager.blackColor,
                title: Text("Orders", style: FontsManager.getTextStyleBold(
                  color: ColorsManager.whiteColor,
                  size: AppSize.size30,
                ),),
                centerTitle: true,
                actions: [
                  sharedIcon(
                      icon: IconsManager.deleteIcon,
                      color: ColorsManager.whiteColor,
                      onPressed: () async {
                        BlocProvider.of<TicketController>(context)
                            .deleteAllTickets();
                      }
                  )
                ],
              ),
              body: BlocBuilder<TicketController,TicketsStates>(
    builder: (BuildContext context,state) {
    if (state is GetErrorTicketState || state is DeleteErrorTicketState) {
    return centerErrorText();
    } else if (state is GetLoadingTicketState || state is DeleteLoadingTicketState) {
    return centerLoading();
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, index) =>
            TicketWidget(orderModel: BlocProvider
                .of<TicketController>(context)
                .orders[index],),
        itemCount: BlocProvider
            .of<TicketController>(context)
            .orders
            .length,
      );

          }
        })
    );
  }
}//  TicketWidget(orderModel: productController.orders[index],),
/*          if(state is GetErrorTicketState ||state is DeleteErrorTicketState){
            return centerErrorText();
          }else if(state is LoadingProductState ||state is DeleteLoadingTicketState){
            return centerLoading();
          }else{
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorsManager.darkBlueColor,
                title: Text("Tickets", style: FontsManager.getTextStyleBold(
                  color: ColorsManager.whiteColor,
                  size: AppSize.size30,
                ),),
                centerTitle: true,
                actions: [
                  sharedIcon(
                      icon:IconsManager.deleteIcon ,
                      color: ColorsManager.whiteColor,
                      onPressed:()async{
                        productController.deleteAllTickets();
                      }
                  )
                ],
              ),
              body: ListView.builder(
                itemBuilder: (context, index) =>
                     TicketWidget(orderModel: productController.orders[index]),
                itemCount: productController.orders.length,
              ),
            );
          }
*/