import 'package:flutter/cupertino.dart';
import 'package:flutter_sankalan/bloc/home_bloc.dart';

class Provider extends InheritedWidget {
  final HomeBloc homeBloc;

  Provider({Key key, Widget child, this.homeBloc}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static HomeBloc getHomeBloc(BuildContext context) => (context.inheritFromWidgetOfExactType(Provider) as Provider).homeBloc;
}
