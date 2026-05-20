import 'package:flutter/material.dart';

void main() {
  runApp(const CyberSafeApp());
}

class CyberSafeApp extends StatelessWidget {
  const CyberSafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xffeef3f8),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff1565C0),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      home: const LoginScreen(),
    );
  }
}

////////////////////////////////////////////////////////
/// LOGIN SCREEN
////////////////////////////////////////////////////////

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1565C0), Color(0xff42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Card(
              elevation: 12,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),

              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const Icon(Icons.security, size: 90, color: Colors.blue),

                    const SizedBox(height: 20),

                    const Text(
                      "CyberSafe",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Protect Your Digital Life",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      decoration: InputDecoration(
                        labelText: "Email",

                        prefixIcon: const Icon(Icons.email),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      obscureText: true,

                      decoration: InputDecoration(
                        labelText: "Password",

                        prefixIcon: const Icon(Icons.lock),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },

                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// HOME SCREEN WITH BOTTOM NAVIGATION
////////////////////////////////////////////////////////

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const DashboardPage(),
    const TipsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: "Security",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// DASHBOARD SCREEN
////////////////////////////////////////////////////////

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Widget buildCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget page,
  ) {
    return Card(
      elevation: 8,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),

        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

        subtitle: Text(subtitle),

        trailing: const Icon(Icons.arrow_forward_ios),

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CyberSafe Dashboard")),

      body: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Cyber Security Features",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 18),

            const Text(
              "Stay protected against cyber threats and improve your digital security awareness.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 25),

            buildCard(
              context,
              Icons.password,
              "Password Strength Checker",
              "Check password security level",
              const PasswordCheckerScreen(),
            ),

            buildCard(
              context,
              Icons.warning,
              "Security Tips",
              "Learn cyber awareness",
              const TipsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// PASSWORD CHECKER SCREEN
////////////////////////////////////////////////////////

class PasswordCheckerScreen extends StatefulWidget {
  const PasswordCheckerScreen({super.key});

  @override
  State<PasswordCheckerScreen> createState() => _PasswordCheckerScreenState();
}

class _PasswordCheckerScreenState extends State<PasswordCheckerScreen> {
  String result = "Enter Password";

  double strength = 0;

  void checkPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        result = "Enter Password";
        strength = 0;
      } else if (value.length < 6) {
        result = "Weak Password";
        strength = 0.3;
      } else if (value.length < 10) {
        result = "Medium Password";
        strength = 0.6;
      } else {
        result = "Strong Password";
        strength = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Password Checker")),

      body: Padding(
        padding: const EdgeInsets.all(22),

        child: Column(
          children: [
            const Icon(Icons.lock_outline, size: 100, color: Colors.blue),

            const SizedBox(height: 25),

            TextField(
              obscureText: true,
              onChanged: checkPassword,

              decoration: InputDecoration(
                labelText: "Enter Password",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),

              child: LinearProgressIndicator(value: strength, minHeight: 14),
            ),

            const SizedBox(height: 20),

            Text(
              result,

              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("• Use 8+ characters"),
                  Text("• Add symbols"),
                  Text("• Use uppercase letters"),
                  Text("• Avoid common passwords"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// SECURITY TIPS SCREEN
////////////////////////////////////////////////////////

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  Widget tipCard(IconData icon, String title, String text) {
    return Card(
      elevation: 5,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 36),

        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

        subtitle: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cyber Safety Tips")),

      body: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [
            tipCard(
              Icons.warning,
              "Avoid Suspicious Links",
              "Never click unknown email links.",
            ),

            tipCard(
              Icons.wifi,
              "Public WiFi Safety",
              "Avoid banking using public WiFi.",
            ),

            tipCard(
              Icons.verified_user,
              "Enable Two-Factor Authentication",
              "Add extra account protection.",
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// PROFILE SCREEN
////////////////////////////////////////////////////////

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget profileCard(IconData icon, String title) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 36),

        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,

              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 20),

            const Text(
              "Shahedur Rahman Nayem",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Cyber Security Student",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            const SizedBox(height: 8),

            const Text("CyberSafe v1.0", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 30),

            profileCard(Icons.settings, "Settings"),

            profileCard(Icons.info, "App Info"),
          ],
        ),
      ),
    );
  }
}
