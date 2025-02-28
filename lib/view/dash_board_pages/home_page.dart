import 'package:ecommerce_task/utils/app_constant.dart';
import 'package:ecommerce_task/utils/ui_helper.dart';
import 'package:ecommerce_task/view/product_detail_page.dart';
import 'package:ecommerce_task/view_model/blocs/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  MediaQueryData? mqData;
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ViewProductEvent());
  }

  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    var searchController = TextEditingController();


    return Scaffold(
      backgroundColor: Color(0xffeff1f3),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: mqData!.size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 14, left: 14),
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      'Home page',
                      style: mTextStyle22(mFontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    searchBar(
                        controller: searchController,
                        hintText: 'Search product..')
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: mqData!.size.height * 0.67,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      spacing: 10,
                      children: [
                        Text("Categories",
                            style: mTextStyle16(mFontWeight: FontWeight.bold)),
                        Spacer(),
                        Text(
                          'see all',
                          style: mTextStyle14(mColor: Color(0xff8f959a)),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: UiHelper.darkGreyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: AppConstant.categoriesList.length,
                          itemBuilder: (_, index) {
                            var eachData = AppConstant.categoriesList[index];
                            return categoryIcon(
                                icon: eachData['icon'],
                                title: eachData['name']);
                          }),
                    ),

                    SizedBox(height: 20),
                    Text("Flash Sale",
                        style: mTextStyle16(mFontWeight: FontWeight.bold)),


                    /// Products Section
                    ///
                    BlocBuilder<ProductBloc,ProductState>(
                        builder: (_,state){
                          if(state is ProductLoadingState){
                            return Center(child: CircularProgressIndicator(),);
                          }else if(state is ProductErrorState){
                            return Center(child: Text(state.errorMsg),);
                          }else if(state is ProductLoadedState){
                            return  SizedBox(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.productModel.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2/3.4,
                                      crossAxisSpacing: 5,
                                    mainAxisSpacing: 2,

                                  ),
                                  itemBuilder: (_,index){
                                    var eachData = state.productModel[index];
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailPage(productData: state.productModel[index])));
                                      },
                                      child: productsCard(
                                        eachData.title!,
                                        eachData.price!.toString(),
                                        eachData.image!),
                                    );
                                  }),
                            );
                          }
                          return Container();
                        })

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget categoryIcon({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(title, style: mTextStyle14()),
        ],
      ),
    );
  }

  Widget productsCard(
      String title, String price, String imagePath) {
    return Container(
      height: mqData!.size.height*0.230,
      width: mqData!.size.width*0.180,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 150,
              height: 140,
              decoration: BoxDecoration(
                color: UiHelper.darkGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Image.network(imagePath,
                      height: 90, width: 90, fit: BoxFit.cover))),
          const SizedBox(
            height: 10,
          ),
          Text(title, style: mTextStyle12(mFontWeight: FontWeight.w500),softWrap: true,),
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Row(
              children: [
                Text("\$${price}", style: mTextStyle14(mFontWeight: FontWeight.bold)),
                SizedBox(width: 5),

                Spacer(),
                Image.asset(
                  'assets/images/heart.png',
                  height: 24,
                  width: 24,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar(
      {required TextEditingController controller, required String hintText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: UiHelper.darkGreyColor,
          prefixIcon: Icon(Icons.search),
          hintText: hintText,
          hintStyle: mTextStyle12(mColor: Color(0xff8f959a)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15))),
    );
  }
}
