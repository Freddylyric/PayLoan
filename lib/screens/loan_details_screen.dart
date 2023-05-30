import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payloan/utils/styles.dart' as styles;
import 'package:payloan/utils/styles.dart';

import 'home_screen.dart';

class LoanDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? loan;


  final int loanNumber = 1;
  // final double loanAmount = 5000;

  const LoanDetailsScreen( {Key? key, required this.loan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Loan Details', style: styles.blueBigText,),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'LOAN NO.${loanNumber.toString()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'KES ${loan? ['principal'] ?? ''} ',
            style: styles.blueBigText,
          ),
          Divider(height: 32),
          Text(
            'Amount',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: styles.primaryColor),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Principal:'),
                  Text('KES ${loan? ['principal'] ?? ''}'), // Placeholder for amount
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Interest:'),
                  Text('${loan? ['interest'] ?? ''} % '), // Placeholder for percentage and amount
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:'),
                  Text('KES ${loan? ['total_amount'] ?? ''}'), // Placeholder for amount
                ],
              ),
            ],
          ),
          Divider(height: 32),
          Text(
            'Repayment Plan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: styles.primaryColor),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Period:'),
                  Text('${loan? ['duration'] ?? '0'} days'), // Placeholder for amount of days
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Repayment date:'),
                  Text('${loan? ['due_on'] ?? ''}'), // Placeholder for amount of days
                ],
              ),
            ],
          ),
          Divider(height: 32),
          Text(
            'Amount',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: styles.primaryColor),
          ),
          SizedBox(height: 20),
          Text('Overdue repayment'), // Placeholder for overdue repayment
          Divider(height: 32),
          ExpansionTile(
            title: Text(
              'Transaction History',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: styles.primaryColor),
              textAlign: TextAlign.start,
            ),
            trailing: Icon(Icons.expand_more, color: styles.primaryColor,),
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: loan?['paid_amount'] > 0
                      ? Text(
                    'Paid amount: ${loan?['paid_amount']}',
                    style: styles.blueSmallText,
                  )
                      : const Text(
                    'Seems like there is no history available for this loan at the moment',
                    style: styles.blueSmallText,
                  ),
                ),
              ),
            ],
          ),

          // SizedBox(height: 32,),
          //
          //
          // ElevatedButton(onPressed: (){
          //   //TODO: handle repay
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          //
          //
          // },
          //   style: ButtonStyleConstants.secondaryButtonStyle,
          //   child: const Text("Repay loan", style: styles.purpleText,),),
          // SizedBox(height: 20,),

          ElevatedButton(onPressed: (){
            //TODO: handle close
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
            style: ButtonStyleConstants.secondaryButtonStyle,
            child: const Text("Close", style: styles.redText,),)
        ],
      ),
    );
  }
}
