import 'package:food_delivery_app/Model/productModel.dart';

class CartDataForTicket{
String name;
String id;
num price;
String img;

CartDataForTicket({
  required this.name,
  required this.id,
  required this.img,
  required this.price,
});
@override
  String toString() {
    // TODO: implement toString
    return "$name, $id, $img , $price";
  }
}


class OrderModel{
  String orderId;
  String uid;
  String userName;
  String userPhone;
  num    orderPrice;
  num    orderTime;
  String userAddress;
  String appAddress;
  List<CartDataForTicket> items;
  OrderModel({
    required this.orderId,
    required this.uid,
    required this.userName,
    required this.userPhone,
    required this.orderPrice,
    required this.orderTime,
    required this.userAddress,
    required this.appAddress,
    required this.items,

  });
  factory OrderModel.fromJson(key,Map<String ,dynamic> data){
    List<CartDataForTicket> items = [];
    print(data["items"]);
    data["items"].forEach((element) {
      items.add(CartDataForTicket(
          name: element["productName"],
          id: element["productId"],
          img: element["productImg"],
          price: element["totalPrice"]));
      print(items);
    }
    );
    return OrderModel(
      orderId:key,
      uid:data["uid"],
      userName:data["userName"],
      userPhone:data["userPhone"] ,
      orderPrice:data["orderPrice"],
      orderTime:data["orderTime"],
      userAddress:data["userAddress"],
      appAddress:data["appAddress"],
      items:items
    );
  }
  @override
  String toString() {
    return"$orderId,$userName,$uid,$userPhone,$orderTime,$userAddress,$appAddress,$items,$orderPrice";
  }


}