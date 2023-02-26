import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../SharedThemes/StringManager.dart';
import '../SharedThemes/colorsManager.dart';
import '../SharedThemes/fontsManager.dart';
import '../SharedThemes/valuesManager.dart';
Container sharedButton({
  required Function onPressed,
  required String title,
  required double width
}) =>
    Container(
        margin: const EdgeInsets.symmetric(vertical: AppSize.size20,horizontal: AppSize.size10),
        height: AppSize.size55,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.size20),
          color: ColorsManager.blackColor,
        ),
        child: TextButton(
            onPressed: () {
              onPressed();
            },
            child: Text(
              title,
              style: FontsManager.getTextStyleRegular(
                  color: ColorsManager.whiteColor),
            )));

Container textBackground( {required String title,required Color color } )=> Container(
  margin: const EdgeInsetsDirectional.all(AppSize.size5),
padding:const EdgeInsetsDirectional.all(AppSize.size5),
decoration: BoxDecoration(
color: color,
borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
),
child: Text("  $title  ",style: FontsManager.getTextStyleLight(
color: ColorsManager.whiteColor
),),
);

Container widgetBackground( {required Widget widget,required Color color } )=> Container(
  margin: const EdgeInsetsDirectional.all(AppSize.size5),
  padding:const EdgeInsetsDirectional.all(AppSize.size5),
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadiusDirectional.circular(AppSize.size20),
  ),
  child: widget,
);


Padding divider(Color color) => Padding(
  padding: const EdgeInsets.only(bottom: AppSize.size15),
  child: Divider(
    height: AppSize.sizeD1,
    color: color,
    thickness: AppSize.sizeD1,
    endIndent: AppSize.size25,
    indent: AppSize.size25,
  ),
);
IconButton sharedIcon(
    {required IconData icon,
      required Function onPressed,
      required Color color}) {
  return IconButton(
      padding: const EdgeInsetsDirectional.all(AppSize.size5),
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        icon,
        color: color,
      ));
}

TextButton sharedTextButton(
    {required String title,
      required Function onPressed,
      required Color color,

    }) {
  return TextButton(
    child: Text(
      title,
      style: FontsManager.getTextStyleMedium(color: color),
    ),
    onPressed: () {
      onPressed();
    },
  );
}

Container decoration(
    {required Widget widget,
      required double marginBottom,
      required double smallHeight,
      required double width}) =>
    Container(
      margin: EdgeInsets.only(
        bottom: marginBottom ,
        top:AppSize.size15 ,
        left:AppSize.size5 ,
        right:AppSize.size5
      ),
      padding: const EdgeInsets.all(AppSize.sizeD1),
      height: smallHeight+AppSize.size20,
      width: width,
      decoration: BoxDecoration(
          color: ColorsManager.blackColor,
          borderRadius: BorderRadius.circular(AppSize.size20)),
      child: Container(
        padding:const EdgeInsets.all(AppSize.size5) ,
        height: smallHeight,
        width: AppSize.size250,
        decoration: BoxDecoration(
            color: ColorsManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.size20)),
        child: widget,
      ),
    );
Center centerLoading()=>const Center(
  child: CircularProgressIndicator(
    color: ColorsManager.blackColor,
  ),
);

Center centerErrorText()=>const Center(
  child: Text(StringsManager.somethingWentWrong),
);

CircleAvatar circleAvatar({required double radius,required String img})=> CircleAvatar(
backgroundColor: ColorsManager.redColor,
radius:radius,
//child: Image(image:  NetworkImage(img),fit: BoxFit.fill,),
foregroundColor: ColorsManager.whiteColor,
backgroundImage:  NetworkImage(img),
);
CircleAvatar circleAvatar2({required double radius,required String img})=> CircleAvatar(
  backgroundColor: ColorsManager.redColor,
  radius:radius,
//child: Image(image:  NetworkImage(img),fit: BoxFit.fill,),
  foregroundColor: ColorsManager.whiteColor,
  backgroundImage:  AssetImage(img),
);
/*Container circleContainer({required String img}){
  return Container(
    height: AppSize.size150,
    width: AppSize.size150 ,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(AppSize.size200),
      image: DecorationImage(
        image: NetworkImage(img),fit: BoxFit.fill,),
      )


  );
}*/
ListTile listTilePrice({
  required String title,
  required  String subTitle,
  required String trailing
})=>  ListTile(
  //leading:circleAvatar(radius: AppSize.size40),
  title:Text("  $title",style: FontsManager.getTextStyleBold(),),
  subtitle:Text( "  $subTitle",style: FontsManager.getTextStyleLight(),maxLines: 3,overflow: TextOverflow.ellipsis) ,
  trailing: Text(trailing ,style: FontsManager.getTextStyleLight(
      color: ColorsManager.blackColor
  ),),
);
Row priceSection({
  required String title,required String price
} )=> Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("\n      $title",style: FontsManager.getTextStyleBold(),),
    Text("\n $price     ",style: FontsManager.getTextStyleLight(
        color: ColorsManager.greyLightColor
    ),),
  ],
);

Builder snack(String title) => Builder(
  builder: (context) {
    return     SnackBar(

      content: Text(title,),

      backgroundColor: ColorsManager.blackColor,

      width: double.infinity,

      shape: const StadiumBorder(

        side: BorderSide(

          color: ColorsManager.lightBlueColor,

          style: BorderStyle.solid,

          width: AppSize.sizeD1,

        ),

      ),

      duration: const Duration(milliseconds: 300),

    );
  }
);
