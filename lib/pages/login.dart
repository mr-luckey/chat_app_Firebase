import 'package:chat_app/Wiget/custom_text_field.dart';
import 'package:chat_app/Wiget/rounded_btn.dart';
import 'package:chat_app/models/routes.dart';
// import 'package:chat_app/constants/parameters.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
// import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/Auth_provider.dart';
// import '../controllers/login controller.dart';
// import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late double myheight;
  late double mywidth;
  final _loginFormKey = GlobalKey<FormState>();
  late Authprovider _auth;
  late NavigationService _navigation;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    myheight = MediaQuery.of(context).size.height;
    mywidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<Authprovider>(context);
    _navigation = GetIt.instance.get<NavigationService>();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        height: myheight * .98,
        width: mywidth * .97,
        decoration: const BoxDecoration(
          color:
              Color.fromRGBO(36, 35, 49, 1.0), // Set scaffold background color
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mywidth * 0.03, vertical: mywidth * 0.02),
          // Use mywidth here
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pagetitle(),
              SizedBox(
                height: myheight * 0.04,
              ),
              _loginform(),
              SizedBox(
                height: myheight * 0.01,
              ),
              _loginbtn(),
              SizedBox(
                height: myheight * 0.02,
              ),
              _registerAccountLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pagetitle() {
    return Container(
      height: myheight * 0.10,
      child: Text(
        'chatify',
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _loginform() {
    return Container(
      height: myheight * .20,
      child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              CustomTextField(
                  hintText: 'Email',
                  onSaved: (_value) {
                    setState(() {
                      email = _value;
                    });
                    // viewModel.username = value;
                  },
                  regEx: "",
                  obscureText: false),
              CustomTextField(
                  hintText: 'Password',
                  onSaved: (_value) {
                    setState(() {
                      password = _value;
                    });
                    // viewModel.username = value;
                  },
                  regEx: r".{8,}",
                  obscureText: true),
            ],
          )),
    );
  }

  Widget _loginbtn() {
    return Roundedbtn(
        name: 'login',
        height: myheight * 0.065,
        width: mywidth * 0.65,
        onPressed: () {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            print("Email: $email, Password: $password");
            _auth.login(email!, password!);
          }
        });
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () {
        print('clicked');
      },
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.register);
        },
        child: Container(
          child: Text(
            'Don\'t have an account?',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}
