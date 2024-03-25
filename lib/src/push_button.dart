import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Game Button with Shadow and tap down effect
class PushButton extends StatefulWidget {
  const PushButton({
    super.key,
    this.backgroundColor,
    this.backgroundImage,
    this.borderRadius,
    this.buttonHeight = 50,
    this.buttonWidth = 200,
    required this.onPressed,
    required this.child,
    this.strokeWidth = 2,
    this.strokeColor = Colors.black,
    this.shadowColor,
    this.shadowOffset = 6,
  });
  final double buttonHeight;
  final double buttonWidth;
  final Color? backgroundColor;
  final String? backgroundImage;
  final BorderRadius? borderRadius;
  final double strokeWidth;
  final Color strokeColor;
  final Color? shadowColor;
  final double shadowOffset;
  final Widget child;

  final void Function() onPressed;

  @override
  State<PushButton> createState() => _PushButtonState();
}

class _PushButtonState extends State<PushButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.primary;
    final Color shadowColor =
        widget.shadowColor ?? Theme.of(context).shadowColor;
    final BorderRadius borderRadius =
        widget.borderRadius ?? BorderRadius.circular(15);

    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isPressed = false;
          // process the tap
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: widget.onPressed,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: widget.buttonWidth,
            height: widget.buttonHeight + widget.shadowOffset,
          ),
          Container(
            width: widget.buttonWidth,
            height: widget.buttonHeight,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: shadowColor,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            bottom: _isPressed ? 0 : widget.shadowOffset,
            child: Container(
              width: widget.buttonWidth,
              height: widget.buttonHeight,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: widget.strokeColor,
                  width: widget.strokeWidth,
                ),
                image: widget.backgroundImage != null
                    ? DecorationImage(
                        image: AssetImage(widget.backgroundImage ?? ''),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: backgroundColor,
              ),
              child: Center(child: widget.child),
            ),
          ),
        ],
      ),
    );
  }
}
