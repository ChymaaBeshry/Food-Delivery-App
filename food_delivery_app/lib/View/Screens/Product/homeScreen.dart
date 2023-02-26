import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/productCubit/productController.dart';
import 'package:food_delivery_app/Controller/productCubit/productStates.dart';
import 'package:food_delivery_app/View/SharedThemes/colorsManager.dart';
import 'package:food_delivery_app/View/SharedThemes/fontsManager.dart';
import 'package:food_delivery_app/View/SharedThemes/valuesManager.dart';
import 'package:food_delivery_app/View/sharedCombonent/component.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedWidgets/HomeProductWidget.dart';
import '../../SharedWidgets/TextFormFieldWidget.dart';
import '../../SharedWidgets/drawerWidget.dart';
import '../../SharedWidgets/safeAreaAndFlexibleWidget.dart';
import '../../SharedWidgets/selectProductWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final boardController = PageController(viewportFraction: 0.8, keepPage: true);
  TextEditingController productSearchController = TextEditingController();
  GlobalKey productKey = GlobalKey<ScaffoldState>();
  bool isSearch=false;
  String titleSearchField="Search product";
  @override
  Widget build(BuildContext context) {
    ProductController productController= BlocProvider.of<ProductController>(context);

    //productController.selectProductOfCategory= productController.categories[0].categoryProducts;
          return Scaffold(
              drawer: const DrawerWidget(),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ColorsManager.transparentColor,
                title:isSearch==true? InputField(
                  model: InputModel(
                    validator: (productSearchController) {},
                    controller: productSearchController,
                    key: productKey,
                    width: AppSize.size250,
                    title:titleSearchField ,
                    onSubmitted: (){
                        productController.getProductOfSearch(productSearchController.text);
                        titleSearchField=productSearchController.text;
                        print(productController.productsSearchList.length);
                        print(productController.productsSearchList);


                    }
                  ),
                ):Text("Food Delivery App",style: FontsManager.getTextStyleBold(size: AppSize.size25),),
                leading: Builder(
                  builder: (BuildContext context) {
                    return sharedIcon(
                      color: ColorsManager.blackColor,
                      icon: IconsManager.menuIcon,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      }, //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    );
                  },
                ),
                actions: [
                  sharedIcon(
                      icon: IconsManager.searchIcon,
                      onPressed: () {
                       setState(() {
                         isSearch=true;
                       });
                      },
                      color: ColorsManager.blackColor)
                ],
              ),

              body:BlocBuilder<ProductController,ProductStates>(
    builder:(context,state){
    if(state is LoadingProductState){
    return centerLoading();
    }else if(state is ErrorProductState){
    return centerErrorText();
    }else{
         return     isSearch==true?  SafeAreaAndFlexibleWidget(itemBuilder: productController.productsSearchList,onPressed: (){
                setState(() {
                  isSearch=false;
                });
              },)
                  : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppSize.size20,
                      top:AppSize.size30 ,
                    ),
                    child: Text(" best seller item in each category ",style: FontsManager.getTextStyleBold(
                        size: AppSize.size20,
                      color: ColorsManager.greyLightColor
                    ),textAlign: TextAlign.center,),
                  ),
                  SizedBox(
                    height: AppSize.size250,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: boardController,
                      itemBuilder: (context, index) => HomeProductWidget(productModel:productController.products[index] ),
                      itemCount: productController.products.length,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                        //start: AppSize.size15,
                        //end: AppSize.size15,
                        top: AppSize.size25,
                        bottom: AppSize.size15
                    ),
                    height: AppSize.size25,
                    //width: AppSize.size250,
                    child: ListView(
                      children: [
                        SmoothPageIndicator(
                          controller: boardController,
                          count:  productController.products.length,
                          effect: const SlideEffect(
                              spacing: 10.0,
                              radius: 5.0,
                              dotWidth: 50.0,
                              dotHeight: 5.0,
                              paintStyle: PaintingStyle.stroke,
                              strokeWidth: 1,
                              dotColor: ColorsManager.greyLightColor,
                              activeDotColor: ColorsManager.greyLightColor),

                      )],
                    ),
                  ),
                  Row(
                     children: [
                      const SafeArea(
                        minimum: EdgeInsets.all(AppSize.size10),
                          child:Icon(IconsManager.filterIcon,color: ColorsManager.blackColor,) ),
                          Flexible(child:  SizedBox(
                            height: AppSize.size40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:productController.categories.length,
                              itemBuilder:(context,index)=>InkWell(
                                onTap: (){
                                     productController.selectCategoryListOfProducts(
                                        productOfCategory: productController.categories[index].categoryProducts);
                                },
                                child: textBackground(
                                    title: productController.categories[index].categoryName,
                                    color: ColorsManager.greyLightColor
                                ),
                              ),),
                          ),)
                    ],
                    
                  ),

                  for(int i=0; i<productController.selectProductOfCategory.length; i++)
                    SelectProductWidget(cart: false,productModel:productController.selectProductOfCategory[i]),

                ],
              );
        }
    })
    );


      }

  }

