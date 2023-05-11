
import 'package:todo/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesServices{
  Future saveAccount (Account account)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', account.userName!);
    await prefs.setString('occupation', account.occupation!);
    print('Save UserName');
    print('Save occupation');
  }

  Future getAccount ()async{
    final prefs = await SharedPreferences.getInstance();
    final userName =  prefs.getString('username') ?? '';
    final occupation = prefs.getString('occupation') ?? '';
    return Account(
      userName: userName,
      occupation: occupation
    );
  }
}