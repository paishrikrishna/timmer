import 'package:http/http.dart' as http;

class ApiCallsToTimer{
  
  Future<String> connectionStatus(String IP) async {
    var resp =  await http.get(Uri.parse('http://'+IP+'/'));
    return resp.body;
  }

  Future<String> deviceCount(String IP) async {
    var resp =  await http.get(Uri.parse('http://'+IP+'/Relay_Count'));
    return resp.body;
  }

}