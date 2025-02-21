import 'package:flutter/material.dart';
import 'package:mongo5a/models/group_model.dart';
import 'package:mongo5a/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class GroupsScreens extends StatefulWidget {
  const GroupsScreens({super.key});

  @override
  State<GroupsScreens> createState() => _GroupsScreensState();
}

class _GroupsScreensState extends State<GroupsScreens> {
  List<GroupModel> groups = [];

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchGroups() async {
    groups = await MongoService().getGroups();
    print('En fetch: $groups');
    setState(() {});
  }

  void _deleteGroup(mongo.ObjectId id) async {
    await MongoService().deleteGroup(id);
    _fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Mongo de grupos de rock'),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          var group = groups[index];
          return oneTile(group);
        },
      ),
    );
  }

  ListTile oneTile(GroupModel group) {
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.type),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const IconButton(onPressed: null, icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () => _deleteGroup(group.id),
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}