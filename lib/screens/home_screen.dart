
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:payloan/screens/profile_screen.dart';
import 'package:payloan/screens/request_screen.dart';
import 'package:payloan/utils/styles.dart' as styles;
import 'package:payloan/utils/styles.dart';
import 'package:http/http.dart'  as http;

import '../adapters/user_model.dart';
import '../main.dart';
import 'help_screen.dart';
import 'history_screen.dart';
import 'loan_repayment_screen.dart';


class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoanInfoExpanded = true;
  late String _selectedOption;
  final _storage = const FlutterSecureStorage();
  late String storedValue;


  UserModel? _userModel;

  @override
  void initState() {
    _getUserData();
    super.initState();

  }


  // Method to fetch user data from the API using phone number
  Future<void> _fetchUserData(String phoneNumber) async {
    final url = Uri.parse('https://dev.hazini.com/ussd');
    final requestBody = json.encode({'phone_number': phoneNumber});
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Create a UserModel object with the response data
      UserModel user = UserModel(
        name: jsonResponse['name'],
        email: jsonResponse['email'],
        balance: jsonResponse['balance'].toInt(),
        salary: jsonResponse['salary'] .toInt(),
        kraPin: jsonResponse['kra_pin'],
        maxLoan: jsonResponse['max_loan'].toInt(),
        status: jsonResponse['status'],
        companyId: jsonResponse['company_id'],
        canBorrow: jsonResponse['can_borrow'],
        cannotBorrowReason: jsonResponse['cannot_borrow_reason'],
        outstandingLoan: jsonResponse['outstanding_loan'],
      );

      // Save the user model to the Hive database
      final box = Hive.box<UserModel>('userBox');
      box.add(user);

      // Update the state with the fetched user data
      setState(() {
        _userModel = user;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch user data. Please try again later.'),
            actions: [
              TextButton(
                child: Text('OK'),
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

  //methd to fetch user data from hive
  Future<void> _getUserData() async {
    final box = Hive.box<UserModel>('userBox');
    final user = box.get(0);
    if (user != null) {
      setState(() {
        _userModel = user;
      });
    } else {
      // Clear the user data from the Hive box
      box.clear();

      // Fetch the user data using the phone number from the API
      final phoneNumber = await _storage.read(key: 'phone_number');
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        await _fetchUserData(phoneNumber);
      }
    }
  }




  @override
  Widget build(BuildContext context) {

    //check if userdata is available
    if (_userModel == null){
      return const Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: styles.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: styles.backgroundColor,
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: styles.primaryColor,
              child: Text(_userModel!.name.substring(0, 2),),

            ),),
          title: Text('Hi there ${_userModel?.name},', style: styles.blueSmallText,),
          actions: [
            PopupMenuButton(
              // color: styles.backgroundColor,
              icon: Icon(Icons.menu,size: 36, color: styles.secondaryColor,),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'terms',
                  child: Row(
                    children: [
                      Icon(Icons.edit_note, color: styles.primaryColor,),
                      SizedBox(width: 10),
                      Text('Terms', style: styles.blueSmallText),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'privacy',
                  child: Row(
                    children: [
                      Icon(Icons.privacy_tip, color: styles.primaryColor,),
                      SizedBox(width: 10),
                      Text('Privacy Policy', style: styles.blueSmallText),

                    ],
                  ),

                ),

                PopupMenuItem(
                  value: 'logout',
                  child: Column(
                    children: [
                      // SizedBox(height: 10,),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ), const SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(Icons.close, color: styles.primaryColor,),
                          const SizedBox(width: 10),
                          const Text('Logout', style: styles.blueSmallText,),
                        ],
                      ),
                      const SizedBox(height: 5,),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                setState(() {
                  _selectedOption = value;
                });

                // Add menu option handling
                if (value == 'logout') {
                  // Perform logout actions here
                  _performLogout();
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your loans',
                  style: styles.blueBigText,
                ),
                SizedBox(height: 20),
                // Container for loan info
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Loan amount
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'You have a loan of:',
                                style: styles.blueSmallText,
                              ),SizedBox(height: 10),
                              Text(
                                  NumberFormat.currency(
                                    symbol: 'KES ',
                                  ).format(_userModel?.outstandingLoan? ['due_amount'] ?? 0),
                                  // Placeholder for loan amount
                                  style: styles.blueBigText
                              ),
                            ],
                          ),

                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              _isLoanInfoExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              setState(() {
                                _isLoanInfoExpanded = !_isLoanInfoExpanded;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_isLoanInfoExpanded) ...[
                        const SizedBox(height: 16),
                        // Loan info details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLoanInfoRow('Principal', 'KES ${_userModel?.outstandingLoan?['principal']?.toString() ?? ''}'),
                            _buildLoanInfoRow('Interest', '${_userModel?.outstandingLoan?['interest']?.toString() ?? ''} %'),
                            _buildLoanInfoRow('Balance', 'KES ${_userModel?.outstandingLoan?['due_amount']?.toString() ?? ''}'),
                            _buildLoanInfoRow('Period', '${_userModel?.outstandingLoan?['duration']?.toString() ?? ''} Days'),
                            _buildLoanInfoRow('Date Borrowed', _userModel?.outstandingLoan?['requested_at'] ?? ''),
                            _buildLoanInfoRow('Deadline', _userModel?.outstandingLoan?['due_on'] ?? '')
                            // Placeholder for deadline
                          ],
                        ),
                      ],
                      SizedBox(height: 10),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      SizedBox(height: 10,),
                      // Pay now button
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoanRepaymentScreen(userModel: _userModel!,)));
                              // Add "pay now" logic here
                            },
                            style: styles.ButtonStyleConstants.smallButtonStyle,
                            child: const Text('Pay now'),
                          ),
                          const Spacer(),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestScreen()));

                          },
                              style: styles.ButtonStyleConstants.smallButtonStyle,
                              child: const Text('Request a Loan')),
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Tabs for History, Profile, and Help
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTab('History', Icons.file_copy_outlined, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoryScreen(userModel: _userModel!)),
                      );
                    }),
                    _buildTab('Profile', Icons.person_2_outlined, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen(),
                        ),);
                    }),
                    _buildTab('Help', Icons.question_mark, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpScreen()),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
  Widget _buildLoanInfoRow(String label,  String value, ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
                label,
                style: styles.blackText
            ),
          ),
          Expanded(
            child: Text(
                value,
                style: styles.blueSmallText
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildTab(String title, IconData icon, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 90,
        height: 90,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.grey[700],
            ),
            SizedBox(height: 8),
            Text(
                title,
                style: styles.redText
            ),
          ],
        ),
      ),
    );
  }

  void _performLogout() async {

    // Clear the Hive database
    await Hive.box<UserModel>('userBox').clear();

    // final box = Hive.box<UserModel>('userBox');
    //   box.clear();

    // clear secure storage
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'phone_number');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }



}
