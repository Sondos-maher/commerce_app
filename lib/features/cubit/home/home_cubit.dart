
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/helpers/network/api_const.dart';
import 'package:ecommerce_app/core/helpers/network/network_helper.dart';

import '../../model/banner_model.dart';
import '../../model/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  BannerModel bannerModel = BannerModel();
  ProductModel productModel = ProductModel();

  Future<void> fetchBanners() async {
    emit(HomeBannersLoadingState());

    try {
      final result = await NetworkHelper.getData(
        path: ApiConst.banners,
      );

      bannerModel = BannerModel.fromJson(result.data);

      if (bannerModel.statusCode == 200) {
        emit(
          HomeBannersSuccessState(
            bannerModel: bannerModel,
          ),
        );
      } else {
        emit(HomeBannersErrorState());
      }
    } catch (e) {
      emit(HomeBannersErrorState());
    }
  }

  Future<void> fetchProducts() async {
    emit(HomeProductsLoadingState());

    try {
      final result = await NetworkHelper.getData(
        path: ApiConst.products,
      );

      productModel = ProductModel.fromJson(result.data);

      if (productModel.statusCode == 200) {
        emit(HomeProductsSuccessState());
      } else {
        emit(HomeProductsErrorState());
      }
    } catch (e) {
      emit(HomeProductsErrorState());
    }
  }
}
