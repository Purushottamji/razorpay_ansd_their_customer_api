import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayzorpay_api_data/custmer_data/customer_api_helper.dart';
import 'package:rayzorpay_api_data/custmer_data/customer_api_model.dart';

class ProviderHelper with ChangeNotifier{
  final formKey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController contactController=TextEditingController();

  CustomerApiModel? customerApiModel;
  String? editId;

  getData()async{
    var data=await CustomerApiHelper.getApiData();
    if(data!=null){
      customerApiModel=data;
      notifyListeners();
    }
  }
  initialData(int index) {
    editId=customerApiModel?.items?[index].id;
    nameController.text=customerApiModel!.items![index].name!;
    emailController.text=customerApiModel!.items![index].email!;
    contactController.text=customerApiModel!.items![index].contact!;
    notifyListeners();
  }

  clearField(){
    nameController.clear();
    emailController.clear();
    contactController.clear();
  }

  postAndUpdateData() async{
    if(formKey.currentState!.validate()){
      if(editId!=null){
        var data={
          'id':editId,
          'name':nameController.text.trim(),
          'email':emailController.text.trim(),
          'contact':contactController.text.trim()
        };
        var response=await CustomerApiHelper.putApiData(data);
        if(response!=null){
          Fluttertoast.showToast(msg: 'Data Updated Successfully',backgroundColor: Colors.blue,textColor: Colors.white);
          clearField();
          getData();
        }else{
          Fluttertoast.showToast(msg: 'Data Updated Unsuccessfully',backgroundColor: Colors.red,textColor: Colors.white);
        }
      }else{
        var data={
          'name':nameController.text.trim(),
          'email':emailController.text.trim(),
          'contact':contactController.text.trim()
        };
        var response=await CustomerApiHelper.postApiData(data);
        if(response!=null){
          Fluttertoast.showToast(msg: 'Data Added Successfully',backgroundColor: Colors.blue,textColor: Colors.white);
          clearField();
          getData();
        }else{
          Fluttertoast.showToast(msg: 'Data Added Unsuccessfully',backgroundColor: Colors.red,textColor: Colors.white);
        }
      }
    }

  }
}