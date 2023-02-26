import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Controller/UserCubit/userController.dart';
import '../../../Controller/UserCubit/userStates.dart';
import '../../SharedThemes/StringManager.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedThemes/imagesManager.dart';
import '../../SharedThemes/valuesManager.dart';
import '../../SharedWidgets/TextFormFieldWidget.dart';
import '../../sharedCombonent/component.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final TextEditingController emailController=TextEditingController();
 final TextEditingController passwordController=TextEditingController();
 GlobalKey emailKey=GlobalKey<ScaffoldState>();
 GlobalKey passwordKey=GlobalKey<ScaffoldState>();
 final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

 @override
  Widget build(BuildContext context) {
   return BlocBuilder<UserController,UserStates>(
     builder: (context,state){
       return Scaffold(
         backgroundColor: ColorsManager.appBackGroundColor,
         body: Form(
           key: _formKey,
           child: ListView(
             children: [
               Image(
                 image: AssetImage(ImagesManager.logo,),
                 height: AppSize.size200,
               ),
               Text("Food Delivery App\n",style: FontsManager.getTextStyleBold(size: AppSize.size25),textAlign: TextAlign.center),
               InputField(
                 model: InputModel(
                   validator: (emailController) {
                     if (emailController.isEmpty) {
                       return StringsManager.pleaseEnterThisField;
                     }
                   },
                   controller:emailController ,
                   key: emailKey,
                   onSubmitted:(){
                   } ,
                   title:"Email" ,
                   //  width:AppSize.size250 ,
                   prefix:IconsManager.emailIcon ,
                   keyboardType:TextInputType.text ,
                   outoCorrect:true ,
                 ),
               ),
               InputField(
                 model: InputModel(
                   validator: (passwordController) {
                     if (passwordController.isEmpty) {
                       return StringsManager.pleaseEnterThisField;
                     }
                   },
                   controller:passwordController ,
                   key: passwordKey,
                   isSecure: true,

                   onSubmitted:(){
                   } ,
                   title:"Password" ,
                   //width:AppSize.size250 ,
                   prefix:IconsManager.passwordIcon ,
                   keyboardType:TextInputType.visiblePassword ,
                   outoCorrect:true ,
                 ),
               ),
               sharedButton(
                   width: AppSize.size250 ,
                   title:"Login" ,
                   onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      await BlocProvider.of<UserController>(context).signIn(
                          email: emailController.text,
                          password: passwordController.text);
                        print("Success Loginnnnnnnnnnnnnnnnnnnnnnnnnnn");
                      Navigator.pushNamed(context, "home");

                    }else{
                      return "errorddddddddddddddddddddddddddddddddddddddddddd";
                     // snack(error);


                    }

                   }
               ),
               TextButton(
                 onPressed: ()  {
                   Navigator.pushNamed(context, "signUp");
                 },
                 child:Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(StringsManager.dontHaveAccount,style:FontsManager.getTextStyleLight(color: ColorsManager.blackColor,
                         size: AppSize.size15)),
                     Text(StringsManager.sign,
                       style:FontsManager.getTextStyleRegular(color: ColorsManager.blackColor),textAlign: TextAlign.center,),
                   ],
                 ),

               ),
             ],

           ),
         ),

       );
     },
   );
  }
}
