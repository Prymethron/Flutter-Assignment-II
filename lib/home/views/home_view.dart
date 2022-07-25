import 'package:assignment_2/home/utilities/utilities.dart';
import 'package:assignment_2/home/widgets/home_widgets.dart';
import 'package:assignment_2/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_page_controller.dart';

class MainPage extends StatelessWidget with ProjectPaddings {
  MainPage({Key? key}) : super(key: key);
  final MainPageController mainPageController = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: ProjectPaddings().cardPaddings,
      child: GetBuilder(
          init: MainPageController(),
          builder: (context) {
            if (mainPageController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (mainPageController.userList.isEmpty) {
              return const Center(child: Text(ProjectLanguage.emptyUserList));
            }
            return RefreshIndicator(
                onRefresh: mainPageController.fetchUsers,
                child: ListView.builder(
                    itemCount: mainPageController.userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PersonCard(
                          mainPageController: mainPageController, index: index);
                    }));
          }),
    ));
  }
}
