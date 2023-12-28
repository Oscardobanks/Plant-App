import 'package:flutter/material.dart';
import 'package:flutter_onboarding/models/plant_model.dart';
import 'package:flutter_onboarding/repository/plant_repository.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository.dart';

class PlantController extends GetxController {
  static PlantController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final plantname = TextEditingController();
  final temperature = TextEditingController();
  final humidity = TextEditingController();
  final description = TextEditingController();
  final imageurl = TextEditingController();

  final plantRepo = Get.put(PlantRepository());
  final _authRepo = Get.put(AuthenticationRepository());

  Future<void> createPlant(Plant plant) async {
    await plantRepo.createPlant(plant);
  }

  getPlantData() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return plantRepo.getPlantDetails(email);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }
}
