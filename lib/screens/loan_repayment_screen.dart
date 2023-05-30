
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payloan/utils/styles.dart' as styles;
import 'package:payloan/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;


import '../adapters/user_model.dart';

class LoanRepaymentScreen extends StatefulWidget {
  final UserModel userModel;

  const LoanRepaymentScreen({Key? key, required this.userModel,}) : super(key: key);

  @override
  _LoanRepaymentScreenState createState() => _LoanRepaymentScreenState();
}

class _LoanRepaymentScreenState extends State<LoanRepaymentScreen> {
  double? _repayAmount;
  final _storage = const FlutterSecureStorage();

  bool _isProcessing = false;


  void _makeRepayment() async {

    setState(() {
      _isProcessing = true;
    });
    final token = await _storage.read(key: 'token');
    if (token != null && token.isNotEmpty) {
      final url = Uri.parse('https://dev.hazini.com/ussd/initiate-stk-push');
      final requestBody1 = json.encode({'amount': _repayAmount});
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: requestBody1,
      );

      if (response.statusCode == 200) {

        // TODO: Repayment request successful, handle the response accordingly
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Payment Initiated.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        print('stk sent');

      } else {
        print('Repayment request failed with status code: ${response.statusCode}');
        //ToDo: Repayment request failed, handle the error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to initiate repayment. Please try again later.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
    setState(() {
      _isProcessing = false;
    });
  }





  @override
  Widget build(BuildContext context) {
    final userModel = widget.userModel;
    return SafeArea(
        child: Scaffold(

          body: ListView(
              children:[
                Container(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      const Text('AMOUNT', style: styles.blueBigText),
                      const SizedBox(height: 20,),
                      Text('Your loan is KES ${widget.userModel.outstandingLoan? ['due_amount']}', style: styles.blueSmallText,),
                      const SizedBox(height: 20),
                      const Text('How much would you like to repay?', style: styles.blackText,),
                      const SizedBox(height: 10,),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                          ),
                          hintText: 'Enter Amount',
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onChanged: (value) {
                          setState(() {
                            _repayAmount = double.tryParse(value);
                          });
                        },
                      ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (_isProcessing) {
                            return null; // Disable the button while processing
                          } else if (_repayAmount != null && _repayAmount! > 0 && _repayAmount! <= userModel.outstandingLoan! ['due_amount']) {
                            _makeRepayment();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Please enter a valid amount."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: styles.ButtonStyleConstants.primaryButtonStyle,
                        child: _isProcessing
                            ? CircularProgressIndicator() // Show the progress indicator
                            : const Text('Repay', style: styles.whiteText),
                      ),


                    ],
                  ),
                ),
              ]),
        ));
  }
}
