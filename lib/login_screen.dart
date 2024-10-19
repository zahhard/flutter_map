import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'main.dart';

void login(String userName, password) async {
  try {
    Response response = await post(
        Uri.parse('http://192.168.159.1:8000/account/login/'),
        body: {
          'username': userName,
          'password': password,
        });
    if (response.statusCode == 200) {
      print("loged in");
    } else {
      print("failed");
    }
  } catch (e) {
    print(e.toString());
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('اپلیکیشن من'),
          backgroundColor: Colors.white,
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage('images/logo.png')),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                'ورود به حساب کاربری',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'user name',
                  hintStyle: const TextStyle( color: Colors.grey),
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),),
                  hintText: 'password',
                  hintStyle: const TextStyle( color: Colors.grey),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),


            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: ElevatedButton(onPressed: (){
                print("ffff");
                login(userNameController.text.toString(),
                    passwordController.text.toString());
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),

                child: const Text(
                  'ورود',
                  style: TextStyle(fontSize: 20, ),
                ),
              ),
            ),


            const Row(
              children: <Widget>[
                Text(
                  'Forget Password? / ',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                Text(
                  'Reset',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(Colors.orangeAccent),
              ),
              onPressed: () {
                print("ffff");
                login(userNameController.text.toString(),
                    passwordController.text.toString());
              },
              child: Text('Login'),
            ),
            const Row(
              children: <Widget>[
                Text(
                  'ورود /',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                Text(
                  ' ساخت حساب جدید',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ],
        ));
  }
}
