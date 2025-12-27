import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeController extends GetxController{
  var income = 0.0.obs;

  @override
  void onInit()async{
    super.onInit();
    await getIncome();
  }

  Future<void> saveIncome(double text)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble('income', text);
    income.value = text;
  }

  Future<void> getIncome()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var savedValue = sharedPreferences.getDouble('income') ?? 0.0;
    income.value = savedValue;
  }
}