class Plant {
  final int plantId;
  final String size;
  final int humidity;
  final String temperature;
  final List<String> category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String decription;
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
        required this.decription,
        required this.isSelected});

  //Get the favorated items
  static List<Plant> getFavoritedPlants(){
    List<Plant> travelList = plantList;
    return travelList.where((element) => element.isFavorated == true).toList();
  } 

  // Get the care items
  static List<Plant> addedToCarePlants(){
    List<Plant> selectedPlants = plantList;
    return selectedPlants.where((element) => element.isSelected == true).toList();
  }
}

  var plantId = 0;
  //List of Plants data
  List<Plant> plantList = [
    Plant(
        plantId: plantId++,
        category: ['Indoor'],
        plantName: 'Sanseviera',
        size: 'Small',
        humidity: 34,
        temperature: '23 - 34',
        imageURL: 'assets/images/plant-one.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Outdoor'],
        plantName: 'Philodendron',
        size: 'Medium',
        humidity: 56,
        temperature: '19 - 22',
        imageURL: 'assets/images/plant-two.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Indoor'],
        plantName: 'Beach Daisy',
        size: 'Large',
        humidity: 34,
        temperature: '22 - 25',
        imageURL: 'assets/images/plant-three.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Outdoor'],
        plantName: 'Euonymus',
        size: 'Small',
        humidity: 35,
        temperature: '23 - 28',
        imageURL: 'assets/images/plant-four.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Recommended'],
        plantName: 'Big Bluestem',
        size: 'Large',
        humidity: 66,
        temperature: '12 - 16',
        imageURL: 'assets/images/plant-five.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Outdoor'],
        plantName: 'Meadow Sage',
        size: 'Medium',
        humidity: 36,
        temperature: '15 - 18',
        imageURL: 'assets/images/plant-six.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Garden'],
        plantName: 'Plumbago',
        size: 'Small',
        humidity: 46,
        temperature: '23 - 26',
        imageURL: 'assets/images/plant-seven.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Garden'],
        plantName: 'Begonias',
        size: 'Medium',
        humidity: 34,
        temperature: '21 - 24',
        imageURL: 'assets/images/plant-eight.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
    Plant(
        plantId: plantId++,
        category: ['Recommended'],
        plantName: 'Cactus',
        size: 'Small',
        humidity: 46,
        temperature: '21 - 25',
        imageURL: 'assets/images/plant-nine.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            ' even the harshest weather condition.',
        isSelected: false),
  ];

  
