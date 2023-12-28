import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/firebase_options.dart';
import 'package:flutter_onboarding/repository/authentication_repository.dart';
import 'package:flutter_onboarding/ui/screens/widgets/google_signin.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: const GetMaterialApp(
        title: 'Plant Doctor',
        defaultTransition: Transition.leftToRightWithFade,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 5,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
