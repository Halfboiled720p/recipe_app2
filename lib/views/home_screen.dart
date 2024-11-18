import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/search_bar.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: Column(
        children: [
          CustomSearchBar(), // Tambahkan search bar dengan integrasi suara
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.searchResults[index]),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
