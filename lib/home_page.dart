import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Programmer {
  final String name;
  final String experiences;

  Programmer({required this.name, required this.experiences});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Programmer> programmers = [];
  bool loading = false;

  Future<void> loadList() async {
    setState(() => loading = true);

    await Future.delayed(Duration(seconds: 2));

    programmers.clear();
    programmers.addAll([
      Programmer(
        name: 'Bernardo Veras',
        experiences: 'Flutter, Dart, C#, .NET, EF Core',
      ),
      Programmer(
        name: 'Roberto Alves',
        experiences: 'C# e .NET',
      ),
      Programmer(
        name: 'Kauan Ribeiro',
        experiences: 'C# e PostgreSQL',
      ),
    ]);

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shimmer Effect')),
      body: loading == true
          ? ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  height: 0,
                ),
              ),
              itemBuilder: (context, index) => ItemSkeletonWidget(),
            )
          : RefreshIndicator(
              onRefresh: loadList,
              child: ListView.separated(
                itemCount: programmers.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1,
                    height: 0,
                  ),
                ),
                itemBuilder: (context, index) => ItemWidget(
                  programmer: programmers[index],
                ),
              ),
            ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key, required this.programmer}) : super(key: key);
  final Programmer programmer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            alignment: Alignment.center,
            child: Text(
              programmer.name[0],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                programmer.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 5),
              Text(
                programmer.experiences,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemSkeletonWidget extends StatelessWidget {
  const ItemSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Skeleton(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              alignment: Alignment.center,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Skeleton(
                child: Container(
                  height: 20,
                  width: 160,
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(height: 5),
              Skeleton(
                child: Container(
                  height: 20,
                  width: 180,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: child,
    );
  }
}
