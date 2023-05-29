

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payloan/utils/styles.dart' as styles;
import 'package:payloan/utils/styles.dart';
import 'package:payloan/adapters/user_model.dart';

import 'loan_details_screen.dart';

class HistoryScreen extends StatefulWidget {
  final UserModel userModel;
  const HistoryScreen({Key? key, required this.userModel}) : super(key: key);



  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: styles.secondaryColor,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title:  Text('Your Loan History', style: styles.blueBigText,),
          ),
          body: ListView.builder(
            itemCount: 1, // Placeholder for number of loans
            itemBuilder: (context, index) {
              return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(widget.userModel.balance.toString(), style: styles.blueSmallText,), // Placeholder for loan
                    subtitle: Text(widget.userModel.outstandingLoan? ['due_on'], style: styles. blueSmallText,), // Placeholder
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Active', style: styles.redText,), // Placeholder for loan status
                        Icon(Icons.arrow_forward_ios, color: styles.secondaryColor,),
                      ],
                    ),
                    onTap: () {
                      // Navigate to loan details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoanDetailsScreen()),);
                    },
                  ));

            },
          ),
        ));
  }
}