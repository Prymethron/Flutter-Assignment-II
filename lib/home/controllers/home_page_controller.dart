import 'package:assignment_2/services/user_services.dart';
import 'package:get/get.dart';
import '../../model/user.dart';

class MainPageController extends GetxController {
  var userList = <User>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    isLoading(true);
    try {
      UserServices userServices = UserServices();
      userList.value = await userServices.getAllUsers();
    } finally {
      isLoading.value = false;
    }
    update();
  }

  void toggleFavouriteStatus(int id) {
    userList[id].isFavourite = !userList[id].isFavourite;
    update();
  }

  void removeUser(int id) {
    userList.removeAt(id);
    update();
  }

  void updateUser(
      int id, String name, String website, String email, String phone) {
    userList[id].name = name;
    userList[id].website = website;
    userList[id].email = email;
    userList[id].phone = phone;
    update();
  }
}
