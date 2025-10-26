import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/services/notification_service.dart';

class NotificationWidget extends StatefulWidget {
  final Widget child;

  const NotificationWidget({super.key, required this.child});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final NotificationService _notificationService = NotificationService();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _notificationService.addListener(_showNotification);
  }

  @override
  void dispose() {
    _notificationService.removeListener(_showNotification);
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showNotification(String title, String message, NotificationType type) {
    // Delay notification until after build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      // Remove existing notification if any
      _overlayEntry?.remove();

      _overlayEntry = OverlayEntry(
        builder:
            (context) => Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: _NotificationCard(
                  title: title,
                  message: message,
                  type: type,
                  onDismiss: () {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  },
                ),
              ),
            ),
      );

      Overlay.of(context).insert(_overlayEntry!);

      // Auto dismiss after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _NotificationCard extends StatefulWidget {
  final String title;
  final String message;
  final NotificationType type;
  final VoidCallback onDismiss;

  const _NotificationCard({
    required this.title,
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<_NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<_NotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity!.abs() > 500) {
              _dismiss();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.type.color, widget.type.color.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.type.color.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.type.icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.message,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: _dismiss,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
