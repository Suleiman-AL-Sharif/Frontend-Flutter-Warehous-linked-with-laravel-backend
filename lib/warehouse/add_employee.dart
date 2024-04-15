// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'package:final_whs/log_in/FirstRoute.dart';



Future<bool> addEmployees(String token,String name,String email, String phone) async {
  const url = 'http://127.0.0.1:8000/api/add_employee';
  final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "name": name,
        "email":email,
        "phone_n":phone,
      }
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.amber[800], primarySwatch: Colors.amber),
      home: const Employees(),
    );
  }
}

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  EmployeesState createState() => EmployeesState();
}

class EmployeesState extends State<Employees> {
  TextEditingController nameEmployeeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jopController = TextEditingController();

  String dropdownvalueEmployee = 'Porter';
  // List of items in our dropdown menu
  var itemsEmployee = [
    'Porter',
    'Accountant',
    'Monitor quality',
    'Driver',
    'Assistant Director',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        centerTitle: true,
        title: const Text('Add Products',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 25,
                fontFamily: 'Lucida Calligraphy Font',
                fontStyle: FontStyle.italic
            )),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.deepPurple,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: StatefulBuilder(
        builder: (context, setInnerState) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Enter Employee Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameEmployeeController,
                  cursorColor: Colors.purple,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.purple)),
                    labelText: 'Employee Name',
                    icon: Icon(Icons.drive_file_rename_outline, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: phoneController,
                  cursorColor: Colors.purple,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.purple)),
                    labelText: 'Phone number',
                    icon: Icon(Icons.phone, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.purple,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.purple)),
                    labelText: 'Email',
                    icon: Icon(Icons.alternate_email, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text(
                      'The type of employee''s work -> ',
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    DropdownButton(
                      dropdownColor: Colors.purple[100],
                      // Initial Value
                      value: dropdownvalueEmployee,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.amber,
                      ),

                      // Array list of items
                      items: itemsEmployee.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setInnerState(() => dropdownvalueEmployee = newValue!);
                      },
                      hint: const Text("Select Category"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                  padding: const EdgeInsets.all(20),
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                      height: 20,
                      width: 150,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:const [
                            Icon(Icons.upload, color: Colors.purple),
                            SizedBox(width: 10),
                            Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                          ],
                        ),
                      )
                  ),

                  onPressed: () async {
                    bool check_add_employee = await addEmployees(token,nameEmployeeController.text, emailController.text, phoneController.text);

                    if(check_add_employee) {
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'Employee added successfully'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'There is error: employee''s details dose not added'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}