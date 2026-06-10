import 'package:flutter/material.dart';
import '../core/database/database_helper.dart';

class JournalProvider with ChangeNotifier {
  List<Map<String, dynamic>> _journals = [];
  String _currentText = '';
  String _detectedMood = 'Tenang';

  List<Map<String, dynamic>> get journals => _journals;
  String get detectedMood => _detectedMood;
  bool get canAnalyzeLocally => true;

  void analyzeMoodLocally(String text) {
    updateText(text);
  }

  void updateText(String text) {
    _currentText = text;
    _analyzeMood(text);
    notifyListeners();
  }

  void _analyzeMood(String text) {
    final lowerText = text.toLowerCase();
    
    if (lowerText.contains('senang') || lowerText.contains('bahagia') || lowerText.contains('gembira')) {
      _detectedMood = 'Bahagia';
    } else if (lowerText.contains('sedih') || lowerText.contains('kecewa') || lowerText.contains('luka')) {
      _detectedMood = 'Sedih';
    } else if (lowerText.contains('marah') || lowerText.contains('kesal') || lowerText.contains('benci')) {
      _detectedMood = 'Marah';
    } else if (lowerText.contains('lelah') || lowerText.contains('capek') || lowerText.contains('lemes')) {
      _detectedMood = 'Lelah';
    } else if (lowerText.contains('takut') || lowerText.contains('cemas') || lowerText.contains('khawatir')) {
      _detectedMood = 'Cemas';
    } else if (lowerText.contains('bersyukur') || lowerText.contains('untung') || lowerText.contains('terima kasih')) {
      _detectedMood = 'Bersyukur';
    } else {
      _detectedMood = 'Tenang';
    }
  }

  Future<void> loadJournals() async {
    _journals = await DatabaseHelper.instance.fetchAllJournals();
    notifyListeners();
  }

  Future<void> saveJournal() async {
    if (_currentText.trim().isEmpty) return;

    final now = DateTime.now();
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final dateStr = "${now.day} ${months[now.month - 1]} ${now.year}";
    final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    String emoji;
    switch (_detectedMood) {
      case 'Bahagia': emoji = '✨'; break;
      case 'Sedih': emoji = '🌧️'; break;
      case 'Marah': emoji = '🔥'; break;
      case 'Lelah': emoji = '💤'; break;
      case 'Cemas': emoji = '🔮'; break;
      case 'Bersyukur': emoji = '💝'; break;
      default: emoji = '🍃';
    }

    await DatabaseHelper.instance.insertJournal({
      'date': dateStr,
      'time': timeStr,
      'content': _currentText,
      'mood': _detectedMood,
      'emoji': emoji,
    });

    _currentText = '';
    _detectedMood = 'Tenang';
    await loadJournals();
  }

  List<String> get activeJournalDays {
    return _journals.map((journal) {
      final dateStr = journal['date']?.toString() ?? '';
      return dateStr.split(' ').first;
    }).toList();
  }

  List<double> get weeklyMoodScores {
    if (_journals.isEmpty) return [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];

    final recent = _journals.take(7).toList().reversed.toList();
    List<double> scores = [];
    
    for (var journal in recent) {
      final mood = journal['mood']?.toString() ?? 'Tenang';
      if (mood == 'Bahagia' || mood == 'Bersyukur') {
        scores.add(0.2);
      } else if (mood == 'Tenang') {
        scores.add(0.5);
      } else {
        scores.add(0.8);
      }
    }

    while (scores.length < 7) {
      scores.insert(0, 0.5);
    }
    return scores;
  }
}