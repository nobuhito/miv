import './mIcons.dart';
import './mSearches.dart';
import './vGrid.dart';
import 'package:flutter/material.dart';
import './vAbout.dart';

const FONT_FAMILY = "MaterialIcons";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MaterialIconsViewer());
  }
}

class MaterialIconsViewer extends StatefulWidget {
  @override
  _MaterialIconsViewerState createState() => _MaterialIconsViewerState();
}

class _MaterialIconsViewerState extends State<MaterialIconsViewer> {
  List<MIcon> icons;
  List<String> categories;

  List<MIcon> searchedIcons;

  TextEditingController textCtrl = TextEditingController();

  int columnsWidthCurrent;
  int columnsWidth;

  int currentPageIndex;

  @override
  void dispose() {
    textCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    this.currentPageIndex = 2;
    this.searchedIcons = [];

    this.columnsWidthCurrent = 64;
    this.columnsWidth = this.columnsWidthCurrent;

    MIcons().fetch().then((_icons) {
      setState(() {
        this.icons = _icons.items;
        this.categories = _icons.categories;
      });
    });

    textCtrl.addListener(() {
      setState(() {
        this.searchedIcons = this
            .icons
            .where((icon) => icon.key.contains(textCtrl.text))
            .toList();
      });
    });
    super.initState();
  }

  Widget body({int pageIndex, int tabIndex, int columnCount}) {
    if (pageIndex == 0) {
      return VAbout();
    }

    if (pageIndex == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: textCtrl,
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => textCtrl.text = "",
                  )),
            ),
          ),
          Expanded(
            child: (textCtrl.text == "")
                ? FutureBuilder(
                    future: MSearchs().get(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        physics: PageScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            (snapshot.hasData) ? snapshot.data.length : 0,
                        itemBuilder: (context, index) {
                          String keyword = snapshot.data[index];
                          return ListTile(
                            leading: Icon(Icons.history),
                            title: Text(keyword),
                            onTap: () => textCtrl.text = keyword,
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() => MSearchs().del(keyword));
                              },
                            ),
                          );
                        },
                      );
                    },
                  )
                : VGrid(
                    icons: this.searchedIcons,
                    columnCount: columnCount,
                    onSelect: (icon) => MSearchs().add(textCtrl.text)),
          ),
        ],
      );
    }

    List<MIcon> icons = [];
    if (pageIndex == 1) {
      icons = this.icons.where((icon) => icon.favorite).toList();
    }

    if (pageIndex == 2) {
      icons = this
          .icons
          .where((icon) => icon.category == this.categories[tabIndex])
          .toList();
    }

    return VGrid(
      icons: icons,
      columnCount: columnCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return (this.icons == null)
        ? Center(child: CircularProgressIndicator())
        : DefaultTabController(
            length: this.categories.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Material Icons"),
                bottom: (this.currentPageIndex != 2)
                    ? null
                    : TabBar(
                        isScrollable: true,
                        tabs: List.generate(this.categories.length, (index) {
                          return Text(
                            this.categories[index],
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                  color: Theme.of(context).canvasColor,
                                ),
                          );
                        }),
                      ),
              ),
              body: TabBarView(
                // physics: PageScrollPhysics(),
                children: List.generate(
                  (this.currentPageIndex != 2) ? 1 : this.categories.length,
                  (index) {
                    Size deviceSize = MediaQuery.of(context).size;
                    int columnCount = deviceSize.width ~/ this.columnsWidth;
                    return GestureDetector(
                      onScaleEnd: (_) {
                        this.columnsWidthCurrent = this.columnsWidth;
                      },
                      onScaleUpdate: (update) {
                        setState(() {
                          this.columnsWidth =
                              (this.columnsWidthCurrent * update.scale).toInt();
                        });
                      },
                      child: SafeArea(
                        child: body(
                          pageIndex: this.currentPageIndex,
                          columnCount: columnCount,
                          tabIndex: index,
                        ),
                      ),
                    );
                  },
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: this.currentPageIndex,
                onTap: (index) {
                  setState(() => this.currentPageIndex = index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    title: Text("About"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    title: Text("Favorite"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    title: Text("Serach"),
                  ),
                ],
              ),
            ),
          );
  }
}
