import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayzorpay_api_data/custmer_data/provider_helper.dart';
import 'package:rayzorpay_api_data/rayzorpay_payment_screen/payment_screen.dart';

class CustomerApiDataScreen extends StatefulWidget {
  const CustomerApiDataScreen({super.key});

  @override
  State<CustomerApiDataScreen> createState() => _CustomerApiDataScreenState();
}

class _CustomerApiDataScreenState extends State<CustomerApiDataScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProviderHelper>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderHelper>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('RayzorPay Api Data'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if(value=='pay'){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
              }
            },
            itemBuilder: (context) {
            return [
              PopupMenuItem(value: 'pay',child: Text('Pay Amount'))
            ];
          },)
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entity:- ${provider.customerApiModel?.entity}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Count:- ${provider.customerApiModel?.count}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 210,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.customerApiModel?.items?.length,
                          itemBuilder: (context, index) {
                            var data = provider.customerApiModel?.items?[index];
                            return Card(
                              child: SizedBox(
                                width: 230,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Id :- ${data?.id}'),
                                        Text('Entity :- ${data?.entity}'),
                                        Text('Name :- ${data?.name}'),
                                        Text('email :- ${data?.email}'),
                                        Text('Contact :- ${data?.contact}'),
                                        Text('gstin :- ${data?.gstin}'),
                                        Text('CreatedAt :- ${data?.createdAt}'),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(onPressed: () {
                                              provider.initialData(index);
                                            }, icon: Icon(Icons.edit,color: Colors.blue,))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Form(
                        key: provider.formKey,
                        child: Column(
                          children: [
                            customTextField(
                              'Customer Name',
                              provider.nameController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Name';
                                }
                                return null;
                              },
                              TextInputType.name,
                            ),
                            SizedBox(height: 10,),
                            customTextField(
                              'Customer Email',
                              provider.emailController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Email';
                                }
                                if(!value.contains('@') || !value.contains('.com')){
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10,),
                            customTextField(
                              'Customer Contact',
                              provider.contactController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Contact';
                                }
                                return null;
                              },
                              TextInputType.number,
                            ),
                            SizedBox(height: 20,),
                            ElevatedButton.icon(onPressed: () {
                              provider.postAndUpdateData();
                            }, label: Text(provider.editId==null ? 'Add Data':'Update Data'),icon: Icon(provider.editId==null? Icons.add:Icons.update),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customTextField(
    String hintText,
    TextEditingController controller,
    FormFieldValidator<String?> validation,
    TextInputType keyBoardType,
  ) {
    return TextFormField(
      controller: controller,
      validator: validation,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: hintText,
        filled: true,
        fillColor: Color(0x6f0b89ce),
      ),
    );
  }
}
