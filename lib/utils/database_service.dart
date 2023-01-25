import 'package:firebase_database/firebase_database.dart';
import 'package:greetings_and_wishes/model/message_res.dart';

class DatabaseService {

  static Future<List<MessageModel>> getNeeds() async {
    Query needsSnapshot = await FirebaseDatabase.instance
        .reference()
        .child("data")
        .orderByKey();

    print(needsSnapshot); // to debug and see if data is returned

    List<MessageModel> needs = [];

    /*Map<dynamic, dynamic> values = needsSnapshot.value;
    values.forEach((key, values) {
      needs.add(MessageModel.fromSnapshot(values));
    });
*/
    return needs;
  }
}