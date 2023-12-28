import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/user_model.dart';
import 'package:flutter_onboarding/repository/user_repository.dart';
import 'package:flutter_onboarding/ui/screens/controllers/signup_controller.dart';
import 'package:flutter_onboarding/ui/screens/notifications.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:flutter_onboarding/ui/screens/widgets/google_signin.dart';
import 'package:flutter_onboarding/ui/screens/widgets/profile_controller.dart';
import 'package:flutter_onboarding/ui/screens/widgets/profile_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'my_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.put(SignUpController());
  final userRepo = Get.put(UserRepository());
  final profileController = Get.put(ProfileController());

  aboutMyApp() {
    showAboutDialog(
        context: context,
        applicationIcon: const FlutterLogo(),
        applicationName: 'Plant Doctor',
        applicationVersion: '1.0.0',
        applicationLegalese: 'Developed by Group 6 Level 300 C.O.T.',
        children: <Widget>[
          const Text(
            'This app helps you to take care of your plant and discover the different varities of plant.'
            'Plants are living organism like human beings which need care and attention.',
          ),
          const Text(
              'Without them we cannot beath so lets take good care of them')
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(16),
      height: size.height,
      width: size.width,
      child: FutureBuilder(
        future: profileController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.primaryColor.withOpacity(.5),
                        width: 3.0,
                      ),
                    ),
                    child: const CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage('assets/icon/default-profile.png')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userData.fullName,
                    style: TextStyle(
                      color: Constants.blackColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(
                      color: Constants.blackColor.withOpacity(.3),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MyProfile(
                                  currentUserId: '',
                                ),
                              ),
                            );
                          },
                          child: const ProfileWidget(
                            icon: Icons.person,
                            title: 'My Profile',
                          ),
                        ),
                        const ProfileWidget(
                          icon: Icons.settings,
                          title: 'Settings',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Notifications(),
                              ),
                            );
                          },
                          child: const ProfileWidget(
                            icon: Icons.notifications,
                            title: 'Notifications',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            aboutMyApp();
                          },
                          child: const ProfileWidget(
                            icon: Icons.info,
                            title: 'About',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            const urlPreview = 'https://flutter.dev/';
                            Share.share(
                                'Link to FLutter website:\n\n $urlPreview');
                          },
                          child: const ProfileWidget(
                            icon: Icons.share,
                            title: 'Share',
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.logout().then(
                              (value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignIn(),
                                  ),
                                );
                                controller.email.clear();
                                controller.password.clear();
                              },
                            );
                            Get.snackbar(
                              'Logout',
                              'You have been successfully logged out',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  Constants.primaryColor.withOpacity(0.1),
                              colorText: Constants.primaryColor,
                            );
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: const ProfileWidget(
                            icon: Icons.logout,
                            title: 'Log Out',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.primaryColor.withOpacity(.5),
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(user.photoURL as String),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(
                      color: Constants.blackColor.withOpacity(.3),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MyProfile(
                                  currentUserId: '',
                                ),
                              ),
                            );
                          },
                          child: const ProfileWidget(
                            icon: Icons.person,
                            title: 'My Profile',
                          ),
                        ),
                        const ProfileWidget(
                          icon: Icons.settings,
                          title: 'Settings',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Notifications(),
                              ),
                            );
                          },
                          child: const ProfileWidget(
                            icon: Icons.notifications,
                            title: 'Notifications',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            aboutMyApp();
                          },
                          child: const ProfileWidget(
                            icon: Icons.info,
                            title: 'About',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            const urlPreview = 'https://flutter.dev/';
                            Share.share(
                                'Link to FLutter website:\n\n $urlPreview');
                          },
                          child: const ProfileWidget(
                            icon: Icons.share,
                            title: 'Share',
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.logout().then(
                              (value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignIn(),
                                  ),
                                );
                                controller.email.clear();
                                controller.password.clear();
                              },
                            );
                            Get.snackbar(
                              'Logout',
                              'You have been successfully logged out',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  Constants.primaryColor.withOpacity(0.1),
                              colorText: Constants.primaryColor,
                            );
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: const ProfileWidget(
                            icon: Icons.logout,
                            title: 'Log Out',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 5,
              ),
            );
          }
        },
      ),
    ));
  }
}
