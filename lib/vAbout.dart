import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import './wSpaceBox.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SvgPicture.asset(
              "icon/logo.svg",
              height: 128,
            ),
            Text(
              "Material Icons Viewer",
              style: Theme.of(context).textTheme.headline,
            ),
            Text("© 2018 Nobuhito SATO"),
            WSpaceBox.height(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton.icon(
                  icon: Icon(MdiIcons.githubFace),
                  label: Text("GitHub"),
                  onPressed: () {
                    launch("https://github.com/nobuhito/miv/");
                  },
                ),
                WSpaceBox.width(16),
                OutlineButton.icon(
                  icon: Icon(MdiIcons.twitter),
                  label: Text("Twitter"),
                  onPressed: () {
                    launch("https://twitter.com/nobuhito/");
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
