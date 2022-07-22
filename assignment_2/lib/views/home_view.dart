import 'package:assignment_2/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';
import '../controllers/main_page_controller.dart';

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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (mainPageController.userList.isEmpty) {
              return const Center(child: Text(ProjectLanguage.emptyUserList));
            }
            return RefreshIndicator(
              onRefresh: mainPageController.fetchUsers,
              child: ListView.builder(
                  itemCount: mainPageController.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PersonCard(
                      mainPageController: mainPageController,
                      index: index,
                    );
                  }),
            );
          }),
    ));
  }
}

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.mainPageController,
    required this.index,
  }) : super(key: key);

  final MainPageController mainPageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: const BorderSide(width: 0.5, color: Colors.grey)),
        child: Column(children: [
          PersonCardImage(mainPageController: mainPageController, index: index),
          Padding(
            padding: ProjectPaddings().cardItemPaddings,
            child: PersonCardInfos(
                mainPageController: mainPageController, index: index),
          ),
          PersonCardButtons(
              mainPageController: mainPageController, index: index)
        ]),
      ),
    );
  }
}

class PersonCardButtons extends StatelessWidget {
  const PersonCardButtons({
    Key? key,
    required this.mainPageController,
    required this.index,
  }) : super(key: key);

  final MainPageController mainPageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconButton(
          onPressed: () {
            mainPageController.toggleFavouriteStatus(index);
          },
          icon: Icon(mainPageController.userList[index].isFavourite
              ? Icons.favorite
              : Icons.favorite_border),
          color: Colors.red,
        ),
        IconButton(
            onPressed: () {
              _updateDialog(context);
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              mainPageController.removeUser(index);
            },
            icon: const Icon(Icons.delete))
      ]),
    );
  }

  Future<dynamic> _updateDialog(BuildContext context) {
    String? validateString(value) {
      if (value.isEmpty) {
        return "This field is required";
      }
      return null;
    }

    String? validateEmail(value) {
      if (value.isEmpty) {
        return "This field is required";
      } else if (!isEmail(value)) {
        return "Invalid email";
      }
      return null;
    }

    return showDialog(
        context: context,
        builder: (context) {
          final formKey = GlobalKey<FormState>();
          final TextEditingController nameTextController =
              TextEditingController();
          final TextEditingController emailTextController =
              TextEditingController();
          final TextEditingController websiteTextController =
              TextEditingController();
          final TextEditingController phoneTextController =
              TextEditingController();

          nameTextController.text = mainPageController.userList[index].name;
          emailTextController.text = mainPageController.userList[index].email;
          websiteTextController.text =
              mainPageController.userList[index].website;
          phoneTextController.text = mainPageController.userList[index].phone;

          Widget _requiredRichText(String title) {
            return Text.rich(TextSpan(
                style: const TextStyle(color: Colors.red),
                text: '*',
                children: [
                  TextSpan(
                      style: Theme.of(context).textTheme.bodyText2, text: title)
                ]));
          }

          return Dialog(
            child: SizedBox(
              height: 500,
              width: 400,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ProjectLanguage.basicModal,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _requiredRichText(ProjectLanguage.name),
                              _customTextFormField(
                                  nameTextController, validateString),
                              _requiredRichText(ProjectLanguage.email),
                              _customTextFormField(
                                  emailTextController, validateEmail),
                              _requiredRichText(ProjectLanguage.phone),
                              _customTextFormField(
                                  phoneTextController, validateString),
                              _requiredRichText(ProjectLanguage.website),
                              _customTextFormField(
                                  websiteTextController, validateString)
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(ProjectLanguage.cancel),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      mainPageController.updateUser(
                                          index,
                                          nameTextController.text,
                                          websiteTextController.text,
                                          emailTextController.text,
                                          phoneTextController.text);
                                      Get.back();
                                    }
                                  },
                                  child: const Text(ProjectLanguage.ok)),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          );
        });
  }
}

Padding _customTextFormField(
    TextEditingController textController, Function validate) {
  return Padding(
      padding: ProjectPaddings().textFormFieldPaddings,
      child: TextFormField(
        validator: (value) => validate(value),
        decoration: const InputDecoration(),
        controller: textController,
      ));
}

class PersonCardInfos extends StatelessWidget {
  const PersonCardInfos({
    Key? key,
    required this.mainPageController,
    required this.index,
  }) : super(key: key);

  final MainPageController mainPageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              mainPageController.userList[index].name,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
        CardListTile(
          title: mainPageController.userList[index].email,
          titleIcon: const Icon(Icons.mail),
        ),
        CardListTile(
          title: mainPageController.userList[index].phone,
          titleIcon: const Icon(Icons.phone),
        ),
        CardListTile(
          title: getWithHttp,
          titleIcon: const Icon(Icons.public),
        ),
      ],
    );
  }

  String get getWithHttp {
    if (isURL(mainPageController.userList[index].website) &&
        mainPageController.userList[index].website.substring(0, 3) != 'http') {
      return 'http://${mainPageController.userList[index].website}';
    }
    return mainPageController.userList[index].website;
  }
}

class PersonCardImage extends StatelessWidget {
  const PersonCardImage({
    Key? key,
    required this.mainPageController,
    required this.index,
  }) : super(key: key);

  final MainPageController mainPageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Theme.of(context).backgroundColor,
        ),
        height: ProjectSizes.cardImageHeight,
      ),
      Center(
        child: SvgPicture.network(
          _getImagesUrl,
          height: ProjectSizes.cardImageHeight,
          width: ProjectSizes.cardImageWidth,
          fit: BoxFit.cover,
        ),
      ),
    ]);
  }

  String get _getImagesUrl =>
      'https://avatars.dicebear.com/v2/avataaars/${mainPageController.userList[index].username}.svg?options[mood][]=happy';
}

class CardListTile extends StatelessWidget {
  const CardListTile({
    Key? key,
    required this.titleIcon,
    required this.title,
  }) : super(key: key);

  final Icon titleIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ProjectSizes.cardListTileHeight,
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: titleIcon,
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}

class ProjectSizes {
  static const double cardImageHeight = 200;
  static const double cardImageWidth = 200;
  static const double cardListTileHeight = 40;
}

class ProjectPaddings {
  final EdgeInsets cardPaddings =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 15);
  final EdgeInsets cardItemPaddings =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 30);
  final EdgeInsets textFormFieldPaddings =
      const EdgeInsets.symmetric(vertical: 15);
}
