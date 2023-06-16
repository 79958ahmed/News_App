import 'package:abdulla_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/news_app/cubit/states.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:abdulla_mansour/shared/cubit/cubit.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
listener: (context, state){},
      builder: (context,state){
  var List = NewsCubit.get(context).business;
  return articleBuilder(List ,context);
      },
    );
  }
}
