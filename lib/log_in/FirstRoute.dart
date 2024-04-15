// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:final_whs/admin/admin.dart';
import 'package:final_whs/warehouse/warehouse.dart';

var url = 'http://127.0.0.1:8000/api/login';


Future<void> messageShowAlertDialog(BuildContext dialogContext, String message) async {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('Operation Status:',
        style: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        )),

    content: Text(message),

    actions: <Widget>[
      ElevatedButton(
        onPressed: () async {
          Navigator.of(dialogContext).pop();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.amber[800], // Background color
        ),
        child: const Text(
          'Ok',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ],
    backgroundColor: Colors.purple[100],
  );

  return showDialog(
    context: dialogContext,
    builder: (BuildContext dialogContext) {
      return alert;
    },
  );
}

Future<Map<String, dynamic>> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/login'),
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String token = data['token'];
    final String type = data['type'];
    
    return {
      'token': token,
      'type': type,
    };
  }

  else {
    throw Exception('Failed to login');
  }
}


Future<Map<String, dynamic>> getNumberOfProuduct(String token) async {
  const url = 'http://127.0.0.1:8000/api/count';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final int numProduct = data['num_products'];

    return {
      'num_products': numProduct,
    };
  }

  else {
    throw Exception('Failed to get number of products');
  }
}

Future<Map<String, List<String>>> nameProducts(String token) async {
  const url = 'http://127.0.0.1:8000/api/name';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<String> nameProducts = data['name_products'].cast<String>();

    return {
      'name_products': nameProducts,
    };
  }
  else{
    throw Exception('Failed to get name of products');
  }
}


Future<List<dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/login'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}


String token = '';
int num_product = 0;
late List<String> listNameProducts;

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);
  static const String _title = 'Log in';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Stack(
        children: <Widget>[
          Image.asset(
            "assets/login.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.amber[800],
                centerTitle: true,
                title: const Text(_title,
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                        fontFamily: 'Lucida Calligraphy Font',
                        fontStyle: FontStyle.italic
                    )
                )),
            body: MyStatefulWidget(),
          ),
        ],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  bool _isvisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child:  Text(
                      'Welcome To Our WMS ..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.purple[900],
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          fontFamily: 'Jokerman'
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child:  Text(
                      'Enter Username and Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.purple[800],
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          fontFamily: 'Lucida Calligraphy Font',
                        fontStyle: FontStyle.italic
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController1,
                    cursorColor: Colors.purple,
                    decoration:  InputDecoration(
                        focusedBorder:const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple, width: 2.0),
                        ),
                      enabledBorder:  const OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.purple),
                      ),
                      filled: true,
                      fillColor: Colors.amber[100],
                      labelStyle:  const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple)),
                      labelText: 'User name',

                      icon: Icon(Icons.person, color: Colors.purple),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: !_isvisible,
                    controller: passwordController1,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        focusedBorder:const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.amber[100],
                        enabledBorder:  const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Password',
                        labelStyle:  TextStyle(color: Colors.purple),
                        icon: const Icon(Icons.lock, color: Colors.purple),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.purple[300],
                          ),
                          onPressed: () {
                            setState(() {
                              _isvisible = !_isvisible;
                            });
                          },
                        )),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.purple,
                          Colors.red,
                          Colors.amber,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: FlatButton(
                      //color: Colors.purple,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (nameController1.text == '' ||
                            passwordController1.text == '') {
                          const snackBar = SnackBar(
                            content: Text(
                                textAlign: TextAlign.center,
                                'You need to fill in all fields before we can proceed'),
                            backgroundColor: Colors.purpleAccent,
                            behavior: SnackBarBehavior.floating,
                            width: 350,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (nameController1.text != '' &&
                            passwordController1.text != '') {


                          var response = await http.post(Uri.parse(url), body: {
                            "email": nameController1.text,
                            "password": passwordController1.text
                          });

                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          if (response.statusCode == 200) {

                            Map<String, dynamic> Mymap = await login(nameController1.text, passwordController1.text) ;
                            token = Mymap['token'].toString();
                            String type = Mymap['type'].toString();

                            if (type == "Admin") {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyAdmin()),
                              );
                            }

                            else if (type == "Warehouse"){
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Warehouse()),
                              );

                              Map<String, dynamic> myMap2 = await getNumberOfProuduct(token);
                              num_product = myMap2['num_products'];
                              print(num_product);

                              Map<String, dynamic> myMap = await nameProducts(token);
                              listNameProducts = myMap['name_products'].cast<String>();
                              print(listNameProducts);
                            }

                            else {
                              const snackBar = SnackBar(
                                content: Text(textAlign: TextAlign.center, 'There is authorization error'),
                                backgroundColor: Colors.purpleAccent,
                                behavior: SnackBarBehavior.floating,
                                width: 350,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else if (response.statusCode == 403) {
                            const snackBar = SnackBar(
                              content: Text(
                                  textAlign: TextAlign.center,
                                  'Check your email or password and try again'),
                              backgroundColor: Colors.purpleAccent,
                              behavior: SnackBarBehavior.floating,
                              width: 350,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (response.statusCode == 400) {
                            const snackBar = SnackBar(
                              content: Text(
                                  textAlign: TextAlign.center,
                                  'Check your email or password and try again'),
                              backgroundColor: Colors.purpleAccent,
                              behavior: SnackBarBehavior.floating,
                              width: 350,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        };
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ));
  }
}


/*



*/