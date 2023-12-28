import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Plant {
  final int plantId;
  final String size;
  final int humidity;
  final String temperature;
  final String category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String description;
  bool isSelected;

  Plant(
      {required this.plantId,
      required this.category,
      required this.plantName,
      required this.size,
      required this.humidity,
      required this.temperature,
      required this.imageURL,
      required this.isFavorated,
      required this.description,
      required this.isSelected});

  //Get the favorated items
  static List<Plant> getFavoritedPlants() {
    List<Plant> travelList = plantList;
    return travelList.where((element) => element.isFavorated == true).toList();
  }

  // Get the care items
  static List<Plant> addedToCarePlants() {
    List<Plant> selectedPlants = plantList;
    return selectedPlants
        .where((element) => element.isSelected == true)
        .toList();
  }

    final user = FirebaseAuth.instance.currentUser!;
  toJson() {
    return {
      'Email': user.email,
      'PlantName': plantName,
      'Category': category,
      'Size': size,
      'Temperature': temperature,
      'Humidity': humidity,
      'Description': description,
      'ImageUrl': imageURL,
    };
  }

  factory Plant.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    var plantId = 1;
    return Plant(
      plantId: plantId++,
      plantName: data['PlantName'],
      category: data['Category'],
      size: data['Size'],
      temperature: data['Temperature'],
      humidity: data['Humidity'],
      description: data['Description'],
      imageURL: data['ImageUrl'],
      isFavorated: false,
      isSelected: false,
    );
  }
}
var plantId = 0;
List<Plant> plantList = [];
