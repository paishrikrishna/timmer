import 'package:http/http.dart' as http;

class ApiCallsToTimer{
  
  Future<String> connectionStatus(String IP) async {
    String Url = 'http://$IP/?year=${DateTime.now().year}&month=${DateTime.now().month}&date=${DateTime.now().day}&hr=${DateTime.now().hour}&min=${DateTime.now().minute}&sec=${DateTime.now().second}';
    var resp =  await http.get(Uri.parse(Url));
    return resp.body;
  }

  Future<String> ScheduleCount(String IP) async {
    var resp =  await http.get(Uri.parse('http://'+IP+'/Schedule_Count'));
    print("Got Schedules ${resp.body}");
    return resp.body;
  }

  Future<String> pushSchedule(String Start_hr,String Start_min,String End_hr,String End_min,String Relay_code,String Day_code, String ReqType) async{
    print("Push Schedules");
    String Url = 'http://192.168.1.1/Create_Schedule?ReqType=${ReqType}&Start_hr=${Start_hr}&Start_min=${Start_min}&End_hr=${End_hr}&End_min=${End_min}&Relay_code=${Relay_code}&Day_code=${Day_code}';
    print(Url);
    var resp =  await http.get(Uri.parse(Url));
    return resp.body;
  }

  Future<String> ScheduleDetails(String Schedule_no) async {
    var resp =  await http.get(Uri.parse('http://192.168.1.1/Schedule_Details?Schedule_no=${Schedule_no}'));
    print("Log from API");
    print(resp.body);
    return resp.body;
  }
  
  Future<String> DeleteScheduleDetails(String Schedule_no) async {
    var resp =  await http.get(Uri.parse('http://192.168.1.1/Delete_Schedule?ScheduleNo=${Schedule_no}'));
    print("Log from API");
    print(resp.body);
    return resp.body;
  }

}
