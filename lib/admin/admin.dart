// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:final_whs/log_in/FirstRoute.dart';
import 'package:http/http.dart' as http;

Future<bool> logout(String token) async {
  const url = 'http://127.0.0.1:8000/api/logout';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> changePassword(
    String token, String Password, String PasswordConfig) async {
  const url = 'http://127.0.0.1:8000/api/change';
  final response = await http.post(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "password": Password,
    "password_confirmation": PasswordConfig
  });

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<String> register(String email, String password, String passwordConfig, String phone, String type, String country, String city, String district) async {
  const url = 'http://127.0.0.1:8000/api/register';
  final response = await http.post(Uri.parse(url), body: {
    "email": email,
    "password": password,
    "password_confirmation": passwordConfig,
    "phone_n": phone,
    "type": type,
    "country": country,
    "city": city,
    "district": district
  });

  print('Response status: ${response.statusCode}');

  if (response.statusCode == 200 || response.statusCode == 422) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String message = data['message'];

    return message;
  } else if (response.statusCode == 500){
    return 'User Created Successfully';
  } else {
    throw Exception('Failed to create Department ');
  }
}

class MyAdmin extends StatefulWidget {
  @override
  State<MyAdmin> createState() => _MyAdminState();
}

class _MyAdminState extends State<MyAdmin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ConfigPassController = TextEditingController();
  bool _isvisible = false;

  String dropdownvalueType = 'Warehouse';
  // List of items in our dropdown menu
  var itemsDay = [
    'Warehouse',
    'Supply',
    'HR',
    'IT',
    'Repair',
  ];

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.amber[100],
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
            padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
            child: StatefulBuilder(
              builder: (context, setInnerState) => SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      cursorColor: Colors.purple,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'User Name',
                        icon: Icon(Icons.perm_identity, color: Colors.amber),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: !_isvisible,
                      controller: passwordController,
                      cursorColor: Colors.purple,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          labelStyle: TextStyle(color: Colors.purple),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.purple)),
                          labelText: 'Password',
                          icon: const Icon(Icons.lock, color: Colors.amber),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isvisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              setInnerState(() {
                                _isvisible = !_isvisible;
                              });
                            },
                          )),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: ConfigPassController,
                      cursorColor: Colors.purple,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Configuration password',
                        icon:
                            Icon(Icons.storefront_rounded, color: Colors.amber),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          child: TextField(
                            controller: countryController,
                            cursorColor: Colors.purple,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              labelStyle: TextStyle(color: Colors.purple),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.purple)),
                              labelText: 'Country',
                              icon: Icon(Icons.map, color: Colors.amber),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          child: TextField(
                            controller: cityController,
                            cursorColor: Colors.purple,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              labelStyle: TextStyle(color: Colors.purple),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.purple)),
                              labelText: 'City',
                              icon: Icon(Icons.location_city,
                                  color: Colors.amber),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          child: TextField(
                            controller: districtController,
                            cursorColor: Colors.purple,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              labelStyle: TextStyle(color: Colors.purple),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.purple)),
                              labelText: 'District',
                              icon:
                                  Icon(Icons.location_on, color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: phoneController,
                      cursorColor: Colors.purple,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Phone Number',
                        icon: Icon(Icons.phone, color: Colors.amber),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    width: 75,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Text(
                          'Enter your account type -> ',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        DropdownButton(
                          // Initial Value
                          value: dropdownvalueType,

                          // Down Arrow Icon
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.amber,
                          ),
                          dropdownColor: Colors.purple[100],
                          // Array list of items
                          items: itemsDay.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setInnerState(() => dropdownvalueType = newValue!);
                          },
                          hint: const Text("Select user type"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              String checkCreateWH = await register(
                                  emailController.text,
                                  passwordController.text,
                                  passwordController.text,
                                  phoneController.text,
                                  dropdownvalueType,
                                  countryController.text,
                                  cityController.text,
                                  districtController.text);

                              var snackBar = SnackBar(
                                content: Text(
                                    textAlign: TextAlign.center,
                                    checkCreateWH),
                                backgroundColor: Colors.purpleAccent,
                                behavior: SnackBarBehavior.floating,
                                width: 350,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber[800], // Background color
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ]),
                  ),
                ],
              )),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/Untitled.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.amber[800],
              centerTitle: true,
              title: const Text('Admin Screen',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      fontFamily: 'Lucida Calligraphy Font',
                      fontStyle: FontStyle.italic)),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.deepPurple,
                ),
                onPressed: () async {
                  bool check_logout = await logout(token);

                  if (check_logout) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  }
                },
              ),
            ),
            body: Center(
                child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(25),
                  alignment: Alignment.center,
                  child: const Text(
                    'Admin Feature',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFFF3E5F5),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Lucida Calligraphy Font',
                        fontStyle: FontStyle.italic),
                  )),
              Container(
                margin: EdgeInsets.all(25),
                height: 40,
                width: 200,
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
                child: FlatButton(
                  //color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () {
                    _showAlertDialog();
                  },
                  child: const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                height: 40,
                width: 200,
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
                child: FlatButton(
                  //color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () => _show(context),
                  child: const Text(
                    'Create Department',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                height: 40,
                width: 200,
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
                child: FlatButton(
                  //color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () => _show(context),
                  child: const Text(
                    'Review',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ]))),
      ],
    );
  }

  TextEditingController _PasswordController = TextEditingController();
  TextEditingController _ConfigePasswordController = TextEditingController();

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          // <-- SEE HERE
          backgroundColor: Colors.purple[100],
          title: const Text('Admin Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _PasswordController,
                  decoration:
                      const InputDecoration(hintText: 'Enter new password'),
                ),
                TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _ConfigePasswordController,
                  decoration:
                      const InputDecoration(hintText: 'Enter password again'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                bool check_change_password;

                if (_PasswordController.text == '' ||
                    _ConfigePasswordController.text == '') {
                  const snackBar = SnackBar(
                    content: Text(
                        textAlign: TextAlign.center,
                        'You need to fill in all fields before we can proceed'),
                    backgroundColor: Colors.purpleAccent,
                    behavior: SnackBarBehavior.floating,
                    width: 350,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  if (_PasswordController.text ==
                      _ConfigePasswordController.text) {
                    check_change_password = await changePassword(
                        token,
                        _PasswordController.text,
                        _ConfigePasswordController.text);
                    if (check_change_password) {
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'Changing Password Done Successfully'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.of(dialogContext).pop();
                    } else {
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'there is error in back_end'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    const snackBar = SnackBar(
                      content: Text(
                          textAlign: TextAlign.center,
                          'There is no match between to passwords, please chick it again'),
                      backgroundColor: Colors.purpleAccent,
                      behavior: SnackBarBehavior.floating,
                      width: 350,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amber[800], // Background color
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
