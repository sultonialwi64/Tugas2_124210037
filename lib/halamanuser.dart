import 'package:flutter/material.dart';
import 'halamandetail.dart';
import 'usermodel.dart';
import 'apidatasource.dart';

class HalamanUsers extends StatelessWidget {
  const HalamanUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Users"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: ApiDataSource.instance.loadUsers(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Text("Ada Error.");
            }
            if(snapshot.hasData){
              UsersModel users = UsersModel.fromJson(snapshot.data!);
              return ListView.builder(
                  itemCount: users.data!.length,
                  itemBuilder: (context, index){
                    var user = users.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(user.avatar!),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text('${user.email}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HalamanDetail(id: user.id!),
                          ),
                        );
                      },
                    );
                  }
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}