import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'text_field.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final InputMode _inputMode;
  final bool _isReplying;
  const ToggleButton({
    super.key,
    required InputMode inputMode,
    required VoidCallback sendTextMessage,
    required bool isReplying,
  })  : _inputMode = inputMode,
        _sendTextMessage = sendTextMessage,
        _isReplying = isReplying;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        padding: const EdgeInsets.only(top: 0),
      ),
      onPressed: widget._isReplying
          ? null
          : widget._inputMode == InputMode.text
              ? widget._sendTextMessage
              : null,
      // child: const Icon(
      //   Icons.send_outlined,
      //   size: 30,
      // ),
      child: Lottie.asset("assets/images/send1.json", height: 65),
    );
  }
}
