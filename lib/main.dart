import 'package:flutter/material.dart';
import 'package:sliverlist_slivergrid/academy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LearningPathPage(),
    );
  }
}

class LearningPathPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicoding Learning Paths'),
      ),
      body: LearningPathList(),
    );
  }
}

/**
 * LearningPathList adalah widget yang menampilkan data learning path dan kelas
 */
class LearningPathList extends StatelessWidget {
  SliverPersistentHeader _header(String text) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
          minHeight: 60,
          maxHeight: 150,
          child: Container(
            color: Colors.lightBlue,
            child: Center(
              child: Text(text,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    /**
     * CustomScrollView adalah widget ScrollView yang membuat efek custom scroll
     * dengan Slivers. Widget ini memiliki parameter slivers yang mirip dengan
     * children. Isi parameter tersebut dengan widget sliver yang ingin ditampilkan.
     */
    return CustomScrollView(
      slivers: [
        _header('Android Developer'),
        /**
         * dibawah header merupakan daftar item yang ingin ditampilkan.
         * Parameter slivers hanya boleh diisi dengan widget sliver. Karena itu
         * akan digunakan widget SliverList untuk menampilkan list.
         */
        SliverList(
            delegate:
                SliverChildListDelegate(androidPaths.map(_buildTile).toList())),
        _header('iOS Developer'),
        SliverList(
          delegate: SliverChildListDelegate(
            iosPaths.map(_buildTile).toList(),
          ),
        ),
        _header('Multi-Platform App Developer'),
        SliverGrid.count(
          crossAxisCount: 2,
          children: flutterPaths.map(_buildTile).toList(),
        ),
        _header('Front-End Web Developer'),
        SliverGrid.count(
          crossAxisCount: 2,
          children: webPaths.map(_buildTile).toList(),
        )
      ],
    );
  }

  Widget _buildTile(Academy academy) {
    return ListTile(
      title: Text(academy.title),
      subtitle: Text(academy.description),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  /**
   * Widget pengecekan apakah widget perlu dibangun ulang
   */
  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
