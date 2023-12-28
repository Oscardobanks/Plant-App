import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/screens/widgets/custom_search.dart';
import 'package:flutter_onboarding/ui/screens/widgets/plant_list_widget.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../models/plant_model.dart';
import 'add_plant.dart';
import 'controllers/plant_controller.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({Key? key}) : super(key: key);


  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  final listKey = GlobalKey<AnimatedListState>();
  final pageController = Get.put(PlantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Plants',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearch(),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            )
          ],
        ),
        backgroundColor: Constants.primaryColor,
      ),
      body: FutureBuilder(
        future: pageController.getPlantData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return AnimatedList(
                padding: const EdgeInsets.symmetric(vertical: 15),
                key: listKey,
                initialItemCount: plantList.length,
                itemBuilder: (context, index, animation) => PlantListWidget(
                  item: plantList[index],
                  animation: animation,
                  onClicked: () => removeItem(index),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/icon/plant.png',
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Plants',
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/icon/plant.png',
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Plants',
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const AddPlant(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

void insertItem({
  required String description,
  required int humidity,
  required String temperature,
  required String size,
  required String category,
  required String plantName,
  required String imageUrl,
}) {
  const newIndex = 0;
  final listKey = GlobalKey<AnimatedListState>();
  final newItem = Plant(
      category: category,
      plantName: plantName,
      size: size,
      humidity: humidity,
      temperature: temperature,
      imageURL: imageUrl,
      isFavorated: false,
      description: description,
      isSelected: false,
      plantId: plantId++);

  plantList.insert(newIndex, newItem);
  var current = listKey.currentState;
  if (current != null) {
    current.insertItem(
      newIndex,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
  }
}

void removeItem(int index) {
  final listKey = GlobalKey<AnimatedListState>();
  plantList.removeAt(index).plantId;
  var current = listKey.currentState;
  if (current != null) {
    current.removeItem(
      index,
      (context, animation) => PlantListWidget(
        item: plantList[index],
        animation: animation,
        onClicked: () {},
      ),
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }
}
