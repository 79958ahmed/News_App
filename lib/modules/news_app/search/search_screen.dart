import 'package:abdulla_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/news_app/cubit/states.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
listener: (context, state) {},
      builder: (context,state)
      {
        var List = NewsCubit.get(context).search;
  return Scaffold(
    appBar: AppBar(),
    body:Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: dfaultFormfield(
            controller:searchController,
            type:TextInputType.text,
            onChange: (value)
            {
NewsCubit.get(context).getSearch(value);
            },
            validate:(String value)
            {
              if (value.isEmpty)
              {
                return 'search must not be empty';
              }
              return null;
            },
            label:'Search',
            prefix: Icons.search,
          ),
        ),
        Expanded(child: articleBuilder(List, context ,isSearch: true,)),
      ],
    ),
  );
      },

    );
  }
}
