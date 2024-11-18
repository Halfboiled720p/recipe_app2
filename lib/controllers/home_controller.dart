import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeController extends GetxController {
  final stt.SpeechToText _speech = stt.SpeechToText();

  // Variabel observable untuk status pengenalan suara dan teks pencarian
  var isListening = false.obs;
  var searchText = ''.obs;
  var searchResults = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      await _speech.initialize();
    } catch (e) {
      print("Speech initialization error: $e");
    }
  }

  // Memeriksa izin mikrofon
  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  // Memulai pengenalan suara
  Future<void> startListening() async {
    await checkMicrophonePermission();
    if (await Permission.microphone.isGranted) {
      isListening.value = true;
      await _speech.listen(onResult: (result) {
        searchText.value = result.recognizedWords; // Update teks
        _fetchRecipes(result.recognizedWords); // Cari resep
      });
    } else {
      print("Izin mikrofon ditolak.");
    }
  }

  // Menghentikan pengenalan suara
  Future<void> stopListening() async {
    isListening.value = false;
    await _speech.stop();
  }

  // Update teks pencarian dari input manual
  void updateSearchText(String text) {
    searchText.value = text;
    _fetchRecipes(text);
  }

  // Simulasi pencarian resep berdasarkan teks
  void _fetchRecipes(String query) {
    if (query.toLowerCase().contains("nasi")) {
      searchResults.value = [
        "Nasi Goreng Kimchi",
        "Nasi Lemak",
        "Nasi Ayam Hainan",
      ];
    } else if (query.toLowerCase().contains("mie")) {
      searchResults.value = [
        "Mie Goreng Jawa",
        "Mie Ayam Special",
        "Mie Rebus Pedas",
      ];
    } else {
      searchResults.value = ["Resep tidak ditemukan"];
    }
  }
}
