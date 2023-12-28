import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/plant_model.dart';
import 'package:flutter_onboarding/ui/screens/controllers/plant_controller.dart';
import 'package:flutter_onboarding/ui/screens/plant_page.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final _categoryList = ['Indoor', 'Garden', 'Landscape', 'Nursery', 'Farm', 'Forest'];
  final _sizeList = ['Small', 'Medium', 'Large', 'XLarge'];
  final _formkey = GlobalKey<FormState>();
  String _categoryVal = '';
  String? _sizeVal = '';

  late List<Plant> plantList;
  final controller = Get.put(PlantController());

  _AddPlantState() {
    _categoryVal =  _categoryList[0];
    _sizeVal = _sizeList[0];
  }

  XFile? imageFile;
  Future _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = XFile(pickedFile.path);
      });
    }
  }

  Future _getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = XFile(pickedFile!.path);
    });
  }

  Widget bottomSnackBar() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            'Choose Profile Photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _getFromCamera();
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Constants.primaryColor,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
              ElevatedButton.icon(
                onPressed: () {
                  _getFromGallery();
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Constants.primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plant'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              const Text(
                'Fill the form below to add a plant',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.plantname,
                decoration: const InputDecoration(
                  labelText: 'Plant Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Plant Name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                value: _categoryVal,
                items: _categoryList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _categoryVal = newValue!;
                  });
                },
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Constants.primaryColor,
                ),
                decoration: const InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                value: _sizeVal,
                items: _sizeList.map(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    _sizeVal = val as String;
                  });
                },
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Constants.primaryColor,
                ),
                decoration: const InputDecoration(
                  labelText: 'Size',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.temperature,
                decoration: const InputDecoration(
                  labelText: 'Temperature',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Plant Temperature';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.humidity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Humidity',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Plant Humidity';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                minLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please give a description';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSnackBar()),
                      );
                    },
                    child: const Text(
                      'Click to add plant image',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSnackBar()),
                      );
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Constants.primaryColor,
                      size: 40,
                    ),
                  )
                ],
              ),
              Container(
                  child: imageFile == null
                      ? const SizedBox(
                          height: 10,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Form(
                              autovalidateMode: AutovalidateMode.always,
                              child: SizedBox(
                                height: 100,
                                child: Image.file(
                                  File(imageFile!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              'Plant Preview',
                              style: TextStyle(
                                  fontSize: 20, color: Constants.blackColor),
                            ),
                          ],
                        )),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  side: BorderSide(
                      width: 2, color: Constants.primaryColor.withOpacity(0.7)),
                ),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    try {
                      final plant = Plant(
                        plantName: controller.plantname.text.trim(),
                        category: _categoryVal,
                        size: '$_sizeVal',
                        temperature: controller.temperature.text.trim(),
                        humidity: int.parse(controller.humidity.text.trim()),
                        description: controller.description.text.trim(),
                        imageURL: imageFile!.path,
                        isFavorated: false,
                        isSelected: false, plantId: plantId,
                      );
                      PlantController.instance.createPlant(plant).then(
                        (value) {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlantPage(),
                            ),
                          );
                          insertItem(
                            plantName: controller.plantname.text.trim(),
                            category: _categoryVal,
                            size: '$_sizeVal',
                            temperature: controller.temperature.text.trim(),
                            humidity:
                                int.parse(controller.humidity.text.trim()),
                            description: controller.description.text.trim(),
                            imageUrl: imageFile!.path,
                          );
                          controller.plantname.clear();
                          controller.temperature.clear();
                          controller.humidity.clear();
                          controller.description.clear();

                          Get.snackbar(
                            'Success',
                            'Your plant has been added',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                Constants.primaryColor.withOpacity(0.1),
                            colorText: Constants.primaryColor,
                          );
                        },
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        colorText: Colors.red,
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
