// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:zoom_meet/utils/utils.dart';
//
// import '../auth_screens/global_method.dart';
// import 'dart:io';
// class AuthMethods {
//   final _signUpGlobalKey = GlobalKey<FormState>();
//
//   bool res = false;
//   File? imageFile;
//   String ? url ;
//
//   bool _obscureText = true;
//
//
//   late TextEditingController _fullNameTextEditingController =
//   TextEditingController(text: '');
//   late TextEditingController _positionCPTextEditingController =
//   TextEditingController(text: '');
//   late TextEditingController _emailTextEditingController =
//   TextEditingController(text: '');
//
//   late TextEditingController _passwordTextEditingController =
//   TextEditingController(text: '');
//
//   late TextEditingController _phoneTextEditingController =
//   TextEditingController(text: '');
//
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Stream<User?> get authChanges => _auth.authStateChanges();
//   User get user => _auth.currentUser!;
//
//   Future<bool> signInWithGoogle(BuildContext context) async {
//    // bool res = false;
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       UserCredential userCredential =
//           await _auth.signInWithCredential(credential);
//
//       User? user = userCredential.user;
//
//       if (user != null) {
//         if (userCredential.additionalUserInfo!.isNewUser) {
//           await _firestore.collection('users').doc(user.uid).set({
//             'username': user.displayName,
//             'uid': user.uid,
//             'profilePhoto': user.photoURL,
//           });
//         }
//         res = true;
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//       res = false;
//     }
//     return res;
//   }
//
//
//   // Future<bool> submitFormSignUp(BuildContext context) async {
//   //   final isValid = _signUpGlobalKey.currentState!.validate();
//   //   FocusScope.of(context).unfocus();
//   //   if (isValid) {
//   //     // if (imageFile == null) {
//   //     //   GlobalMethod.showErrorDialog(
//   //     //       context: context, error: 'Please pick up a image');
//   //     //   return;
//   //     // }
//   //     // setState(() {
//   //     //   _isLoading = true;
//   //     // });
//   //     try {
//   //       await _auth.createUserWithEmailAndPassword(
//   //           email: _emailTextEditingController.text.toLowerCase().trim(),
//   //           password: _passwordTextEditingController.text.trim());
//   //       final User? user = _auth.currentUser;
//   //       final _uid = user!.uid;
//   //       final ref = FirebaseStorage.instance
//   //           .ref()
//   //           .child('userImage')
//   //           .child(_uid + '.jpg');
//   //       await ref.putFile(imageFile!);
//   //       url = await ref.getDownloadURL() ;
//   //       await FirebaseFirestore.instance.collection('users').doc(_uid).set({
//   //         'id': _uid,
//   //         'name': _fullNameTextEditingController.text,
//   //         'email': _emailTextEditingController.text,
//   //         'userImageUrl': url,
//   //         'phoneNumber': _phoneTextEditingController.text,
//   //         'positionInCompany': _positionCPTextEditingController.text,
//   //         'createsAt': Timestamp.now()
//   //       });
//   //       Navigator.canPop(context) ? Navigator.pop(context) : null;
//   //       //  print('form not valid ========================');
//   //     } catch (error) {
//   //
//   //         res = false;
//   //
//   //       GlobalMethod.showErrorDialog(context: context, error: error.toString());
//   //       print('error occurred $error');
//   //     }
//   //
//   //     //print('form not valid ========================');
//   //   } else {
//   //     print('form not valid ');
//   //   }
//   //
//   //   res = false;
//   //   return res ;
//   // }
//   //
//
//
//   void signOut() async {
//     try {
//       _auth.signOut();
//     } catch (e) {
//       print(e);
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_screens/global_method.dart';
import '../utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool res = false;
  final signUpGlobalKey = GlobalKey<FormState>();
  late final TextEditingController fullNameTextEditingController =
//  TextEditingController(text: '');
  //late final TextEditingController positionCPTextEditingController =
  TextEditingController(text: '');
  late final TextEditingController emailTextEditingController =
  TextEditingController(text: '');

  late final TextEditingController passwordTextEditingController =
  TextEditingController(text: '');

  late final TextEditingController phoneTextEditingController =
  TextEditingController(text: '');
  final FocusNode fullNameFocusNode = FocusNode();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

 // FocusNode positionFocusNode = FocusNode();

  FocusNode phoneFocusNode = FocusNode();



  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }

  Future<bool> submitFormSignUp(BuildContext context) async {
    // final isValid = _signUpGlobalKey.currentState!.validate();
    // FocusScope.of(context).unfocus();
    // if (isValid) {



      try {
        await _auth.createUserWithEmailAndPassword(
            email: emailTextEditingController.text.toLowerCase().trim(),
            password: passwordTextEditingController.text.trim());
        final User? user = _auth.currentUser;
        final _uid = user!.uid;

        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name':  fullNameTextEditingController.text,
          'email': emailTextEditingController.text,
          'phoneNumber': phoneTextEditingController.text,
         /// 'positionInCompany': positionCPTextEditingController.text,
          'createsAt': Timestamp.now()

        });
        res = true;
        Navigator.canPop(context) ? Navigator.pop(context) : null;
        //  print('form not valid ========================');
      } catch (error) {

          res = false;

      ///  GlobalMethod.showErrorDialog(context: context, error: error.toString());
        print('error occurred $error');
      }

      //print('form not valid ========================');
    // } else {
    //   print('form not valid ');
    // }
    //
    //   res = false;
return res ;
  }

  // @override
  // void dispose() {
  //
  //   fullNameTextEditingController.dispose();
  //   emailTextEditingController.dispose();
  //   passwordTextEditingController.dispose();
  //   phoneTextEditingController.dispose();
  //  // positionCPTextEditingController.dispose();
  //   fullNameFocusNode.dispose();
  //   emailFocusNode.dispose();
  //   passwordFocusNode.dispose();
  //   phoneFocusNode.dispose();
  // //  positionFocusNode.dispose();
  //
  // }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
