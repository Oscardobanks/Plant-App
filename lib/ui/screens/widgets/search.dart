import 'package:flutter/material.dart';
import 'package:flutter_onboarding/models/plants.dart';
import 'package:flutter_onboarding/ui/screens/homepage_details.dart';
import 'package:page_transition/page_transition.dart';

class Search extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var plants in plantList) {
      if (plants.plantName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(plants.plantName);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<Plant> matchPlant = [];
    for (var plants in plantList) {
      if (plants.plantName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(plants.plantName);
      }
    }
    
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        for(var plants in plantList){
          if(plants.plantName.toLowerCase().contains(query.toLowerCase())){
             matchPlant.add(plants);
          }
        }
        return ListTile(
          title: Text(result),
          onTap: () => Navigator.push(
            context,
            PageTransition(
                child: HomePageDetails(
                  plantId: matchPlant[index].plantId,
                ),
                type: PageTransitionType.bottomToTop),
          ),
        );
      },
    );
  }
}
