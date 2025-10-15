import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rayzorpay_api_data/custmer_data/customer_api_model.dart';

class CustomerApiHelper {
  static const String _keyId = 'rzp_test_R7xQYpa54gC33c';
  static const String _keySecret = 'eylAZfD3TFA7wwoHYWYw7nQg';

  static String get _basicAuth =>
      'Basic ${base64Encode(utf8.encode('$_keyId:$_keySecret'))}';

  static Future<CustomerApiModel?> getApiData() async {
    var response = await http.get(
      Uri.parse('https://api.razorpay.com/v1/customers'),
      headers: {'Authorization': _basicAuth},
    );

    debugPrint('GET customer: Code ${response.statusCode}');
    debugPrint('GET customer: Body ${response.body}');

    if (response.statusCode == 200) {
      dynamic jsonBody = jsonDecode(response.body);
      return CustomerApiModel.fromJson(jsonBody);
    } else {
      debugPrint('Error ${response.statusCode} ${response.body}');
    }
    return null;
  }

  static Future<ItemsData?> postApiData(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse('https://api.razorpay.com/v1/customers'),
      headers: {'Authorization': _basicAuth},
      body: jsonEncode(data),
    );
    debugPrint('GET customer: Code ${response.statusCode}');
    debugPrint('GET customer: Body ${response.body}');

    if(response.statusCode==200 || response.statusCode==201){
      dynamic jsonBody=jsonDecode(response.body);
      return ItemsData.fromJson(jsonBody);
    }else{
      debugPrint('Error :- ${response.body} ${response.statusCode}');
    }
    return null;
  }

  static Future<ItemsData?> putApiData(Map<String,dynamic> data) async{
    var response = await http.put(
      Uri.parse('https://api.razorpay.com/v1/customers/${data['id']}'),
      headers: {'Authorization': _basicAuth},
      body: jsonEncode(data),
    );
    debugPrint('GET customer: Code ${response.statusCode}');
    debugPrint('GET customer: Body ${response.body}');

    if(response.statusCode==200 ||response.statusCode==201){
      dynamic jsonBody=jsonDecode(response.body);
      return ItemsData.fromJson(jsonBody);
    }else{
      debugPrint('Error :- ${response.body} ${response.statusCode}');
    }
    return null;
  }
}
