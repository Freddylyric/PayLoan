import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:payloan/screens/login_screen.dart';
import 'package:payloan/utils/styles.dart';
import 'package:payloan/utils/styles.dart' as styles;

import 'adapters/user_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

          child: Column(

            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 50,),
              Divider(
                thickness: 2.0,
                color: Colors.blue[300],
              ),

              Container(

                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/payloan_logo.jpeg"),
                    fit: BoxFit.fitWidth,
                  ),
                  // color: Color(0xff0B615E),
                ),
                height: MediaQuery.of(context).size.height * 0.4,

              ),
              const SizedBox(height: 10,),
              Divider(
                thickness: 2.0,
                color: Colors.blue[300],
              ),
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(

                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
                      },
                      style: ButtonStyleConstants.secondaryButtonStyle,
                      child: Row(
                        children:  [
                          Icon(Icons.login, color: styles.secondaryColor), // add an Icon as the first child of the Row
                          const SizedBox(width: 20), // add some spacing between the icon and the text
                          const Text("Login to PayLoan", style: styles.redText, textAlign: TextAlign.center,),
                        ],
                      ),
                    ),const SizedBox(height: 30,),
                    Divider(
                      thickness: 2.0,
                      color: Colors.blue[300],
                    ),
                    const SizedBox(height: 20,),
                    // ElevatedButton(onPressed:(){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                    // },
                    //     style: ButtonStyleConstants.primaryButtonStyle,
                    //     child: Row(
                    //
                    //       children: const [
                    //         Icon(Icons.person_2_outlined, color: Colors.white),
                    //         SizedBox(width: 20,),
                    //         Text("Sign up for an account", style: styles.whiteText, textAlign: TextAlign.center,),
                    //       ],
                    //     )),
                  ],
                ),
              ),




            ],

          )
      ),
    );
  }
}
