
import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/Controller/MapCubit/mapStates.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends Cubit<MapStates>{
  MapController():super(InitialMapState()){
    getCurrentLocation();
    _getPlaceMarkToApp();
  }
  List<LatLng> appLatlng=const[
    LatLng(30.033333,31.233334),//cairo
    LatLng(30.0084868,31.4284756),//tgmo3
    LatLng(30.2283408,31.4798948),//العبور
    LatLng(30.0511,31.3656),//madient nasr
    LatLng(30.1123,31.3439),//masr elgededa
    LatLng(29.9602,31.2569)//maadi
  ];
 // num timeH=0;
 // num timeM=0;

  LatLng _latLng=LatLng(26.55889,31.69556);
  String address= "";
  String placeApp= "Cairo";

  num shipping=0;
  num time=0;
  bool totalDistance=true;
  //num totalTime=0;
  Future<void> getCurrentLocation()async{
   emit(LoadingMapState());
    try{
     bool service= await _checkPermission();
     if(service){
       Position position=await  Geolocator.getCurrentPosition();
       _latLng=LatLng(position.latitude,position.longitude);
       List<Placemark> placeMark= await placemarkFromCoordinates(_latLng.latitude,_latLng.longitude);
       address= "${placeMark[0].street} , ${placeMark[0].subAdministrativeArea}";
        await _getPlaceMarkToApp();
     emit(SuccessMapState());
     }else{
       emit(ErrorPermissionMapState());
     }
   }catch(error){
     print(error);
     emit(ErrorMapState());
   }

  }

  Future<void> getSearchLocation(String address )async{
   emit(LoadingMapState());
    try{
     bool service=await _checkPermission();
     if(service){
       List<Location> location= await locationFromAddress(address);
       _latLng= LatLng(location[0].latitude,location[0].longitude);
       List<Placemark> placeMark= await placemarkFromCoordinates(_latLng.latitude,_latLng.longitude);
       address= "${placeMark[0].street} , ${placeMark[0].subAdministrativeArea}";
       await _getPlaceMarkToApp();
     emit(SuccessMapState());
     }else{
       emit(ErrorPermissionMapState());
     }
   }catch(error){
     print(error);
      emit(ErrorMapState());
   }

  }

   Future<bool> _checkPermission()async{
    LocationPermission permission= await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      LocationPermission permission= await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return false;
      }else{
        return true;
      }
    }
    bool service=await Geolocator.isLocationServiceEnabled();
    if(service == false){
      return false;
    }else{
      return true;
    }

  }

Future<void> _getPlaceMarkToApp()async{
    List<Map<String ,dynamic>> disList=[];
    for(LatLng latlng in appLatlng){
        double dis= Geolocator.distanceBetween(_latLng.latitude, _latLng.longitude, latlng.latitude, latlng.longitude);
       print("$dis 000000000000000000000000000000000000000000000000");
        List<Placemark> placeMark= await placemarkFromCoordinates(latlng.latitude,latlng.longitude);
        print("${placeMark[0].subAdministrativeArea} 000000000000000000000000000000000000000000000000");
        disList.add({
          "dis":dis,
          "place":placeMark[0].subAdministrativeArea
        });
    }
    disList.sort((a, b)=> double.parse(a["dis"].toString()).compareTo(double.parse(b["dis"].toString())));
    print(disList);
    placeApp=disList[0]["place"];
    print("$placeApp 000000000000000000000000000000000000000000000000");
    double dis=disList[0]["dis"]/1000;
    print("$dis 000000000000000000000000000000000000000000000000");
    if(dis <= 100){
      shipping=(dis*5).toInt();
      print("$shipping shipping");
      time =(dis.toInt()*3);
      totalDistance=true;
    }else{
      totalDistance=false;

    }

     //totalTime=shipping+time;
   /* if(timeT > 60 ){
      timeH=timeT.toInt()+1;
      timeM=timeT.remainder(timeT)-60;
    // time="${timeH} : ${timeM}";
    }else{
      timeH=timeT.toInt();
      timeM=timeT.remainder(timeT);
    }*/

   // print("$timeH : $timeM time");


}

}