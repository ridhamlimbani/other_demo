import 'package:filter_player/Screens/HomeScreen/home_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Obx(() => Expanded(
                  child: TextFormField(
                    onChanged: (value) => homeScreenController.searchPlayer(value: value),
                    decoration:  InputDecoration(
                      hintText: homeScreenController.hints[homeScreenController.hintIndex.value],
                      border: const OutlineInputBorder(),
                    ),
                  ),
                )),
                IconButton(
                  onPressed: (){
                    showFilterDialog(context);
                  },
                  icon: const Icon(
                    Icons.filter_alt,
                    color: Colors.black,
                  )
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 9.0,
                ),
                itemCount: homeScreenController.collectionList.value.length,
                itemBuilder: (context,index){
                  return Card(
                    borderOnForeground: true,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: homeScreenController.collectionList.value[index].collectionName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: "/",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                      ),
                                      TextSpan(
                                        text: "(${homeScreenController.collectionList.value[index].collectionType == 0 ? "House" : "Sq. Ft."})",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                homeScreenController.collectionList.value[index].createdAt.toString(),
                                style: const TextStyle(
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: homeScreenController.collectionList.value[index].stopped ==  true ? Colors.red : Colors.green
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  // 🔲 Show Filter Dialog
  void showFilterDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                  // Type
                   const Text(
                     "Filter of Type",
                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                   ),
                   const SizedBox(height: 5,),
                   Obx(() =>  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       selectionType(
                         value: 0,
                         text: "All"
                       ),
                       selectionType(
                           value: 1,
                           text: "House Wise"
                       ),

                       selectionType(
                           value: 2,
                           text: "Sq. Ft. Wise"
                       ),
                     ],
                   )),

                   const SizedBox(height: 15,),
                   const Text(
                    "Filter of Variable",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                   const SizedBox(height: 5,),
                   Obx(() =>  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       selectionVariable(
                         value: 0,
                         text: "All"
                       ),
                       selectionVariable(
                           value: 1,
                           text: "Open"
                       ),

                       selectionVariable(
                           value: 2,
                           text: "Close"
                       ),
                     ],
                   )),

                    const SizedBox(height: 15,),
                    const Text(
                      "Filter of Date",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5,),
                    Obx(() =>  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        selectionDate(
                            value: 0,
                            text: "All"
                        ),
                        selectionDate(
                            value: 1,
                            text: "Custom"
                        ),
                      ],
                    )),

                    Obx(() => homeScreenController.selectedDate.value.toLowerCase() == "custom"
                        ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30,),
                        TextFormField(
                          controller: TextEditingController(text: homeScreenController.fromDate.value),
                          decoration: const InputDecoration(hintText: "From Date", border: OutlineInputBorder()),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              homeScreenController.fromDate.value = pickedDate.toString().split(" ")[0];
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: TextEditingController(text: homeScreenController.toDate.value),
                          decoration: const InputDecoration(hintText: "To Date", border: OutlineInputBorder()),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              homeScreenController.toDate.value = pickedDate.toString().split(" ")[0];
                            }
                          },
                        ),
                      ],
                    )
                        : const SizedBox(),),

                    ElevatedButton(onPressed: (){
                      homeScreenController.filterPlayer(context: context);
                    }, child: const Text("Apply"))
                  ]
                ),
              ),
            )
        )
    );
  }

  Row selectionType({required int value, required String text}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: text,
          groupValue: homeScreenController.selectedType.value,
          onChanged: (value) => homeScreenController.selectedType.value = value!,
        ),
        InkWell(
          onTap: (){
            homeScreenController.selectedType.value = text;
          },
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black
            ),
          )
        ),
      ],
    );
  }

  Row selectionVariable({required int value, required String text}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: text,
          groupValue: homeScreenController.selectedVariable.value,
          onChanged: (value) => homeScreenController.selectedVariable.value = value!,
        ),
        InkWell(
          onTap: (){
            homeScreenController.selectedVariable.value = text;
          },
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black
            ),
          )
        ),
      ],
    );
  }

  Row selectionDate({required int value, required String text}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: text,
          groupValue: homeScreenController.selectedDate.value,
          onChanged: (value) => homeScreenController.selectedDate.value = value!,
        ),
        InkWell(
          onTap: (){
            homeScreenController.selectedDate.value = text;
          },
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black
            ),
          )
        ),
      ],
    );
  }
}
