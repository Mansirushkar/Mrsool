import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/oreder_controller.dart';

class OrederView extends GetView<OrederController> {
  const OrederView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Empty space instead of map
          Container(
            color: Colors.grey[200],
            height: double.infinity,
            width: double.infinity,
          ),

          // Reject button - top right
          Positioned(
            top: 40,
            right: 20,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.amber, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: controller.onRejectPressed,
              child: const Text(
                "Reject",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Bottom details card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5, // Adjusted height for scrolling
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, -2),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Expected earnings",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Center(
                        child: Text(
                          "₦73.0",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),

                      // Horizontal line below earnings
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 70,
                      ),

                      // Distance and time row with vertical line
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text("Total distance", style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, color: Colors.black54, size: 18),
                                  const SizedBox(width: 6),
                                  const Text("3.6 km"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 100, // Increased height to match the image's vertical line
                            child: VerticalDivider(
                              color: Colors.black54,
                              thickness: 1,
                              width: 20,
                            ),
                          ),
                          Column(
                            children: [
                              const Text("Estimated time", style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_outlined, color: Colors.black54, size: 18),
                                  const SizedBox(width: 6),
                                  const Text("30 mins"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      // Horizontal divider
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 20,
                      ),
                      const SizedBox(height: 8),

                      // Pickup point with icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.flag_outlined, color: Colors.black54, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Othaim (1.8 km)",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Al Imam Faisal Ibn Turki Ibn Abdallah, Riyadh 12744, Saudi Arabia",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Vertical line to join pickup and drop-off
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 1,
                          height: 70, // Increased height
                          color: Colors.grey,
                        ),
                      ),

                      // Drop-off point with icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined, color: Colors.black54, size: 18),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              "3 Drop offs (1.8 Km)",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Custom slider
                      Obx(() => CustomSliderButton(
                        label: "Auto acceptance in ${controller.countdown.value} sec",
                        onComplete: controller.onAutoAcceptPressed,
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliderButton extends StatefulWidget {
  final VoidCallback onComplete;
  final String label;

  const CustomSliderButton({
    Key? key,
    required this.onComplete,
    required this.label,
  }) : super(key: key);

  @override
  State<CustomSliderButton> createState() => _CustomSliderButtonState();
}

class _CustomSliderButtonState extends State<CustomSliderButton> {
  double _dragPosition = 0.0;
  double _maxWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _maxWidth = constraints.maxWidth - 60; // knob width
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Positioned(
              left: _dragPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragPosition += details.delta.dx;
                    if (_dragPosition < 0) _dragPosition = 0;
                    if (_dragPosition > _maxWidth) _dragPosition = _maxWidth;
                  });
                },
                onHorizontalDragEnd: (_) {
                  if (_dragPosition > _maxWidth * 0.9) {
                    widget.onComplete();
                  }
                  setState(() {
                    _dragPosition = 0; // reset
                  });
                },
                child: Container(
                  height: 56,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.arrow_forward_ios, color: Colors.green, size: 24),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}