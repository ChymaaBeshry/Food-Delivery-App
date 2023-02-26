import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/Controller/productCubit/productStates.dart';
import 'package:food_delivery_app/Model/productModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String domain="https://foodapp-425cb-default-rtdb.firebaseio.com";
class ProductController extends Cubit<ProductStates>{
  ProductController():super(InitialProductState()){
    getCategories();
  }
  final List<CategoryModel> _categories=[];
  List<ProductModel> productsSearchList=[];
  List<ProductModel> cartProducts=[];
  List<ProductModel> products=[];
  List<List<ProductModel>> allData=[];
  List<ProductModel> selectProductOfCategory=[];
  num cartTotalPrice=0;
  int totalTimeForPreparation=0;
 List<CategoryModel> get categories=>_categories;
  Future<void> getCategories()async{
    emit(LoadingProductState());
try{
  http.Response res=await http.get(Uri.parse("$domain/categories.json"));
  Map data=json.decode(res.body);
  print(res.statusCode);
  if(res.statusCode == 200){
    data.forEach((key, value) {
      CategoryModel model=CategoryModel(
          categoryName:value["categoryName"] ,
          categoryId: key,
          productOfCategory: value["categoryProducts"],
          categorySizes: value["categorySizes"],
          preparationTime: value["preparationTime"]
      );
      selectProductOfCategory=model.categoryProducts;
      allData.add(selectProductOfCategory);
      _categories.add(model);
      print(_categories);
    });
    print("${allData.length} selllllllllllllllllllllllllllllllllllllllllllllllllllller");
    _getBestSeller();
    emit(SuccessProductState());
  }else{
    emit(ErrorProductState());
  }
}catch(error){
  print(error);
  emit(ErrorProductState());
}
}
  void _getBestSeller(){
    for (var element in allData) {
      element.sort((a, b) =>int.parse(a.orders.toString()).compareTo(int.parse(b.orders.toString())),);
      products.add(element[element.length-1]);
        print(products.length);
    }
    print(products.length);



  }
  void removeCartProduct(ProductModel productModel){
    for(int i=0; i<cartProducts.length; i++){
      if(cartProducts[i].productId == productModel.productId){
        cartProducts.removeAt(i);
        emit(DeleteCartProductState());
        break;
      }
    }
}
  void selectCategoryListOfProducts({required List<ProductModel> productOfCategory }){
   selectProductOfCategory=productOfCategory;
   emit(ChangeProductOfCategoryState());
}
  void getProductOfSearch(String productName){
  productsSearchList.clear();
    print(productName);
    for (var element in allData) {
      for (var element in element) {
        if(
        element.productName.contains(productName)||
            element.productName.startsWith(productName)||
            element.productName.endsWith(productName)
        ){
          productsSearchList.add(element);
          print(element.productName);
          print(productsSearchList);

        }
      }

    }
    print(productsSearchList.length);
    emit(SuccessSearchProductState());
  }
  void calcPriceSize({required num sizeValue,required ProductModel productModel}){
    productModel.totalPrice=productModel.productPrice+sizeValue;
    emit(ChangeProductPriceState());
}
  void  incQtyProduct({required ProductModel productModel}){
    print(productModel.qty);

    if(productModel.qty<20){
      productModel.qty++;
      productModel.totalPrice=productModel.productPrice*productModel.qty;
      //productModel.qty = productModel.qty+1;
      //=productModel.productPrice*productModel.qty;
      print(productModel.qty);
      emit(ChangeProductPriceState());
    }
  }
  void  decQtyProduct({required ProductModel productModel}){
     print(productModel.qty);
     if(productModel.qty>1 && productModel.qty<=20){
       productModel.qty--;
       productModel.totalPrice=productModel.productPrice*productModel.qty;

       //productModel.qty = productModel.qty-1;
       //productModel.productPrice=productModel.productPrice*productModel.qty;
    print(productModel.qty);

    emit(ChangeProductPriceState());
  }
  }
  void getPopTitle(ProductModel productModel){

      if(productModel.categoryId == "-NOY6n2lMNwJmJb3JJEH" ){
        productModel.categoryNameSizes=[
          "single","double","treble"
        ];
      }else{
        productModel.categoryNameSizes=[
          "small","medium","large"
        ];
      }
    }
  void getCartTotalPrice(){
    cartTotalPrice=0;
    totalTimeForPreparation=0;
    for (ProductModel element in cartProducts) {

      cartTotalPrice=(cartTotalPrice+element.totalPrice).toInt();
      totalTimeForPreparation=totalTimeForPreparation+element.preparationTime;
    }}


}


