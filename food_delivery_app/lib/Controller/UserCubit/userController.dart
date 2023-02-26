import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/Controller/UserCubit/userStates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/userModel.dart';
import '../../View/sharedCombonent/component.dart';
FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore store=FirebaseFirestore.instance;
String error="";
class UserController extends Cubit<UserStates> {
  UserController() : super(InitialUserState()){
    getUSer();
  }
List<UserModel> user1=[];
UserModel user=UserModel(
  userPhone: "01100380106",
  userPassword: "shymaa123456",
  userName: "shymaa bushra",
  userEmail: "shymaa@gmail.com",
  userAddress: "العاشر من رمضان و الشرقية",
  uid: "1",
  isEmailVerification: false,
);
  String? userUid;
  Future<void>  signUp({
    required String email,
    required String password,
    required String name,
    required String address,
    required String phone,
  }) async {
    emit(LoadingUserState());

    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );
      Map<String,dynamic> user= UserModel.toJson(
          uid: credential.user!.uid,
          userEmail: email,
          userPhone: phone,
          userAddress: address,
          userName: name,
          isEmailVerification:credential.user!.emailVerified
      );
      await _createUser(user);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error='The password provided is too weak.';
        print('The password provided is too weak.');
        snack(error);

        emit(ErrorUserState());

      } else if (e.code == 'email-already-in-use') {
        error='The account already exists for that email.';
        snack(error);

        print('The account already exists for that email.');
        emit(ErrorUserState());

      }
    } catch (e) {
      error=e.toString();

      emit(ErrorUserState());

      print(e);
    }
  }
updateUser(UserModel data ){
    user =data;
    emit(ChangeTitleState());
}
  Future<void> signIn({
    required String email,
    required String password,

  })async{
    emit(LoadingUserState());
    try {

      UserCredential userFire= await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
       userUid= userFire.user!.uid;
      print("sgin in methoooood");
      print("$userUid userUid sgin in methoooood");

      //await getUSer(user!.uid);
      print("_get USer methoooood");

      SharedPreferences saveUser= await SharedPreferences.getInstance();
      saveUser.setInt("uid",1);
      print("Shared Preferences seeeeeeeeeeeeeeeeet");

      await getUSer();
      emit(SuccessUserState());

    /*} on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error='No user found for that email.';
        print('No user found for that email.');
        emit(ErrorUserState());

      } else if (e.code == 'wrong-password') {
        error='Wrong password provided for that user.';
        print('Wrong password provided for that user.');
        emit(ErrorUserState());

      }*/
    }catch (e) {
      error=e.toString();
      print(e);
      emit(ErrorUserState());


    }
  }

  Future<void> _createUser( Map<String,dynamic>  data )async{
 // emit(LoadingUserState());
    try{
      await store.collection("users").doc(data["uid"]).set(data);
      getUSer();
      //user=UserModel.fromJson(data);
      emit(SuccessUserState());
    }catch(error){
      print(error);
      snack(error.toString());

      emit(ErrorUserState());
    }
  }
//  multiDexEnabled true

  Future<void> getUSer()async {
    emit(LoadingUserState());
    try{
      print("getUSer  methoooood");

      DocumentSnapshot<Map<String,dynamic>> userFire= await store.collection("users").doc(userUid).get();
    // Map data=jsonDecode( user.data().toString());
      print("${userFire.data()!.length} dataaaaaaaaaaa");

      print("${userFire.data()!} dataaaaaaaaaaa");
      user=UserModel.fromJson(userFire.data()!);
    // await check();
      print(user.uid);
     print(user.isEmailVerification);
     print(user.userAddress);
     print(user.userPhone);
     print(user.userEmail);
     print(user.userName);

     emit(SuccessUserState());
   }catch(error){
     print(error);
     emit(ErrorUserState());

   }

  }


  void changeTitle(String value, String change){
    value=change;
    emit(ChangeTitleState());

  }
}
