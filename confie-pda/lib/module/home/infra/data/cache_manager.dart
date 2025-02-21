import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static const String sectorsKey = 'sectors_key';

  Future<void> saveSector(Map<String, String> sector) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> sectors = prefs.getStringList(sectorsKey) ?? [];
    sectors.add(sector.toString());
    await prefs.setStringList(sectorsKey, sectors);
  }

  Future<List<Map<String, String>>> getSectors() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> sectors = prefs.getStringList(sectorsKey) ?? [];
    return sectors.map((sector) {
      final Map<String, String> map = {};
      sector.substring(1, sector.length - 1).split(', ').forEach((element) {
        final keyValue = element.split(': ');
        map[keyValue[0]] = keyValue[1];
      });
      return map;
    }).toList();
  }

  Future<void> updateSector(Map<String, String> updatedSector) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> sectors = prefs.getStringList(sectorsKey) ?? [];

    int index = sectors.indexWhere((sector) {
      final Map<String, String> map = {};
      sector.substring(1, sector.length - 1).split(', ').forEach((element) {
        final keyValue = element.split(': ');
        map[keyValue[0]] = keyValue[1];
      });
      return map['sectorNumber'] == updatedSector['sectorNumber'];
    });

    if (index != -1) {
      sectors[index] = updatedSector.toString();
      await prefs.setStringList(sectorsKey, sectors);
    }
  }
}
