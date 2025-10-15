import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayzorpay_api_data/custmer_data/customer_api_data_screen.dart';
import 'package:rayzorpay_api_data/custmer_data/provider_helper.dart';

void main(){
  runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProviderHelper(),),
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomerApiDataScreen(),
    );
  }
}
