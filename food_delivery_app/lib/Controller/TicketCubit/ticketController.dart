import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/TicketCubit/ticketStates.dart';
import '../../Model/orderModel.dart';
import '../../Model/productModel.dart';
import '../../Model/userModel.dart';
import '../ProductCubit/ProductController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TicketController extends Cubit<TicketsStates>{
  TicketController() :super(InitialTicketState()){
    getUserTicket();
  }

  List<OrderModel> orders=[];

  Future<void>getUserTicket()async{
    orders.clear();
    emit(GetLoadingTicketState());
    try{
      http.Response res=await http.get(Uri.parse("$domain/ticket.json"));
      print(res.body);
      if(res.statusCode==200){
        Map data=json.decode(res.body);
        data.forEach((key, value) {
          orders.add(OrderModel.fromJson(key, value));
          print(orders);
          print(orders.length);
        });
        emit(GetSuccessTicketState());
      }else {
        emit(GetErrorTicketState());
      }
    }catch(error){
      print(error);
      emit(GetErrorTicketState());

    }

  }
  Future<void>addUserTicket({
    required UserModel user,
    required num price,
    required num time,
    required String appAddress,
    required List<ProductModel> cartList})async {
    emit(AddLoadingTicketState());
    try{
      List cartData =[];
       for (var element in cartList) {
         cartData.add({
          "productId": element.productId ,
          "productImg":element.productImg ,
          "productName":element.productName ,
          "totalPrice":element.totalPrice ,
        });
      }
      Map data= {
        "uid": user.uid,
        "userName": user.userName,
        "userPhone": user.userPhone,
        "orderTime":time,
        "orderPrice": price,
        "userAddress": user.userAddress,
        "appAddress": appAddress,
        "items":cartData
      };
      http.Response res = await http.post(Uri.parse("$domain/ticket.json"),
          body: json.encode(data));
      if (res.statusCode == 200) {
        emit(AddSuccessTicketState());
      }else{
        emit(AddErrorTicketState());
      }
    }catch(error){
      print(error);
      emit(AddErrorTicketState());

    }
  }
  Future<void>deleteOneTicket(OrderModel ticket )async{
    emit(DeleteLoadingTicketState());
    try{
      http.Response res=await http.delete(Uri.parse("$domain/ticket/${ticket.orderId}.json"));
      print(res.statusCode);
      if(res.statusCode==200){
        for(int i=0; i<orders.length; i++){
          if(orders[i].orderId== ticket.orderId){
            orders.removeAt(i);
            break;
          }
        }
        emit(DeleteSuccessTicketState());
      }else{
        emit(DeleteErrorTicketState());
      }
    }catch(error){
      print(error);
      emit(DeleteErrorTicketState());
    }
  }
  Future<void>deleteAllTickets()async{
    emit(DeleteLoadingTicketState());
    try{
      http.Response res=await http.delete(Uri.parse("$domain/ticket.json"));
      if(res.statusCode==200){
        orders.clear();
        emit(DeleteSuccessTicketState());
      }else{
        emit(DeleteErrorTicketState());
      }
    }catch(error){
      print(error);
      emit(DeleteErrorTicketState());
    }
  }
}