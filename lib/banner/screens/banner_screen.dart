import 'package:flutter/material.dart';
import 'package:o_kay_customer/constants/colors.dart';
import 'package:o_kay_customer/food_delivery/controllers/food_delivery_controller.dart';
import 'package:o_kay_customer/home_screen/widgets/restaurant_card.dart';
import 'package:o_kay_customer/models/menu.dart';
import 'package:o_kay_customer/models/shop.dart';
import 'package:o_kay_customer/models/voucher.dart';
import 'package:o_kay_customer/shop_details/screens/shop_details.dart';
import 'package:o_kay_customer/shop_details/widgets/ficon_button.dart';
import 'package:o_kay_customer/models/banner.dart' as model;
import 'package:o_kay_customer/voucher/controllers/voucher_controller.dart';
import 'package:o_kay_customer/widgets/custom_snackbar.dart';

class BannerScreen extends StatefulWidget {
  static const String routeName = '/banner-screen';
  final model.Banner banner;
  const BannerScreen({super.key, required this.banner});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  List<Shop> shops = [];
  Voucher? voucher;
  bool isVoucherUsed = true;
  FoodDeliveryController foodDeliveryController = FoodDeliveryController();

  getShopForBanner() async {
    for (int i = 0; i < widget.banner.shopListId.length; i++) {
      Shop? tempShop = await foodDeliveryController.fetchShopById(
        shopId: widget.banner.shopListId[i],
        context: context,
      );
      if (tempShop != null) {
        shops.add(tempShop);
      }
    }
    setState(() {});
  }

  getVoucher() async {
    if (widget.banner.voucherId != null &&
        widget.banner.voucherId!.isNotEmpty) {
      VoucherController voucherController = VoucherController();
      voucher = await voucherController.fetchVoucherById(
        voucherId: widget.banner.voucherId!,
      );
      isVoucherUsed = await voucherController.checkIfSavedVoucher(
          voucherId: widget.banner.voucherId!);
      setState(() {});
    }
  }

  getMenu(Shop shop) async {
    List<Menu> menu =
        await foodDeliveryController.fetchCategory(sellerUid: shop.uid);

    Navigator.pushNamed(
      context,
      ShopDetailScreen.routeName,
      arguments: ShopDetailScreen(shop: shop, menu: menu),
    );
  }

  saveVoucher(String voucherId) async {
    VoucherController voucherController = VoucherController();
    String? errorText =
        await voucherController.saveVoucher(voucherId: voucherId);
    if (errorText == null) {
      openSnackbar(context, 'Your voucher is saved to your voucher list',
          Color.fromARGB(255, 16, 2, 214));
      isVoucherUsed = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getShopForBanner();
    getVoucher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverLayoutBuilder(builder: (context, constaints) {
            final scrolled = constaints.scrollOffset <= 285;
            return SliverAppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              expandedHeight: widget.banner.voucherId == null ||
                      widget.banner.voucherId!.isEmpty
                  ? 250
                  : 350,
              collapsedHeight: 60,
              forceElevated: true,
              elevation: scrolled ? null : 0.5,
              pinned: true,
              leading: Center(
                child: FIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              title: scrolled
                  ? const SizedBox()
                  : Text(
                      widget.banner.description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Hero(
                      tag: widget.banner.imageUrl,
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.amber,
                        child: Image.network(
                          widget.banner.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey[200]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(1, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: Color.fromARGB(255, 16, 2, 214),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Text(
                                    'Campaign Info',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Read more',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 16, 2, 214),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color.fromARGB(255, 16, 2, 214),
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: widget.banner.voucherId == null ||
                                      widget.banner.voucherId!.isEmpty
                                  ? 0
                                  : 15),
                          widget.banner.voucherId == null ||
                                  widget.banner.voucherId!.isEmpty ||
                                  voucher == null
                              ? const SizedBox()
                              : Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border:
                                        Border.all(color: Colors.grey[200]!),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(1, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        width: 5,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 16, 2, 214),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  voucher!.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 16, 2, 214)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: isVoucherUsed
                                                    ? () {}
                                                    : () => saveVoucher(
                                                        voucher!.id),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: isVoucherUsed
                                                        ? Colors.grey[400]
                                                        : Color.fromARGB(
                                                            255, 16, 2, 214),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    isVoucherUsed
                                                        ? 'Code saved'
                                                        : 'Save code',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                              height: widget.banner.voucherId == null ||
                                      widget.banner.voucherId!.isEmpty
                                  ? 0
                                  : 25),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  Shop shop = shops[index];
                  return GestureDetector(
                    onTap: () => getMenu(shop),
                    child: RestaurantCard(shop: shop),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
