import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rayzorpay_api_data/rayzorpay_payment_screen/razorpar_feature_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay razorpay;
  TextEditingController payController = TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse value) {
      Fluttertoast.showToast(msg: 'Error ${value.error} ${value.message}');
    });

    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
      PaymentSuccessResponse value,
    ) {
      Fluttertoast.showToast(msg: 'Payment Success ${value.paymentId}');
    });

    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, (
      ExternalWalletResponse value,
    ) {
      Fluttertoast.showToast(msg: 'External Wallet ${value.walletName}');
    });
  }

  openPayment() {
    if (payController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter amount");
      return;
    }

    var amount = int.parse(payController.text.trim()) * 100;
    var options = {
      'key': 'rzp_test_R7xQYpa54gC33c',
      'amount': amount,
      'currency': 'INR',
      'name': 'Acme Corp.',
      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60,
      'prefill': {'contact': '8507536900', 'email': 'purushottam2fx@gmail.com'},
    };

    try {
      razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Payment 💵',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 80,
                  width: 120,
                  child: TextField(
                    controller: payController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.currency_rupee),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    openPayment();
                  },
                  label: Text('Pay'),
                  icon: Icon(Icons.currency_rupee),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RazorpayFeaturesScreen()),
          );
        },
        child: Icon(Icons.paypal_outlined, color: Colors.blue),
      ),
    );
  }
}
