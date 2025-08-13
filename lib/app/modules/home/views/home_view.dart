import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F6F6);
    const primary = Color(0xFF00B66A); // green
    const danger = Color(0xFFE53935);  // red
    const textDark = Color(0xFF1E1E1E);
    const textLight = Color(0xFF6B6B6B);
    final radius24 = BorderRadius.circular(24);

    return Scaffold(
      backgroundColor: bg,
      // If you already have a global bottom bar, remove bottomNavigationBar below.
      bottomNavigationBar: _BottomBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
              child: Row(
                children: [
                  // Left trophy icon
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.emoji_events_rounded, color: primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  // Title + subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Courier Orders',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: textDark,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "You're Online",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Go Offline pill button
                  _GoOfflineButton(color: danger),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Center illustration + message card
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Illustration circle
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: radius24,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.04),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        Icon(Icons.search_rounded, size: 86, color: Color(0xFF00BBD4)),
                        Positioned(
                          top: 56,
                          child: Icon(Icons.inventory_2_rounded, size: 28, color: Color(0xFFFFB74D)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Message pill
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: radius24,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: const [
                          Text(
                            'Waiting for orders!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: textDark,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Keep the app in the foreground to receive new orders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textLight,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Red rounded "Go Offline" button with arrow
class _GoOfflineButton extends StatelessWidget {
  final Color color;
  const _GoOfflineButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: () {
          // TODO: hook to controller.goOffline();
        },
        borderRadius: BorderRadius.circular(28),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Go Offline',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom navigation to mirror the screenshot (remove if you already have one)
class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (i) {
        // TODO: route to tabs if needed
      },
      backgroundColor: Colors.white,
      height: 72,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.route_rounded),
          selectedIcon: Icon(Icons.route_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          label: 'Orders',
        ),
        NavigationDestination(
          icon: Icon(Icons.schedule_rounded),
          label: 'Schedule',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_none_rounded),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: CircleAvatar(radius: 10),
          label: 'Profile',
        ),
      ],
    );
  }
}
