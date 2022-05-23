import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppServicess {
  final _box = GetStorage();
  final _isFirstTime = true;
  _saveData(bool _isFirst) => _box.write("is_FirstTime", _isFirst);
  bool readData() => _box.read("is_FirstTime") ?? true;
  void afterLonchapp() => _box.write("is_FirstTime", false);
}
