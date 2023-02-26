class CategoryModel{
  String  categoryId;
  String  categoryName;
  int preparationTime;
  List<dynamic>  categorySizes;
  List<ProductModel> categoryProducts=[];
/* CategoryModel({
   required this.categoryId,
   required this.categoryName,
   required this.categoryProducts,
 });*/
  CategoryModel({
    required this.categoryId,
    required  this.categoryName,
    required  List productOfCategory,
    required this.categorySizes,
    required this.preparationTime}){
    for (var element in productOfCategory) {
      ProductModel productModel=ProductModel.fromJson(categoryId:categoryId ,data: element,preparationTime:preparationTime );
      if(productModel.categoryId==categoryId){
        productModel.categoryValueSizes=categorySizes;
        productModel.preparationTime=preparationTime;
      }
      categoryProducts.add(productModel);
    }
  }
 @override
  String toString() {
    return "$categoryName,[$categoryProducts] ";
  }
}

class ProductModel{
  String productId;
  String categoryId;
  String productDescription;
  List<dynamic> productDetailsValue;
  List<dynamic> productDetailsName;
  List<dynamic> categoryValueSizes;
  List<dynamic> categoryNameSizes;
  String productImg;
  String productName;
  int preparationTime;
  num productPrice;
  num numOfOrderThisProduct;
  num qty;
  num orders;
  num totalPrice;
  String selectedSize;



  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.productDescription,
    required this.productDetailsValue,
    required this.productDetailsName,
    required this.productImg,
    required this.productName,
    required this.productPrice,
    required this.numOfOrderThisProduct,
    required this.qty,
    required this.categoryValueSizes,
    required this.categoryNameSizes,
    required this.preparationTime,
    required this.orders,
    required this.totalPrice,
    required this.selectedSize
});
  factory ProductModel.fromJson({required String categoryId ,required Map data,required int preparationTime}){
    return ProductModel(
        productId:data["productId"]  ,
        productDescription:data["productDescription"] ,
        productDetailsValue:data["productDetails"],
        productImg:data["productImg"],
        productName:data["productName"],
        productPrice:data["productPrice"],
        numOfOrderThisProduct: 0,
        qty: 1,
        categoryId: categoryId,
        categoryValueSizes:[],
        categoryNameSizes:[],
        productDetailsName:[
          "Kcal","Grams","Fat","Carp","Protein"
        ],
        preparationTime: preparationTime,
        orders: data["orders"],
        totalPrice:data["productPrice"] ,
        selectedSize:"",
    );
  }
@override
  String toString() {
    return "($productPrice,$productName,$productImg,$productDetailsValue,$productDescription)";
  }
}