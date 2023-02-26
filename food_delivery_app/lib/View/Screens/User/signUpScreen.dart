import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Controller/MapCubit/mapController.dart';
import 'package:food_delivery_app/Controller/MapCubit/mapStates.dart';
import 'package:food_delivery_app/Controller/UserCubit/userController.dart';
import 'package:food_delivery_app/Model/userModel.dart';
import 'package:food_delivery_app/View/SharedThemes/valuesManager.dart';
import '../../SharedThemes/StringManager.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedWidgets/TextFormFieldWidget.dart';
import '../../sharedCombonent/component.dart';
List<UserModel> user=[];
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmCPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  GlobalKey emailKey = GlobalKey<ScaffoldState>();
  GlobalKey addressKey = GlobalKey<ScaffoldState>();
  GlobalKey phoneKey = GlobalKey<ScaffoldState>();
  GlobalKey passwordKey = GlobalKey<ScaffoldState>();
  GlobalKey confirmPasswordKey = GlobalKey<ScaffoldState>();
  GlobalKey nameKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool check = false;
  bool isDone=false;
  @override
  Widget build(BuildContext context) {
    MapController mapController=BlocProvider.of<MapController>(context);

    return BlocBuilder<MapController,MapStates>(
        builder: (context,state) {
          // mapController.getPlaceMarktoApp();
          addressController.text = mapController.address;
          if (!mapController.totalDistance) {
            return AlertDialog(
              title: const Text("Currently unavailable in your area"),
              elevation: AppSize.size15,
              shape: const StadiumBorder(
                side: BorderSide(
                    width: AppSize.sizeD1,
                    color: ColorsManager.blackColor
                ),
              ),
              content: Column(
                children: [
                  InputField(
                    model: InputModel(
                        controller: addressController,
                        key: addressKey,
                        prefix: IconsManager.locationIcon,
                        keyboardType: TextInputType.text,
                        title: mapController.address,
                        onSubmitted: () {
                          mapController.getSearchLocation(addressController
                              .text);
                          mapController.address = addressController.text;
                        },
                        // validateTitle: "enter Your Phone Number",
                        validator: (phoneController) {
                          if (addressController.text.isEmpty) {
                            return "enter your  phone number";
                          }
                        }
                    ),
                  ),
                  sharedButton(
                    title: "Enter Address",

                    onPressed: () {
                      isDone = true;
                    },
                    width: AppSize.size250,
                  ),
                ],
              ),

            );
          } else {
            return Scaffold(
              body: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text("\n${StringsManager.welcome}",
                      style: FontsManager.getTextStyleBold(
                        size: AppSize.size25,
                        color: ColorsManager.darkBlueColor,
                      ), textAlign: TextAlign.center,
                    ),
                    Text(StringsManager.createYourAccount,
                      style: FontsManager.getTextStyleRegular(
                        color: ColorsManager.lightBlueColor,
                      ), textAlign: TextAlign.center,),
                    //text(StringsManager.name),
//
                    InputField(
                      model: InputModel(
                          controller: fullNameController,
                          key: nameKey,
                          prefix: IconsManager.personIcon,
                          keyboardType: TextInputType.text,
                          title: StringsManager.name,
                          validator: (fullNameController) {
                            if (fullNameController.isEmpty) {
                              return "enter Your Full Name";
                            }
                          }
                      ),
                    ),
                    // text(StringsManager.email),

                    InputField(
                      model: InputModel(
                          controller: emailController,
                          key: emailKey,
                          prefix: IconsManager.emailIcon,
                          keyboardType: TextInputType.emailAddress,
                          title: StringsManager.email,
                          validateTitle: "enter Your Email",
                          onSubmitted: () {},
                          validator: (emailController) {
                            if (emailController.isEmpty) {
                              return "enter your email";
                            } else if (!emailController.contains(
                                "@gmail.com")) {
                              return "please enter @gmail.com";
                            }
                          }

                      ),
                    ),

                    // text(StringsManager.password),

                    InputField(
                      model: InputModel(
                          controller: passwordController,
                          key: passwordKey,
                          isSecure: true,
                          prefix: IconsManager.passwordIcon,
                          keyboardType: TextInputType.visiblePassword,
                          title: StringsManager.password,
                          validator: (phoneController) {
                             if (passwordController.text.isEmpty) {
                            return "enter your Password";
                            }else if (passwordController.text.length < 12) {
                              return "please enter password 12 numbers and contain on characters ";
                            }
                          }
                      ),
                    ),
                    //  text(StringsManager.confirm),
                    InputField(
                      model: InputModel(
                          controller: confirmCPasswordController,
                          key: confirmPasswordKey,
                          isSecure: true,
                          prefix: IconsManager.passwordIcon,
                          keyboardType: TextInputType.visiblePassword,
                          title: StringsManager.confirmPassword,
                          validator: (phoneController) {
                            if (passwordController.text != confirmCPasswordController.text) {
                              return "password doesn't match";
                            } else if (confirmCPasswordController.text.isEmpty) {
                              return "enter your  confirm Password";
                            }
                          }
                      ),
                    ),
                    //   text(StringsManager.phone),
                    InputField(
                      model: InputModel(
                          controller: addressController,
                          key: addressKey,
                          prefix: IconsManager.locationIcon,
                          keyboardType: TextInputType.text,
                          title: StringsManager.address,
                          onSubmitted: () {
                            mapController.getSearchLocation(addressController.text);
                            mapController.address = addressController.text;
                          },
                          // validateTitle: "enter Your Phone Number",
                          validator: (phoneController) {
                            if (addressController.text.isEmpty) {
                              return "enter your  phone number";
                            }
                          }
                      ),
                    ),
                    InputField(
                      model: InputModel(
                          controller: phoneController,
                          key: phoneKey,
                          prefix: IconsManager.phoneIcon,
                          keyboardType: TextInputType.phone,
                          title: StringsManager.phone,
                          // validateTitle: "enter Your Phone Number",
                          validator: (phoneController) {
                            if (phoneController.length > 11 || phoneController.length < 11) {
                              return "pleas enter 11 numbers";
                            } else if (phoneController.isEmpty) {
                              return "enter your  phone number";
                            }
                          }
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              onChanged: (value) {
                                setState(() {
                                  check = value!;
                                });
                              },
                              value: check,
                              activeColor: ColorsManager.lightBlueColor,
                              hoverColor: ColorsManager.darkBlueColor,
                              focusColor: ColorsManager.lightBlueColor,
                              checkColor: ColorsManager.darkBlueColor,
                            ),
                            const Text(StringsManager.acceptTermsConditions),
                          ],
                        ),
                        Row(
                          children: [
                            sharedTextButton(title: StringsManager.login,
                                color: ColorsManager.lightBlueColor
                                , onPressed: () {
                                  Navigator.pushNamed(
                                      context, "login");
                                }),
                          ],
                        )
                      ],
                    ),
                    sharedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            UserModel user=UserModel(
                                isEmailVerification:true,
                                 uid: "1",
                                userAddress:addressController.text ,
                                userEmail:emailController.text ,
                                userName:fullNameController.text ,
                                userPassword:passwordController.text ,
                                userPhone:phoneController.text ,
                            );
                            await BlocProvider.of<UserController>(context)
                                .signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                address: addressController.text,
                                name: fullNameController.text,
                                phone: phoneController.text);
                            BlocProvider.of<UserController>(context).user1.add(user);
                            Navigator.pushNamed(context, "home");
                          }

                          /* if(_formKey.currentState!.validate()){
                    UserController userController=BlocProvider.of<UserController>(context);
                    BlocProvider.of<UserController>(context).signup(
                        emailController.text,passwordController.text);
                    SharedPreferences saveUser= await SharedPreferences.getInstance();
                    saveUser.setInt("userId",1);
                    UserModel user= UserModel(
                      userName: fullNameController.text,
                      userEmail: emailController.text,
                      userPassword: passwordController.text,
                      userPhone:phoneController.text,);
                    userController.addUser(user);
                    Navigator.pushNamed(context, "bottomNavBar");
                  }*/
                        },
                        width: AppSize.size150,
                        title: StringsManager.sign)

                  ],
                ),
              ),
            );
          }
        }
    );
  }
}
