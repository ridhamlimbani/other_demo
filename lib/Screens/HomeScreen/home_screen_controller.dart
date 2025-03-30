import 'dart:async';

import 'package:filter_player/Model/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:go_router/go_router.dart';

class HomeScreenController extends GetxController{
  RxList<CollectionModel> collectionList = RxList();
  RxList<CollectionModel> allCollectionList = RxList();
  TextEditingController searchController = TextEditingController();

  // Filter Options
  RxString selectedType = "All".obs;
  RxString selectedVariable = "All".obs;
  RxString selectedDate = "All".obs;
  RxString fromDate = "".obs;
  RxString toDate = "".obs;

  RxInt hintIndex = 0.obs;
  late Timer _timer;

  final List<String> hints = [
    "Enter your name",
    "Enter your type",
  ];

  @override
  void onInit() {
    loadCollection();
    hintTextChanged();
    // TODO: implement onInit
    super.onInit();
  }

  hintTextChanged(){
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      hintIndex.value = (hintIndex.value + 1) % hints.length;
    });
  }
  
  loadCollection(){
    allCollectionList.value = [
      CollectionModel(
        id: 0,
        collectionName: "Collection 1",
        collectionType: 0,
        createdAt: "2025-03-03 04:26:11",
        stopped: true
      ),
      CollectionModel(
          id: 0,
          collectionName: "Collection 2",
          collectionType: 0,
          createdAt: "2025-03-05 04:26:11",
          stopped: false
      ),
      CollectionModel(
          id: 0,
          collectionName: "Collection 3",
          collectionType: 1,
          createdAt: "2025-03-06 04:26:11",
          stopped: true
      ),
    ];

    collectionList.value = allCollectionList.value;
  }

  filterPlayer({required BuildContext context}){

    List<CollectionModel> originalList = allCollectionList.value;

    List<CollectionModel> filteredList = originalList.where((item) {
      bool matchesType = selectedType.value == "All" ||
          (selectedType.value == "House Wise" && item.collectionType == 0) ||
          (selectedType.value == "Sq. Ft. Wise" && item.collectionType == 1);

      bool matchesVariable = selectedVariable.value == "All" ||
          (selectedVariable.value == "Open" && item.stopped == false) ||
          (selectedVariable.value == "Close" && item.stopped == true);

      bool matchesDate = selectedDate.value == "All" ||
          (selectedDate.value == "Custom" && item.createdAt.compareTo(fromDate.value) >= 0 &&
              item.createdAt.compareTo(toDate.value) <= 0);

      return matchesType && matchesVariable && matchesDate;
    }).toList();

    collectionList.value = filteredList;
    context.pop();
  }
  
  searchPlayer({required String value}){
    RxList<CollectionModel> result = RxList();
    
    if(value.toString().isEmpty) {
      result.assignAll(allCollectionList.value);
    } else {
      result.assignAll(
        allCollectionList.where((item) => item.collectionName.toLowerCase().trim().contains(value.toLowerCase().trim()))
      );
    }

    collectionList.value = result.value;

  }

  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}