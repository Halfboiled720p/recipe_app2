import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final TextEditingController textController =
    TextEditingController(text: controller.searchText.value);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              // Perbarui isi TextField ketika searchText berubah
              textController.text = controller.searchText.value;
              textController.selection = TextSelection.collapsed(
                  offset: controller.searchText.value.length);

              return TextField(
                controller: textController,
                onChanged: (value) {
                  controller.updateSearchText(value);
                },
                decoration: InputDecoration(
                  hintText: 'Cari resep...',
                  border: OutlineInputBorder(),
                ),
              );
            }),
          ),
          IconButton(
            icon: Obx(() => Icon(
              controller.isListening.value ? Icons.mic : Icons.mic_none,
              color: controller.isListening.value ? Colors.red : null,
            )),
            onPressed: () async {
              if (controller.isListening.value) {
                // Hentikan pengenalan suara
                await controller.stopListening();
              } else {
                // Mulai pengenalan suara
                await controller.startListening();
              }
            },
          ),
        ],
      ),
    );
  }
}
