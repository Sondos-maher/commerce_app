import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/post_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  List<PostModel> posts = [];

  Future<void> fetchPosts() async {
    emit(PostsLoading());
    try {
      final response = await Dio(
        BaseOptions(headers: {"Content-Type": "application/json"}),
      ).get("https://dummyjson.com/posts");

      List apiList = response.data["posts"];
      posts = apiList.map((e) => PostModel.fromJson(e)).toList();
      emit(PostsSuccess());
    } catch (e) {
      emit(PostsError());
      print(e);
    }
  }
}