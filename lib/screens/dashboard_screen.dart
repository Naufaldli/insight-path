import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import 'canvas_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Map<String, String>> _moodList = const [
    {'image': 'assets/image/tenang.png', 'label': 'Tenang'},
    {'image': 'assets/image/bahagia.png', 'label': 'Bahagia'},
    {'image': 'assets/image/sedih.png', 'label': 'Sedih'},
    {'image': 'assets/image/marah.png', 'label': 'Marah'},
    {'image': 'assets/image/lelah.png', 'label': 'Lelah'},
    {'image': 'assets/image/cemas.png', 'label': 'Cemas'},
    {'image': 'assets/image/bersyukur.png', 'label': 'Bersyukur'},
  ];

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);

    final int uniqueDays = journalProvider.journals.map((journal) {
      final dateValue = journal['date'] ?? journal['tanggal'] ?? '';
      if (dateValue is DateTime) {
        return dateValue.toIso8601String().split('T')[0];
      }
      return dateValue.toString().split(' ')[0];
    }).toSet().length;

    final int totalJurnal = journalProvider.journals.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Profil
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selamat Siang,',
                        style: TextStyle(fontSize: 16, color: Color(0xFF626262)),
                      ),
                      const Text(
                        'Naufal',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
                      ),
                      Text(
                        'Bagaimana hari mu hari ini?',
                        // ignore: deprecated_member_use
                        style: TextStyle(fontSize: 14, color: const Color(0xFF0D2F24).withOpacity(0.4)),
                      ),
                    ],
                  ),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D2F24),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'N',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),

              // Bagian Mood
              Text(
                'Mood Hari Ini',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  // ignore: deprecated_member_use
                  color: const Color(0xFF0D2F24).withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _moodList.length,
                  itemBuilder: (context, index) {
                    final moodItem = _moodList[index];
                    final String imagePath = moodItem['image'] ?? 'assets/images/tenang.png';
                    final String labelText = moodItem['label'] ?? 'Tenang';

                    return Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: const Color(0xFFFFE0B2).withOpacity(0.15),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  )
                                ]),
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.sentiment_satisfied,
                                color: Color(0xFF0D2F24),
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            labelText,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0D2F24)),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // CTA Menulis
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CanvasScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // ignore: deprecated_member_use
                    border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.08)),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mulai Menulis',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tuangkan pikiran mu\ndi sini...',
                              // ignore: deprecated_member_use
                              style: TextStyle(fontSize: 14, color: const Color(0xFF626262).withOpacity(0.9), height: 1.3),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF0D2F24), size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Kutipan
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D2F24),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF0D2F24).withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kutipan Hari Ini',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.6),
                          letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '“The unexamined life is not worth living.”',
                      style: TextStyle(
                        fontFamily: 'Newsreader',
                        fontSize: 17,
                        color: Color(0xFFE0A96D),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '— Socrates',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE0A96D),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Statistik Mini
              Text(
                'Statistik Mingguan',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    // ignore: deprecated_member_use
                    color: const Color(0xFF0D2F24).withOpacity(0.5)),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF8DAA91),
                  borderRadius: BorderRadius.circular(24),
                  // ignore: deprecated_member_use
                  border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.03)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMiniStat(uniqueDays.toString(), 'Hari Menulis'),
                    // ignore: deprecated_member_use
                    Container(width: 1, height: 30, color: const Color(0xFFFFFFFF).withOpacity(0.15)),
                    _buildMiniStat(totalJurnal.toString(), 'Jurnal Ditulis'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF))),
      ],
    );
  }
}