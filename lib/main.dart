import 'package:flutter/material.dart';
import 'package:s_pay/current_user.dart';
import 'package:s_pay/firebase_options.dart';
import 'package:s_pay/main.dart';
import 'package:s_pay/send.dart';
import 'package:s_pay/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:s_pay/Authentication.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
final navigatorKey = GlobalKey<NavigatorState>();
// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print(ScreenUtil().screenWidth);
    // print(ScreenUtil().screenHeight);
    return MultiProvider(providers: [
      Provider<Authentication>(
        create: (_) =>Authentication(FirebaseAuth.instance),
      ),

      StreamProvider(create: (context) =>context.read<Authentication>().authStateChanges, initialData: null,
      )
    ],
       child:ScreenUtilInit(
        designSize: const Size(360, 800),
    // designSize: Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight),
    builder: (context, child) {

    return MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,

    ),
        initialRoute: '/login',
        routes: <String, WidgetBuilder>{
          '/login': (_) => const LoginPage(),
        }
    );

    },
    )
    // ),


    );


    }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  //const LoginPage({Key? key}) : super(key: key);
  TextEditingController? userid = TextEditingController();

  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? pass = TextEditingController();
  bool secureText = true;






  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();
    if (firebaseuser == null) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    Card(
                      color: Colors.white,
                      // margin: const EdgeInsets.all(15),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(157.0)),
                      ),
                      elevation: 5,
                      shadowColor: Colors.black,
                      // child: SizedBox(
                      //   width: 157,
                      //   height: 157,
                      // ),

                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(5.r),
                      margin: EdgeInsets.all(5.r),
                      child: const FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("Log in to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF003261),
                                fontFamily: 'NovaSquare')),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.all(20.r),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Email id',
                            labelText: 'Email id',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding:
                            EdgeInsets.fromLTRB(30, 20.h, 20, 20.h),
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: const Icon(
                              Icons.person_outline,
                              size: 24,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color(0xFF003261),
                                width: 4.0,
                              ),
                            ),
                          ),
                          controller: userid,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.all(20.r),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding:
                            EdgeInsets.fromLTRB(30, 20.h, 20, 20.h),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color(0xFF003261),
                                width: 2.0,
                              ),
                            ),
                            // suffixIcon: const Icon(Ionicons.key_outline),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.remove_red_eye_rounded,
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  secureText = !secureText;
                                });
                              },
                            ),
                          ),
                          controller: pass,
                          //key:_formKey,
                          obscureText: secureText,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(80.w, 0, 40, 40.h),
                        child: const FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            if (userid!.text != null && pass!.text != null) {
                              context.read<Authentication>().signIn(
                                  email: userid!.text.trim(),
                                  pass: pass!.text.trim(),
                                  context: context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(30, 10.h, 30, 20.h),
                              backgroundColor: const Color(0xFF003261),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  fontFamily: 'NovaSquare', fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.w, 0, 40.w, 0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Don\'t have account?',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF003261),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/register');
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ));
    } else {
      return MyHomePage();
    }
  }
}



class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController bal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spay"),
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child:Column(
              children: [
                Text("Available Balance :",style:
                  TextStyle(
                    fontSize: 25
                  ),
                ),
                FutureBuilder(
                  future: getdata(),
                  builder: (context,snapshot){
                    if(snapshot.hasData) {
                      Object data = snapshot.data!;
                      return Text('$data',style:
                          TextStyle(
                          fontSize: 25
                      ),);
                    }
                    else{
                      return Text('waiting');
                    }
                  },
                ),

              ],
            ),
            padding: EdgeInsets.all(50.0),
            color: Colors.blue,
          ),
          //SizedBox(height: 50,),


          Row(
          children:[
            SizedBox(width:50),

          TextButton(onPressed: (

    ){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  SendMoney()));
          }, child:
          Text("Send money",style:TextStyle(
              fontSize: 20
          )),
          style: TextButton.styleFrom(
            backgroundColor: Colors.amber
          ),
          ),
          SizedBox(width:50),
          TextButton(onPressed: (){Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  AddMoney()));}, child:
          Text("Add money",style:TextStyle(
    fontSize: 20
    )),style: TextButton.styleFrom(
    backgroundColor: Colors.amber
    )),],),
          SizedBox(height: 50,),
          TextButton(onPressed: (){}, child:
          Text("Past Transactions",style:TextStyle(
              fontSize: 20
          ))
          ,),
          TextButton(onPressed: (){
            setState(() {
              getdata();
            });
          }, child:
          Text("Refresh",style:TextStyle(
              fontSize: 20
          ))
            ,),
          TextButton(onPressed: (){
            context.read<Authentication>().SignOut(context: context);
          }, child:
          Text("Log out",style:TextStyle(
              fontSize: 20
          ))
            ,)
        ],
    ),
    );
  }
}

Future<dynamic> getdata() async {
  //await Future.delayed(Duration(seconds: 4));
  Users u= Users();
  final name = u.getUserData('bal');

  return name;
}
