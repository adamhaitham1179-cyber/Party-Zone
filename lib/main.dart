
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const PartyZoneApp());
}

const bg = Color(0xFF101026);
const panel = Color(0xFF20203D);
const purple = Color(0xFF8B5CF6);
const cyan = Color(0xFF36D9E8);

class PartyZoneApp extends StatelessWidget {
  const PartyZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Party Zone',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController(text: 'Player');
  String playerName = 'Player';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  String makeCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = Random();
    return List.generate(
      6,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
  }

  void createRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LobbyScreen(
          code: makeCode(),
          playerName: playerName,
          isHost: true,
        ),
      ),
    );
  }

  void joinRoom() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: panel,
        title: const Text('انضم لغرفة'),
        content: TextField(
          controller: controller,
          textCapitalization: TextCapitalization.characters,
          maxLength: 6,
          decoration: const InputDecoration(
            hintText: 'اكتب كود الغرفة',
            counterText: '',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final code = controller.text.trim().toUpperCase();
              if (code.length != 6) return;

              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'الغرف الأونلاين هتشتغل بعد ربط Firebase',
                  ),
                ),
              );
            },
            child: const Text('انضمام'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              Row(
                children: [
                  const Icon(Icons.bolt, color: cyan, size: 34),
                  const SizedBox(width: 8),
                  const Text(
                    'PARTY ZONE',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    backgroundColor: panel,
                    child: Icon(Icons.person, color: cyan),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF542DB7), Color(0xFF20203D)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اللعب أحلى مع صحابك! 🎉',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'جهّز أصحابك، اختار لعبة، وابدأ التحدي.',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 18),
                    Icon(Icons.groups, size: 64, color: cyan),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'اسم اللاعب',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: 'اكتب اسمك',
                  counterText: '',
                  filled: true,
                  fillColor: panel,
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  playerName = value.trim().isEmpty ? 'Player' : value.trim();
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 58,
                child: FilledButton.icon(
                  onPressed: createRoom,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text(
                    'إنشاء غرفة جديدة',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: joinRoom,
                  icon: const Icon(Icons.login),
                  label: const Text('الانضمام لغرفة'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: cyan),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'الألعاب المتاحة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              const GameCard(
                emoji: '🧠',
                title: 'تحدي الأسئلة',
                subtitle: 'مين أسرع واحد في الإجابة؟',
                color: Color(0xFF5C42C9),
              ),
              const SizedBox(height: 12),
              const GameCard(
                emoji: '😂',
                title: 'تحديات مضحكة',
                subtitle: 'تحدّى أصحابك وضحّك الكل',
                color: Color(0xFF126B78),
              ),
              const SizedBox(height: 12),
              const GameCard(
                emoji: '🎭',
                title: 'مين أنا؟',
                subtitle: 'خمن الشخصية من التلميحات',
                color: Color(0xFF93426E),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;

  const GameCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withAlpha(150)),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 35)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_back_ios_new, size: 17, color: color),
        ],
      ),
    );
  }
}

class LobbyScreen extends StatelessWidget {
  final String code;
  final String playerName;
  final bool isHost;

  const LobbyScreen({
    super.key,
    required this.code,
    required this.playerName,
    required this.isHost,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('غرفة اللعب')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 35),
              const Icon(Icons.groups, size: 85, color: cyan),
              const SizedBox(height: 20),
              const Text(
                'مستعدين للتحدي؟',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: panel,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text('كود الغرفة'),
                    const SizedBox(height: 10),
                    SelectableText(
                      code,
                      style: const TextStyle(
                        fontSize: 34,
                        color: cyan,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'دي غرفة تجريبية على الجهاز الحالي',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'اللاعب: $playerName',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'الخطوة الجاية: ربط الغرف واللاعبين بـ Firebase',
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('ابدأ اللعب'),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
