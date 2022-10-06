import 'dart:async';
import 'dart:io';

import 'package:ecommerce_agora/shared/constant/auth_const.dart';
import 'package:ecommerce_agora/shared/constant/firebase_constant.dart';
import 'package:ecommerce_agora/shared/widgets/app_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final storage = GetStorage();

  late Rx<User?> firebaseUser;

  final RxList<String> errors = <String>[].obs;

  late UserCredential userCredential;
  late Timer timer;

  RxString dialCodeDigits = '+84'.obs;
  RxBool isRemember = false.obs;

  RxBool isLoading = false.obs;
  File? avatarImageFile;

  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController repassController = TextEditingController();

  final FocusNode focusNodeNickname = FocusNode();
  GlobalKey<FormState> singInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> singUpFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    firebaseUser = Rx<User?>(firebaseAuth.currentUser);

    firebaseUser.bindStream(firebaseAuth.userChanges());
  }

  @override
  void dispose() {
    super.dispose();
    displayNameController.dispose();
    phoneNumberController.dispose();
    passController.dispose();
    timer.cancel();
  }

  void clearLoginData() {
    errors.clear();
    emailController.clear();
    passController.clear();
  }

  void clearRegisterData() {
    errors.clear();
    passController.clear();
    repassController.clear();
  }

  Future<bool> register(String email, password) async {
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user?.uid == null) {
        return false;
      }
      // firebaseFirestore
      //     .collection(FirestoreConstants.pathUserCollection)
      //     .doc(userCredential.user!.uid)
      //     .set({
      //   FirestoreConstants.displayName: email,
      //   FirestoreConstants.photoUrl: '',
      //   FirestoreConstants.phoneNumber: '',
      //   FirestoreConstants.id: userCredential.user?.uid,
      //   FirestoreConstants.email: email,
      //   FirestoreConstants.createAt: userCredential.user?.metadata.creationTime,
      //   FirestoreConstants.lastSignInTime:
      //       userCredential.user?.metadata.lastSignInTime,
      // });
      print('USER CREDENTIAL: ${userCredential.toString()}');
      AppToast.showSuccess('Sign up successful with $email');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        addError(error: kEmailInUse);
      }
      if (e.code == 'weak-password') {
        addError(error: kWeakPassword);
      }
      AppToast.showError('Sign up failure with $email');
      return false;
    } catch (e) {
      AppToast.showError('Sign up failure with $email');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user?.uid == null) {
        return false;
      } else {
        storage.write('currentUID', userCredential.user?.uid);
        print('AUTH LOGED IN: ${userCredential.toString()}');
      }

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        addError(error: kUserNotFound);
      }
      if (e.code == 'wrong-password') {
        addError(error: kWrongPassword);
      }
      return false;
    }
  }

  Future<void> verifyEmail() async {
    try {
      await firebaseUser.value?.sendEmailVerification();
      AppToast.showSuccess('Sent verify email successful');
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        checkEmailVerified();
      });
    } catch (e) {
      AppToast.showError('Sent verify email failure');
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      await firebaseUser.value!.reload();
      if (firebaseUser.value!.emailVerified) {
        timer.cancel();
        update();
      }
    } catch (e) {
      timer.cancel();
    }
  }

  Future<bool> isLoggedIn() async {
    if (storage.read('currentUID') != '') {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      storage.write('currentUID', '');
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginAnonymously() async {
    userCredential = await FirebaseAuth.instance.signInAnonymously();
    print('ANONYMOUSLY LOGED IN: ${userCredential.toString()}');
  }

  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      AppToast.snackBar('success', 'Reset password link has sent');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        AppToast.snackBar('error', 'Your email is invalid');
      }
      AppToast.snackBar('error', 'Something wrong');
    }
  }

  Future<void> updateInfor(String imgUrl, String displayName) async {
    try {
      await firebaseUser.value?.updatePhotoURL('');
      await firebaseUser.value?.updateDisplayName(displayName);
      AppToast.showSuccess('Update Success');
    } catch (e) {
      AppToast.showError('Update Failed');
    }
  }

  Future<void> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      avatarImageFile = image;
      isLoading.value = true;
      // uploadFile();
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({required String error}) {
    if (errors.contains(error)) errors.remove(error);
  }
}
