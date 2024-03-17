import 'package:flutter/material.dart';

class Topbar extends StatelessWidget {
  String _barTitle;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontsize;
  late double _height;
  late double _width;
  Topbar(this._barTitle,
      {this.primaryAction, this.secondaryAction, this.fontsize = 35});

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
      height: _height * 0.10,
      width: _width,
      child: Row(
        children: [
          if (secondaryAction != null) secondaryAction!,
          _titleBar(),
          if (primaryAction != null) primaryAction!,
        ],
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      _barTitle,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontsize ?? 22,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }
}
