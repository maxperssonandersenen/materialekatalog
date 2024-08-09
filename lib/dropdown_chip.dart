import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final Widget menu;
  final Function()? onDeleted;
  final String label;
  final Color? chipColor;
  final bool openOnCreation;
  final IconData? iconData;
  final OverlayPortalController? overlayPortalController;
  const CustomDropDown({
    super.key,
    required this.menu,
    this.onDeleted,
    required this.label,
    this.chipColor,
    this.openOnCreation = true,
    this.iconData,
    this.overlayPortalController,
  });

  @override
  State<StatefulWidget> createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  bool _selected = false;
  final _link = LayerLink();
  late final OverlayPortalController _tooltipController;

  @override
  void initState() {
    _tooltipController = widget.overlayPortalController ?? OverlayPortalController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _tooltipController,
        overlayChildBuilder: (BuildContext context) {
          return Stack(children: [
            ModalBarrier(
              onDismiss: () {
                _tooltipController.hide();
                setState(() {
                  _selected = false;
                });
              },
            ),
            CompositedTransformFollower(
              showWhenUnlinked: false,
              link: _link,
              targetAnchor: Alignment.bottomLeft,
              child: Card(
                  color: Theme.of(context).chipTheme.selectedColor,
                  surfaceTintColor: Theme.of(context).chipTheme.selectedColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.menu,
                  )),
            )
          ]);
        },
        child: InputChip(
          avatar: widget.iconData != null ? Icon(widget.iconData) : null,
          color: MaterialStateProperty.all(widget.chipColor),
          showCheckmark: false,
          selected: _selected || _tooltipController.isShowing,
          selectedColor: Theme.of(context).chipTheme.selectedColor,
          onDeleted: widget.onDeleted,
          onPressed: () {
            onTap();
          },
          label: Text(widget.label),
        ),
      ),
    );
  }

  void onTap() {
    setState(() {
      _selected = !_selected;
    });
    _tooltipController.toggle();
  }
}
