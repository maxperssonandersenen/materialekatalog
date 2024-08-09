import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final String title;
  final String unit;
  final Function(String) onChanged;

  const SliderWidget({super.key, required this.title, required this.unit, required this.onChanged});
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    var data = ' < ${_value.ceil()} ${widget.unit}';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${widget.title} $data',
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: _value,
          label: '${_value.ceil()} ${widget.unit}',
          min: 0.0,
          max: 100.0,
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
            });
            widget.onChanged(data);
          },
        ),
      ],
    );
  }
}
