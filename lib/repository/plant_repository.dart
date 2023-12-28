import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_onboarding/models/plant_model.dart';
import 'package:get/get.dart';

class PlantRepository extends GetxController {
  static PlantRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createPlant(Plant plant) async {
    await _db.collection("Plants").doc("Allplants").collection("Plant").add(plant.toJson());
  }

  Future<List<Plant>> getPlantDetails(String email) async {
    final snapshot =
        await _db.collection("Plants").doc("Allplants").collection("Plant").where("Email", isEqualTo: email).get();
    final plantData = snapshot.docs.map((e) => Plant.fromSnapshot(e)).toList();
    return plantData;
  }
}
