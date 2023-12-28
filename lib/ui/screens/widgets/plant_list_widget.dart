import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/plant_model.dart';
import 'package:flutter_onboarding/ui/screens/detail_page.dart';
import 'package:page_transition/page_transition.dart';

class PlantListWidget extends StatefulWidget {
  final Plant item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  const PlantListWidget({
    Key? key,
    required this.animation,
    this.onClicked,
    required this.item,
  }) : super(key: key);

  @override
  State<PlantListWidget> createState() => _PlantListWidgetState();
}

class _PlantListWidgetState extends State<PlantListWidget> {
  List<Plant> items = List.from(plantList);

  @override
  Widget build(BuildContext context) => SizeTransition(
        key: ValueKey(widget.item.imageURL),
        sizeFactor: widget.animation,
        child: buildItem(),
      );

  Widget buildItem() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: DetailPage(
              plantId: widget.item.plantId,
            ),
            type: PageTransitionType.bottomToTop,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 60.0,
                decoration: BoxDecoration(
                  color: Constants.primaryColor.withOpacity(.8),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                  bottom: -40,
                  left: 0,
                  right: 0,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(File(widget.item.imageURL))
                ),
              )
            ],
          ),
          title: Stack(
            children: [
              Positioned(
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.plantName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.item.category,
                      style: TextStyle(
                        fontSize: 14,
                        color: Constants.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: widget.onClicked,
            icon: Icon(
              Icons.delete,
              color: Constants.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
