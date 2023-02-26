
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Controller/UserCubit/userController.dart';
import '../../../Controller/UserCubit/userStates.dart';
import '../../../Model/userModel.dart';
import '../../SharedThemes/StringManager.dart';
import '../../SharedThemes/colorsManager.dart';
import '../../SharedThemes/fontsManager.dart';
import '../../SharedThemes/iconsManager.dart';
import '../../SharedThemes/imagesManager.dart';
import '../../SharedThemes/valuesManager.dart';
import '../../SharedWidgets/TextFormFieldWidget.dart';
import '../../sharedCombonent/component.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  GlobalKey emailKey = GlobalKey<ScaffoldState>();
  GlobalKey phoneKey = GlobalKey<ScaffoldState>();
  GlobalKey addressKey = GlobalKey<ScaffoldState>();
  GlobalKey nameKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserController, UserStates>(builder: (context, state) {
      UserController userController = BlocProvider.of<UserController>(context);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: AppSize.size0,
          backgroundColor: ColorsManager.blackColor,
          title: Text(
            StringsManager.myAccount,
            style: FontsManager.getTextStyleSemiBold(
                color: ColorsManager.whiteColor),
          ),
          leading: sharedIcon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconsManager.leftIcon,
            color: ColorsManager.whiteColor,
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.size20),
              child: ListTile(
                leading:CircleAvatar(
                    radius: AppSize.size30,
                    backgroundImage: AssetImage(ImagesManager.logo)),
                trailing:  CircleAvatar(
                  backgroundColor: ColorsManager.transparentColor,
                  radius: AppSize.size20,
                  child: sharedIcon(
                    color: ColorsManager.darkBlueColor,
                    icon: IconsManager.cameraIcon,
                    onPressed: () {
                    },
                  ),
                ),
                title: Text(userController.user.userName),
                subtitle: Text(userController.user.userEmail),
              ),
            ),
            Column(
              children: [
                InputField(
                  model: InputModel(
                      controller: fullNameController,
                      key: nameKey,
                      prefix: IconsManager.personIcon,
                      keyboardType: TextInputType.text,
                      title:userController.user.userName,
                      //hint:userController.user.userName ,
                      onSubmitted: () {
                        userController.changeTitle(userController.user.userName, fullNameController.text);
                        userController.user.userName = fullNameController.text;
                      },
                      validator: (fullNameController) {}),
                ),
                InputField(
                  model: InputModel(
                      controller: emailController,
                      key: emailKey,
                      prefix: IconsManager.emailIcon,
                      keyboardType: TextInputType.emailAddress,
                      title:userController.user.userEmail,
                      //hint:userController.user.userEmail ,
                      onSubmitted: () {
                        userController.changeTitle(userController.user.userEmail, emailController.text);
                        userController.user.userEmail = emailController.text;
                      },
                      validator: (emailController) {}),
                ),
                InputField(
                  model: InputModel(
                      isSecure: true,
                      controller: addressController,
                      key: addressKey,
                      prefix: IconsManager.locationIcon,
                      keyboardType: TextInputType.text,
                      title:userController.user.userAddress,
                      //hint:userController.user.userAddress ,
                      onSubmitted: () {
                        userController.changeTitle(userController.user.userAddress ,
                            addressController.text);
                        userController.user.userAddress =
                            addressController.text;
                      },
                      validator: (phoneController) {}),
                ),
                InputField(
                  model: InputModel(
                      controller: phoneController,
                      key: phoneKey,
                      prefix: IconsManager.phoneIcon,
                      keyboardType: TextInputType.phone,
                      title:userController.user.userPhone,
                      //hint:userController.user.userPhone ,
                      onSubmitted: () {
                        userController.changeTitle(userController.user.userPhone , phoneController.text);
                        userController.user.userPhone = phoneController.text;
                      },
                      // validateTitle: "enter Your Phone Number",
                      validator: (phoneController) {}),
                ),
                sharedButton(title: StringsManager.update, onPressed: () {
                  UserModel user=UserModel(
                    isEmailVerification: true,
                    userPassword:userController.user.userPassword ,
                    userEmail:userController.user.userEmail,
                    uid: '1',
                    userName:userController.user.userName,
                    userAddress:userController.user.userAddress,
                    userPhone:userController.user.userPhone,
                  );
                  userController.updateUser(user);
                }, width: AppSize.size250)
              ],
            )
          ],
        ),
      );
    });
  }

  /*
  Future pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }*/
}
