import 'package:flutter/material.dart';

class RazorpayFeaturesScreen extends StatelessWidget {
  const RazorpayFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        "title": "Subscriptions 🔁",
        "subtitle": "Setup recurring monthly/yearly payments"
      },
      {
        "title": "Payment Links 🔗",
        "subtitle": "Generate links that users can pay with"
      },
      {
        "title": "Invoices 📑",
        "subtitle": "Send invoices and get paid online"
      },
      {
        "title": "Offers & Discounts 🎁",
        "subtitle": "Apply coupon codes and cashback offers"
      },
      {
        "title": "Wallets 💳",
        "subtitle": "Support Paytm, Mobikwik, Freecharge etc."
      },
      {
        "title": "Netbanking 🏦",
        "subtitle": "Accept payments from major Indian banks"
      },
      {
        "title": "UPI (Google Pay, PhonePe) 📱",
        "subtitle": "Instant UPI payments via Razorpay"
      },
      {
        "title": "International Payments 🌍",
        "subtitle": "Accept USD, EUR, GBP and more (live mode only)"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay Features"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: features.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final feature = features[index];
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: Colors.deepPurple.shade50,
            leading: const Icon(Icons.payment, color: Colors.deepPurple),
            title: Text(
              feature["title"]!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(feature["subtitle"]!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Later: Navigate to detailed implementation screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${feature["title"]} coming soon...")),
              );
            },
          );
        },
      ),
    );
  }
}
