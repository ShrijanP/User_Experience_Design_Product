// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_assignment/features/food_detail_page/presentation/screen/food_detail_view.dart';

// import '../../../review/presentation/providers/review_product_provider.dart';
// import '../../../shared/constants/size_config.dart';
// import '../../../shared/utils/config.dart';
// import '../providers/category_product_state_providers.dart';
// import '../providers/state/category_product_state.dart';

// class CategoryProductScreen extends ConsumerStatefulWidget {
//   static const String routeName = 'CategoryProductScreen';
//   final String? categoryId;
//   final String? categoryName;

//   const CategoryProductScreen(
//       {Key? key, required this.categoryId, required this.categoryName})
//       : super(key: key);

//   @override
//   ConsumerState<CategoryProductScreen> createState() =>
//       _CategoryProductScreenState();
// }

// class _CategoryProductScreenState extends ConsumerState<CategoryProductScreen> {
//   final scrollController = ScrollController();
//   final TextEditingController searchController = TextEditingController();
//   bool isSearchActive = false;
//   Timer? _debounce;

//   @override
//   void initState() {
//     super.initState();
//     print("WIDGET CATEGORY ID::${widget.categoryId}");
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(categoryProviderStateNotifierProvider);

//     ref.listen(
//       categoryProviderStateNotifierProvider.select((value) => value),
//       ((CategoryProductState? previous, CategoryProductState next) {
//         if (next.state == CategoryProductConcreteState.fetchedAllProducts) {
//           if (next.message.isNotEmpty) {}
//         }
//       }),
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.categoryName.toString()),
//       ),
//       body: state.state == CategoryProductConcreteState.loading
//           ? const Center(child: CircularProgressIndicator())
//           : state.hasData
//               ? _buildBody(state)
//               : _buildBody(state),
//     );
//   }

//   Widget _buildBody(CategoryProductState state) {
//     return state.state == CategoryProductConcreteState.loading
//         ? const Center(child: CircularProgressIndicator())
//         : state.productList.isEmpty
//             ? const Center(child: Text("No Product Found"))
//             : Column(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: SizedBox(
//                           child: GridView.builder(
//                             physics: const ScrollPhysics(),
//                             shrinkWrap: true,
//                             gridDelegate:
//                                 const SliverGridDelegateWithMaxCrossAxisExtent(
//                               maxCrossAxisExtent: 200,
//                               childAspectRatio: 0.61,
//                               mainAxisSpacing: 20,
//                               crossAxisSpacing: 7,
//                             ),
//                             scrollDirection: Axis.vertical,
//                             itemCount: state.productList.length >= 10
//                                 ? 10
//                                 : state.productList.length,
//                             itemBuilder: (context, index) {
//                               var food = state.productList[index];
//                               return Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       ref
//                                           .watch(getReviewStateNotifierProvider
//                                               .notifier)
//                                           .getReview(food.id);
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   FoodDetailView(food: food)));
//                                     },
//                                     child: Container(
//                                       margin: EdgeInsets.fromLTRB(
//                                         SizeConfig.screenWidth! / 34.25,
//                                         SizeConfig.screenHeight! / 170.75,
//                                         SizeConfig.screenWidth! / 41.1,
//                                         SizeConfig.screenHeight! / 170.75,
//                                       ),
//                                       height: SizeConfig.screenHeight! / 2.73,
//                                       width: SizeConfig.screenWidth! / 2.055,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           boxShadow: []),
//                                       child: Stack(
//                                         fit: StackFit.expand,
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             child: food.images.isNotEmpty
//                                                 ? Image.network(
//                                                     "${AppConfigs.imageUrl}${food.images[0]}",
//                                                     fit: BoxFit.cover,
//                                                     loadingBuilder: (BuildContext
//                                                             context,
//                                                         Widget child,
//                                                         ImageChunkEvent?
//                                                             loadingProgress) {
//                                                       if (loadingProgress ==
//                                                           null) return child;
//                                                       return Center(
//                                                         child:
//                                                             CircularProgressIndicator(
//                                                           value: loadingProgress
//                                                                       .expectedTotalBytes !=
//                                                                   null
//                                                               ? loadingProgress
//                                                                       .cumulativeBytesLoaded /
//                                                                   loadingProgress
//                                                                       .expectedTotalBytes!
//                                                               : null,
//                                                         ),
//                                                       );
//                                                     },
//                                                     errorBuilder:
//                                                         (BuildContext context,
//                                                             Object exception,
//                                                             StackTrace?
//                                                                 stackTrace) {
//                                                       return Image.network(
//                                                         "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg",
//                                                         fit: BoxFit.cover,
//                                                       );
//                                                     },
//                                                   )
//                                                 : Image.network(
//                                                     "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg",
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   Colors.black.withOpacity(0.4),
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                           ),
//                                           Positioned(
//                                               left: SizeConfig.screenWidth! /
//                                                   34.25,
//                                               bottom: SizeConfig.screenHeight! /
//                                                   45.54,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceEvenly,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(food.name,
//                                                       style: TextStyle(
//                                                           fontSize: SizeConfig
//                                                                   .screenHeight! /
//                                                               50.15,
//                                                           color: Colors.white)),
//                                                   Row(
//                                                     children: [
//                                                       const Icon(Icons.fastfood,
//                                                           color: Colors.white),
//                                                       Text(
//                                                           " ${food.calorie_count.toString()}",
//                                                           style: TextStyle(
//                                                               fontSize: SizeConfig
//                                                                       .screenHeight! /
//                                                                   60.79,
//                                                               color: Colors
//                                                                   .white)),
//                                                     ],
//                                                   ),
//                                                   Text("Rs. ${food.price}",
//                                                       style: TextStyle(
//                                                           fontSize: SizeConfig
//                                                                   .screenHeight! /
//                                                               60.95,
//                                                           color: Colors.white))
//                                                 ],
//                                               )),
//                                           Positioned(
//                                               top: SizeConfig.screenHeight! /
//                                                   68.3,
//                                               right: SizeConfig.screenWidth! /
//                                                   41.1,
//                                               child: const Icon(Icons.favorite,
//                                                   color: Colors.white))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         )),
//                   ),
//                   if (state.state == CategoryProductConcreteState.fetchingMore)
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 16.0),
//                       child: CircularProgressIndicator(),
//                     ),
//                 ],
//               );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/food_detail_page/presentation/screen/food_detail_view.dart';

import '../../../review/presentation/providers/review_product_provider.dart';
import '../../../shared/constants/size_config.dart';
import '../../../shared/utils/config.dart';
import '../providers/category_product_state_providers.dart';
import '../providers/state/category_product_state.dart';

class CategoryProductScreen extends ConsumerStatefulWidget {
  static const String routeName = 'CategoryProductScreen';
  final String? categoryId;
  final String? categoryName;

  const CategoryProductScreen(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  ConsumerState<CategoryProductScreen> createState() =>
      _CategoryProductScreenState();
}

class _CategoryProductScreenState extends ConsumerState<CategoryProductScreen> {
  final scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    print("WIDGET CATEGORY ID::${widget.categoryId}");
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryProviderStateNotifierProvider);

    ref.listen(
      categoryProviderStateNotifierProvider.select((value) => value),
      ((CategoryProductState? previous, CategoryProductState next) {
        if (next.state == CategoryProductConcreteState.fetchedAllProducts) {
          if (next.message.isNotEmpty) {}
        }
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName.toString()),
      ),
      body: state.state == CategoryProductConcreteState.loading
          ? const Center(child: CircularProgressIndicator())
          : state.hasData
              ? _buildBody(state)
              : _buildBody(state),
    );
  }

  Widget _buildBody(CategoryProductState state) {
    return state.state == CategoryProductConcreteState.loading
        ? const Center(child: CircularProgressIndicator())
        : state.productList.isEmpty
            ? const Center(child: Text("No Product Found"))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.61,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 7,
                        ),
                        itemCount: state.productList.length >= 10
                            ? 10
                            : state.productList.length,
                        itemBuilder: (context, index) {
                          var food = state.productList[index];
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .watch(
                                      getReviewStateNotifierProvider.notifier)
                                  .getReview(food.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FoodDetailView(food: food)));
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                SizeConfig.screenWidth! / 34.25,
                                SizeConfig.screenHeight! / 170.75,
                                SizeConfig.screenWidth! / 41.1,
                                SizeConfig.screenHeight! / 170.75,
                              ),
                              height: SizeConfig.screenHeight! / 2.73,
                              width: SizeConfig.screenWidth! / 2.055,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [],
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: food.images.isNotEmpty
                                        ? Image.network(
                                            "${AppConfigs.imageUrl}${food.images[0]}",
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Image.network(
                                                "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg",
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.network(
                                            "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  Positioned(
                                    left: SizeConfig.screenWidth! / 34.25,
                                    bottom: SizeConfig.screenHeight! / 45.54,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(food.name,
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.screenHeight! /
                                                        50.15,
                                                color: Colors.white)),
                                        Row(
                                          children: [
                                            const Icon(Icons.fastfood,
                                                color: Colors.white),
                                            Text(
                                                " ${food.calorie_count.toString()}",
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .screenHeight! /
                                                        60.79,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        Text("Rs. ${food.price}",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.screenHeight! /
                                                        60.95,
                                                color: Colors.white))
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: SizeConfig.screenHeight! / 68.3,
                                    right: SizeConfig.screenWidth! / 41.1,
                                    child: const Icon(Icons.favorite,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (state.state ==
                        CategoryProductConcreteState.fetchingMore)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              );
  }
}
