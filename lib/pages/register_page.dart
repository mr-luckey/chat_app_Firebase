import 'dart:io';

import 'package:chat_app/Wiget/custom_text_field.dart';
import 'package:chat_app/Wiget/round_image.dart';
import 'package:chat_app/Wiget/rounded_btn.dart';
import 'package:chat_app/services/cloud_storage_service.dart';
import 'package:chat_app/services/mediac_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../providers/Auth_provider.dart';
import '../services/database_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _height;
  File? _profileImage;
  late double _width;
  late Authprovider _auth;
  late DatabaseService _db;
  late CloudStorageSercive _cloudStorageSercive;
  String? _email;
  String? _password;
  String? _name;
  final _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Authprovider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorageSercive = GetIt.instance.get<CloudStorageSercive>();

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: _height * .98,
        width: _width * .97,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(36, 35, 49, 1.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _width * 0.03, vertical: _width * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _profileImageField(),
              SizedBox(
                height: _height * 0.05,
              ),
              _registerFrom(),
              // _pageTitle(),
              SizedBox(
                height: _height * 0.05,
              ),

              _registerButton(),
              SizedBox(
                height: _height * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Roundedbtn(
        name: "Register",
        height: _height * 0.065,
        width: _width * 0.65,
        onPressed: () async {
          if (_registerFormKey.currentState!.validate() &&
              _profileImage != null) {
            _registerFormKey.currentState!.save();
            String? _uid = await _auth.registerUser(_email!, _password!);
            print(_uid);
            String? _imageURL =
                await _cloudStorageSercive.saveUserImage(_uid!, _profileImage!);

            await _db.createUser(_uid, _email!, _name!, _imageURL!);
          }
        });
  }

  Widget _registerFrom() {
    return Container(
      height: _height * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
                hintText: 'name',
                onSaved: (_value) {
                  setState(() {
                    _name = _value;
                  });
                },
                regEx: r'.{8,}',
                obscureText: false),
            CustomTextField(
                hintText: 'Email',
                onSaved: (_value) {
                  setState(() {
                    _email = _value;
                  });
                },
                regEx: '',
                obscureText: false),
            CustomTextField(
                hintText: 'Password',
                onSaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                regEx: r'.{8,}',
                obscureText: true),
          ],
        ),
      ),
    );
  }

  // Widget _profileImageField() {
  //   // File? _file;
  //   return GestureDetector(
  //     onTap: () async {
  //       final _files =
  //           await GetIt.instance.get<MediaService>().pickImageFromLibrary();
  //       if (_files != null) {
  //         setState(() {
  //           _profileImage = _files as PlatformFile?;
  //         });
  //       }
  //     },
  //     child: _profileImage != null
  //         ? RoundedImagefile(
  //             key: UniqueKey(),
  //             image: _profileImage!,
  //             size: _height * 0.15,
  //           )
  //         : RoundedImageNetwork(
  //             key: UniqueKey(),
  //             imagePath:
  //                 "https://www.example.com/image.jpg", // Replace with a valid image URL
  //             size: _height * 0.15,
  //           ),
  //   );
  // }
  // Widget _profileImageField() {
  //   // File? _file;
  //   return GestureDetector(
  //     onTap: () async {
  //       final _file =
  //           await GetIt.instance.get<MediaService>().pickImageFromLibrary();
  //       if (_file != null) {
  //         setState(() {
  //           _profileImage = File(_file!.path);
  //         });
  //       }
  //     },
  //     child: _profileImage != null
  //         ? RoundedImagefile(
  //             key: UniqueKey(),
  //             image: _profileImage,
  //             size: _height * 0.15,
  //           )
  //         : RoundedImageNetwork(
  //             key: UniqueKey(),
  //             imagePath:
  //                 "https://www.example.com/image.jpg", // Replace with a valid image URL
  //             size: _height * 0.15,
  //           ),
  //   );
  // }

  // Widget _profileImageField() {
  //   // File? _file;
  //   return GestureDetector(
  //     onTap: () {
  //       GetIt.instance
  //           .get<MediaService>()
  //           .pickImageFromLibrary()
  //           .then((_files) {
  //         setState(() {
  //           _profileImage = _files!.first;
  //         });
  //       });
  //     },
  //     child: _profileImage != null
  //         ? RoundedImagefile(
  //             key: UniqueKey(),
  //             image: _profileImage!,
  //             size: _height * 0.15,
  //           )
  //         : RoundedImageNetwork(
  //             key: UniqueKey(),
  //             imagePath:
  //                 "https://www.example.com/image.jpg", // Replace with a valid image URL
  //             size: _height * 0.15,
  //           ),
  //   );
  // }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then((_file) {
          setState(() {
            _profileImage = _file;
          });
        });
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImagefile(
              key: UniqueKey(), image: _profileImage, size: _height * 0.15);
        } else {
          return RoundedImageNetwork(
              key: UniqueKey(),
              imagePath:
                  "https://www.google.com/imgres?imgurl=https%3A%2F%2Fsm.ign.com%2Fign_pk%2Fcover%2Fa%2Favatar-gen%2Favatar-generations_rpge.jpg&tbnid=iK0aSJqa8CD5XM&vet=12ahUKEwiasPPM7fWEAxW8UqQEHRMWCL4QMygUegUIARCaAQ..i&imgrefurl=https%3A%2F%2Fpk.ign.com%2Favatar-generations&docid=Mx1_vtF4lKoIcM&w=1024&h=1024&q=avatar&ved=2ahUKEwiasPPM7fWEAxW8UqQEHRMWCL4QMygUegUIARCaAQ",
              size: _height * 0.15);
        }
      }(),
    );
  }
}
