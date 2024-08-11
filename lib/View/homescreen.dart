import 'package:flutter/material.dart';
import 'package:mvvm_/Data/Response/status.dart';
import 'package:mvvm_/Models/movielistmodel.dart';
import 'package:mvvm_/Utils/Routes/routesname.dart';
import 'package:mvvm_/Utils/generalutils.dart';
import 'package:mvvm_/ViewModel/homeviewmodel.dart';
import 'package:mvvm_/ViewModel/userviewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Movies"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                onTap: () {
                  userPreference.removeUser().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  }).onError((error, stackTrace) {
                    Utils.flushBarErrorMessages("LogOut Failed", context);
                  });
                },
                child: Center(child: Text("Logout"))),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => homeViewModel,
          child: Consumer<HomeViewModel>(builder: (context, value, child) {
            switch (value.movielistresponse.status) {
              case Status.Loading:
                return Center(child: CircularProgressIndicator());
              case Status.Error:
                return Text(value.movielistresponse.message.toString());
              case Status.Completed:
                return ListView.builder(
                    itemCount: value.movielistresponse.data!.movies!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(value.movielistresponse.data!.movies![index].posterurl.toString(),
                          fit: BoxFit.cover,
                          height: 50,
                          width: 40,
                          errorBuilder: (context ,error,stack){
                            return Icon(Icons.error , color: Colors.red,);
                          }),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.avgRating(value.movielistresponse.data!.movies![index].ratings!).toStringAsFixed(1)),
                              Icon(Icons.star,color: Colors.yellow,)
                            ],
                          ),
                          title: Text(value
                              .movielistresponse.data!.movies![index].title
                              .toString()),
                          subtitle: Text(value
                              .movielistresponse.data!.movies![index].year
                              .toString()),
                        ),
                      );
                    });
              default:
                return Text("App Under Maintainance");
            }
          }),
        ));
  }
}
