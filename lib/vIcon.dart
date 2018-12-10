import './mIcons.dart';
import 'package:flutter/material.dart';

class VIcon extends StatefulWidget {
  final MIcon icon;

  VIcon({@required this.icon});

  _VIconState createState() => _VIconState();
}

class _VIconState extends State<VIcon> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.icon.key),
        actions: <Widget>[
          IconButton(
            icon: AnimatedCrossFade(
              crossFadeState: (widget.icon.favorite)
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 500),
              firstChild: Icon(Icons.favorite),
              secondChild: Icon(Icons.favorite_border),
            ),
            onPressed: () {
              setState(() {
                widget.icon.toggleFavorite();
              });
            },
          )
        ],
      ),
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: (detail) {
            if (detail.primaryDelta > 5) {
              Navigator.pop(context);
            }
          },
          child: Hero(
            tag: widget.icon.key,
            child: Icon(
              widget.icon.iconData,
              size: 0.8 *
                  ((deviceSize.width < deviceSize.height)
                      ? deviceSize.width
                      : deviceSize.height),
            ),
          ),
        ),
      ),
    );
  }
}
