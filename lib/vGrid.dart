import './mIcons.dart';
import './vIcon.dart';
import 'package:flutter/material.dart';

class VGrid extends StatelessWidget {
  final int columnCount;
  final List<MIcon> icons;
  final Function onSelect;

  VGrid({
    @required this.columnCount,
    @required this.icons,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GridView.builder(
      physics: PageScrollPhysics(),
      shrinkWrap: true,
      itemCount: icons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
      ),
      itemBuilder: (context, index) {
        MIcon icon = icons[index];

        return GestureDetector(
          onTap: () {
            if (this.onSelect != null) {
              this.onSelect(icon);
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return VIcon(
                    icon: icon,
                  );
                },
                fullscreenDialog: true,
              ),
            );
          },
          child: Card(
            child: Hero(
              tag: icon.key,
              child: Stack(
                children: <Widget>[
                  Icon(
                    icon.iconData,
                    size: (deviceSize.width / columnCount) * 0.8,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: (icon.favorite)
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).errorColor,
                            size: (deviceSize.width / columnCount) * 0.3,
                          )
                        : Container(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
