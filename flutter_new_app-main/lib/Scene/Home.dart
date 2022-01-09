
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Model/Acticle.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CustomTabContent.dart';
import 'MainRow.dart';

class Home extends StatefulWidget {
  bool isSearching = false ;
  List<String> tabs = ['Covid-19','business' ,'entertainment'  ,'health' ,'science' ,'sports' ,'technology'];
  List<String> tabsShow = List<String>();
  // List<String> tabsShow = tabs ;
  @override
  _Home createState() => _Home();
}


class _Home extends State<Home> {

  // final TabController tabController = DefaultTabController(length: 1) as TabController;
  String keySearch = "";
  List<Article> Search(List<Article> listeInit){
    List<Article> listeRes ;
    for (Article x in listeInit) {
      if (x.title.contains(keySearch)){
        listeRes.add(x);
      }
    }
    return listeRes ;
  }

  @override
  Widget build(BuildContext context) {
    widget.tabsShow =  widget.tabs;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: DefaultTabController(
              length: widget.tabs.length ,
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverAppBar(
                        flexibleSpace: Column(
                          children: [
                            Container(

                              padding: EdgeInsets.only(left: 20 , top: 30),
                              height: 110,
                              alignment: Alignment.centerLeft,
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Découverte",
                                    style: GoogleFonts.alfaSlabOne(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 30),
                                  ),
                                  Spacer(),
                                  Text("News du monde entier",
                                    style: GoogleFonts.ubuntu(color: Colors.grey , fontWeight: FontWeight.w500 , fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              margin: EdgeInsets.only(left: 20,right: 20 , top: 30 ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.black12,
                              ),
                              child: Row(

                                children: [
                                  InkWell(

                                    child: IconButton(
                                        icon: const Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                          size: 30.0,),
                                      onPressed:() {
                                        setState(() {
                                          // Navigator.of(cnt).pop();
                                          // widget.isSearching = true;
                                          Navigator.pushNamed(context, '/Search');
                                        });
                                      },

                                    ),
                                  ),
                                  Expanded(
                                      child: TextField(
                                          decoration: InputDecoration(
                                            border: null,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,

                                            hintText: 'Chercher',
                                          ),
                                        onChanged: (text) {
                                            setState(() {
                                              widget.isSearching = (text != "") ? true : false;
                                           });
                                            print('First text field: $text');
                                            keySearch = text ;

                                        },
                                      )

                                  ),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.filter_alt_rounded,
                                        color: Colors.grey,
                                        size: 30.0,)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.white,

                        collapsedHeight: 230.0,
                        expandedHeight: 230.0,
                        // The "forceElevated" property causes the SliverAppBar to show
                        // a shadow. The "innerBoxIsScrolled" parameter is true when the
                        // inner scroll view is scrolled beyond its "zero" point, i.e.
                        // when it appears to be scrolled below the SliverAppBar.
                        // Without this, there are cases where the shadow would appear
                        // or not appear inappropriately, because the SliverAppBar is
                        // not actually aware of the precise position of the inner
                        // scroll views.

                        forceElevated: innerBoxIsScrolled,
                      ),
                    SliverPersistentHeader(
                        delegate: MyDelegate(
                          DecoratedTabBar(
                            tabBar: TabBar(tabs:  widget.tabs.map((String name) => Tab(
                              child: Row(
                                children: <Widget>[
                                  if (name == "Covid-19" ) Icon(Icons.coronavirus,color: Colors.green,),
                                  Text(name,
                                      style: GoogleFonts.staatliches(fontWeight: FontWeight.w500 , fontSize: 30)
                                  ),
                                ]
                              )
                              ,)).toList(),
                              unselectedLabelColor: Colors.black12,
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              // indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              indicator:  BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(width: 3,color: Colors.black)
                                  )
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black12,
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      floating: true,
                      pinned: true,
                    )
                  ];
                },
                body: TabBarView(
                  // These are the contents of the tab views, below the tabs.
                  children: widget.tabsShow.map((String name) {
                    return Container(
                      //Add this to give height
                      height:  200,
                      child: TabBarView(children: [
                        for(var x in widget.tabsShow)  CustomCentent(title:x)
                      ]),margin: EdgeInsets.only( left: 20 , bottom: 180),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      )
    );
  }


  Widget _tabSection(BuildContext context) {
    final dataKey = new GlobalKey();
    // var heightCustom = (140*10).toDouble();
    List<String> _tabs = ['Sante', 'Politique', 'Corona','Corona','Corona','Corona','Corona','Corona'];
    return DefaultTabController(
      length: 8,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('Books'), // This is the title in the app bar.
                pinned: true,
                expandedHeight: 100.0,
                // The "forceElevated" property causes the SliverAppBar to show
                // a shadow. The "innerBoxIsScrolled" parameter is true when the
                // inner scroll view is scrolled beyond its "zero" point, i.e.
                // when it appears to be scrolled below the SliverAppBar.
                // Without this, there are cases where the shadow would appear
                // or not appear inappropriately, because the SliverAppBar is
                // not actually aware of the precise position of the inner
                // scroll views.
                forceElevated: innerBoxIsScrolled,
                bottom: DecoratedTabBar(
                  tabBar: TabBar(tabs: _tabs.map((String name) => Tab(
                      child: Text("Sante",
                      style: GoogleFonts.staatliches(fontWeight: FontWeight.w500 , fontSize: 30)
                      )
                    ,)).toList(),
                 unselectedLabelColor: Colors.black12,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    // indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicator:  BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 3,color: Colors.black)
                        )
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          // These are the contents of the tab views, below the tabs.
          children: _tabs.map((String name) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                // This Builder is needed to provide a BuildContext that is "inside"
                // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                // find the NestedScrollView.
                builder: (BuildContext context) {
                  return CustomScrollView(
                    // The "controller" and "primary" members should be left
                    // unset, so that the NestedScrollView can control this
                    // inner scroll view.
                    // If the "controller" property is set, then this scroll
                    // view will not be associated with the NestedScrollView.
                    // The PageStorageKey should be unique to this ScrollView;
                    // it allows the list to remember its scroll position when
                    // the tab view is not on the screen.
                    key: PageStorageKey<String>(name),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        // This is the flip side of the SliverOverlapAbsorber above.
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        // In this example, the inner scroll view has
                        // fixed-height list items, hence the use of
                        // SliverFixedExtentList. However, one could use any
                        // sliver widget here, e.g. SliverList or SliverGrid.
                        sliver: SliverFixedExtentList(
                          // The items in this example are fixed to 48 pixels
                          // high. This matches the Material Design spec for
                          // ListTile widgets.
                          itemExtent: 48.0,
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              // This builder is called for each child.
                              // In this example, we just number each list item.
                              return ListTile(
                                title: Text('Item $index'),
                              );
                            },
                            // The childCount of the SliverChildBuilderDelegate
                            // specifies how many children this inner list
                            // has. In this example, each tab has a list of
                            // exactly 30 items, but this is arbitrary.
                            childCount: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }).toList(),
      ),
    ),
    );
  }



}
class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate{
  MyDelegate(this.tabBar);
  final DecoratedTabBar tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}

