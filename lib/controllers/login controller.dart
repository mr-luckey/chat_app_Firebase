// import 'package:get/get.dart';
// // import '../models/user.dart';

// class LoginViewModel extends GetxController {
//   String _username = '';
//   String _password = '';
//   bool _obscureText = true; // Track password field visibility

//   void setUsername(String value) {
//     _username = value;
//   }

//   void setPassword(String value) {
//     _password = value;
//   }

//   void togglePasswordVisibility() {
//     _obscureText = !_obscureText;
//     update(); // Update the UI to reflect the changed visibility
//   }

//   void login() {
//     if (_username == 'admin' && _password == 'password') {
//       Get.snackbar('Success', 'Logged in successfully');
//     } else {
//       Get.snackbar('Error', 'Invalid username or password');
//     }
//   }

//   // Getter for password field visibility
//   bool get obscureText => _obscureText;
// }
