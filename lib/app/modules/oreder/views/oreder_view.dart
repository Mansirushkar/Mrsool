import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/oreder_controller.dart';

class OrederView extends GetView<OrederController> {
  const OrederView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Column(
          children: [
            // Map placeholder with Reject button
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white, // Blank map area
                  ),
                  Positioned(
                    top: 10,
                    right: 16,
                    child: _RejectButton(onTap: () {}),
                  ),
                ],
              ),
            ),

            // Bottom sheet card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Grab handle
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 14),

                  const Text(
                    'Expected earnings',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '₤',
                        style: TextStyle(
                          color: Color(0xFF0E9F6E),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '73.0',
                        style: TextStyle(
                          color: Color(0xFF0E9F6E),
                          fontSize: 44,
                          height: 0.9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  Row(
                    children: const [
                      _StatTile(
                        icon: Icons.location_on_outlined,
                        title: 'Total distance',
                        value: '3.6 km',
                      ),
                      SizedBox(width: 16),
                      _StatTile(
                        icon: Icons.access_time_outlined,
                        title: 'Estimated time',
                        value: '30 mins',
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Store line
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _BulletIcon(isStore: true),
                      SizedBox(width: 12),
                      Expanded(
                        child: _TwoLine(
                          title: 'Othaim (1.8 km)',
                          subtitle:
                          'Al Imam Faisal Ibn Turki Ibn Abdallah, الخزان، Riyadh 12744, Saudi Arabia',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Drop offs line
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      _BulletIcon(isStore: false),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '3 Drop offs (1.8 Km)',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Bottom CTA
                  Obx(() {
                    final s = controller.secondsLeft.value;
                    return _CTA(
                      seconds: s,
                      onPressed: () {},
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RejectButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RejectButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFFFD65C), width: 2),
          color: Colors.white,
        ),
        child: const Text(
          'Reject',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _StatTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black87),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _BulletIcon extends StatelessWidget {
  final bool isStore;
  const _BulletIcon({required this.isStore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E7EB)),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isStore ? CupertinoIcons.bag_fill : CupertinoIcons.house_fill,
            size: 18,
            color: isStore ? const Color(0xFF10B981) : Colors.black87,
          ),
        ),
        Container(
          width: 2,
          height: 38,
          color: const Color(0xFFE5E7EB),
        ),
      ],
    );
  }
}

class _TwoLine extends StatelessWidget {
  final String title;
  final String subtitle;
  const _TwoLine({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }
}

class _CTA extends StatelessWidget {
  final int seconds;
  final VoidCallback onPressed;
  const _CTA({required this.seconds, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          elevation: 0,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              left: 8,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                'Auto acceptance in $seconds sec',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
