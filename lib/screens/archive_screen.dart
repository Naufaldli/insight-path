import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  String _searchQuery = '';

  Widget _getEleganMoodImage(String mood, {double size = 40}) {
    String assetPath;
    switch (mood) {
      case 'Bahagia': assetPath = 'assets/image/bahagia.png'; break;
      case 'Sedih': assetPath = 'assets/image/sedih.png'; break;
      case 'Marah': assetPath = 'assets/image/marah.png'; break;
      case 'Lelah': assetPath = 'assets/image/lelah.png'; break;
      case 'Cemas': assetPath = 'assets/image/cemas.png'; break;
      case 'Bersyukur': assetPath = 'assets/image/bersyukur.png'; break;
      default: assetPath = 'assets/image/tenang.png';
    }

    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.sentiment_satisfied, 
        size: size, 
        color: const Color(0xFF0D2F24),
      ),
    );
  }

  TableRow _buildCalendarRow(String weekNum, List<String> days, {String? highlightDay}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Center(
            child: Text(
              weekNum, 
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
        ),
        ...days.map((day) {
          final isHighlighted = day == highlightDay;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  color: isHighlighted ? const Color(0xFFE0A96D) : const Color(0xFF0D2F24),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);
    
    final filteredJournals = journalProvider.journals.where((journal) {
      final content = (journal['content'] ?? '').toString().toLowerCase();
      final mood = (journal['mood'] ?? '').toString().toLowerCase();
      final date = (journal['date'] ?? '').toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      
      return content.contains(query) || mood.contains(query) || date.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jurnal Saya',
                    style: TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF0D2F24),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today_outlined, color: Color(0xFF0D2F24), size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Color(0xFF626262), size: 22),
                    hintText: 'Cari berdasarkan kata kunci, mood, tanggal',
                    hintStyle: TextStyle(fontSize: 14, color: Color(0xFF9B9B9B)),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 14, color: Color(0xFF0D2F24)),
                ),
              ),
              const SizedBox(height: 24),

              // Floating Calendar Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ignore: deprecated_member_use
                        Icon(Icons.chevron_left, color: const Color(0xFF0D2F24).withOpacity(0.6)),
                        const Text(
                          'May',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
                        ),
                        // ignore: deprecated_member_use
                        Icon(Icons.chevron_right, color: const Color(0xFF0D2F24).withOpacity(0.6)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Table(
                      children: [
                        const TableRow(
                          children: [
                            Center(child: Text('05', style: TextStyle(fontSize: 11, color: Colors.grey))),
                            Center(child: Text('Mo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D2F24)))),
                            Center(child: Text('Tu', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D2F24)))),
                            Center(child: Text('We', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D2F24)))),
                            Center(child: Text('Th', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D2F24)))),
                            Center(child: Text('Fr', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D2F24)))),
                            Center(child: Text('Sa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D2F24)))),
                            Center(child: Text('Su', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D2F24)))),
                          ]
                        ),
                        _buildCalendarRow('18', ['27', '28', '29', '30', '1', '2', '3']),
                        _buildCalendarRow('19', ['4', '5', '6', '7', '8', '9', '10']),
                        _buildCalendarRow('20', ['11', '12', '13', '14', '15', '16', '17']),
                        _buildCalendarRow('21', ['18', '19', '20', '21', '22', '23', '24']),
                        _buildCalendarRow('22', ['25', '26', '27', '28', '29', '30', '31'], highlightDay: '25'),
                        _buildCalendarRow('23', ['1', '2', '3', '4', '5', '6', '7']),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Section Subtitle
              const Text(
                'Riwayat Refleksi',
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.w600, 
                  color: Color(0xFF626262),
                ),
              ),
              const SizedBox(height: 16),

              // Dynamic Journal List
              filteredJournals.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Text(
                          'Tidak ada riwayat jurnal ditemukan.', 
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredJournals.length,
                      itemBuilder: (context, index) {
                        final journal = filteredJournals[index];
                        final String dateStr = journal['date'] ?? '25 Mei 2026';
                        final String timeStr = journal['time'] ?? '20.45';
                        final String moodStr = journal['mood'] ?? 'Bahagia';
                        final String contentStr = journal['content'] ?? '';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _getEleganMoodImage(moodStr, size: 44),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '$dateStr • ',
                                          style: const TextStyle(
                                            fontSize: 13, 
                                            fontWeight: FontWeight.bold, 
                                            color: Color(0xFF0D2F24),
                                          ),
                                        ),
                                        Text(
                                          moodStr,
                                          style: TextStyle(
                                            fontSize: 13, 
                                            fontWeight: FontWeight.w600, 
                                            // ignore: deprecated_member_use
                                            color: const Color(0xFF0D2F24).withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      contentStr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12, 
                                        color: Color(0xFF626262), 
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      timeStr,
                                      style: TextStyle(
                                        fontSize: 10, 
                                        // ignore: deprecated_member_use
                                        color: const Color(0xFF0D2F24).withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.bookmark_border_rounded, 
                                // ignore: deprecated_member_use
                                color: const Color(0xFF0D2F24).withOpacity(0.5), 
                                size: 22,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}