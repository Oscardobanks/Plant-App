import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/screens/widgets/multiselect_formfield.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CarePlan extends StatefulWidget {
  const CarePlan({Key? key}) : super(key: key);

  @override
  State<CarePlan> createState() => _CarePlanState();
}

class _CarePlanState extends State<CarePlan> {
  final _categoryList = [
    'Indoor',
    'Garden',
    'Landscape',
    'Nursery',
    'Farm',
    'Forest',
  ];
  final _formkey = GlobalKey<FormState>();
  String _categoryVal = '';
  List? _myActivities;
  late String myActivitiesResult;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    myActivitiesResult = '';
  }

  saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        myActivitiesResult = _myActivities.toString();
      });
    }
  }

  _CarePlanState() {
    _categoryVal = _categoryList[0];
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          'Care Plan',
        ),
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
                'Fill the form below about your plant.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Plant Category:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
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
              const Text(
                'Plant Symptoms',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '(e.g. yellowing, wilting, death, leaf spot, deformity, discoloration, stunting, etc.)',
                style: TextStyle(
                  color: Constants.blackColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MultiSelectFormField(
                autovalidate: AutovalidateMode.disabled,
                chipBackGroundColor: Colors.blue,
                chipLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
                dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.blue,
                checkBoxCheckColor: Colors.white,
                dialogShapeBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Please select one or more options';
                  }
                  return null;
                },
                dataSource: const [
                  {
                    "display": "Yellowing",
                    "value": "Yellowing",
                  },
                  {
                    "display": "Wilting",
                    "value": "Wilting",
                  },
                  {
                    "display": "Leaf spot",
                    "value": "Leaf spot",
                  },
                  {
                    "display": "Deformity",
                    "value": "Deformity",
                  },
                  {
                    "display": "Discoloration",
                    "value": "Discoloration",
                  },
                  {
                    "display": "Stunting",
                    "value": "Stunting",
                  },
                  {
                    "display": "Death",
                    "value": "Death",
                  },
                  {
                    "display": "Other",
                    "value": "Other",
                  },
                ],
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                border: const OutlineInputBorder(),
                hintWidget: const Text('Please choose one or more'),
                initialValue: _myActivities,
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    _myActivities = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Geographic Location:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '(nearest city, state, country)',
                style: TextStyle(
                  color: Constants.blackColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                // controller: controller.humidity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Location',
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
                      // final plant = Plant(
                      //   plantName: controller.plantname.text.trim(),
                      //   category: _categoryVal,
                      //   size: '$_sizeVal',
                      //   temperature: controller.temperature.text.trim(),
                      //   humidity: int.parse(controller.humidity.text.trim()),
                      //   description: controller.description.text.trim(),
                      //   imageURL: imageFile!.path,
                      //   isFavorated: false,
                      //   isSelected: false, plantId: plantId,
                      // );
                      // PlantController.instance.createPlant(plant).then(
                      //   (value) {
                      //     Navigator.pop(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const PlantPage(
                      //           carePlants: [],
                      //         ),
                      //       ),
                      //     );
                      //     insertItem(
                      //       plantName: controller.plantname.text.trim(),
                      //       category: _categoryVal,
                      //       size: '$_sizeVal',
                      //       temperature: controller.temperature.text.trim(),
                      //       humidity:
                      //           int.parse(controller.humidity.text.trim()),
                      //       description: controller.description.text.trim(),
                      //       imageUrl: imageFile!.path,
                      //     );
                      //     controller.plantname.clear();
                      //     controller.temperature.clear();
                      //     controller.humidity.clear();
                      //     controller.description.clear();

                      //     Get.snackbar(
                      //       'Success',
                      //       'Your plant has been added',
                      //       snackPosition: SnackPosition.BOTTOM,
                      //       backgroundColor:
                      //           Constants.primaryColor.withOpacity(0.1),
                      //       colorText: Constants.primaryColor,
                      //     );
                      //   },
                      // );
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
