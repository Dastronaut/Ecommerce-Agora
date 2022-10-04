import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_agora/controllers/auth/auth_controller.dart';
import 'package:ecommerce_agora/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
