library flutter_package_payview;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_package_payview/number_input/number_input.dart';
import 'package:flutter_package_payview/utils/colors.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:tobias/tobias.dart';
import 'package:flutter_package_payview/utils/tost.dart';
/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class PayView extends StatefulWidget{
  final double totalAmount;
  final double balance;
  final int hasPassWord;
  final int orderId;
  final Function(int) payConfirmAction;
  const PayView({Key key, this.totalAmount = 0.0,this.balance = 0.0,this.hasPassWord = 0,this.orderId = 0,this.payConfirmAction}) : super(key: key);
  @override
  _PayViewState createState() => _PayViewState();
}
class _PayViewState extends State<PayView> with SingleTickerProviderStateMixin{
  List<Map<String,dynamic>> payItems = [
    {'title':'支付宝','icon':'images/icon-zhifubao.png','isSelect':true},
    {'title':'微信支付','icon':'images/icon-weixinzhifu.png','isSelect':false},
    {'title':'余额支付','icon':'images/img-yue.png','isSelect':false}
  ];
  var payType = 1;
  AnimationController controller;
  Animation animation;
  double width = MediaQueryData.fromWindow(window).size.width;
  double rightValue = -MediaQueryData.fromWindow(window).size.width;
  bool autofocus = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = new Tween(begin: 0.0, end: width).animate(controller)
      ..addListener(() {
        //刷新state 这样动画才会执行
        setState(() {

        });
      });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
            height: 440,
            width: width,
            child:
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Column(
                  children: [
                    new Container(
                      child: new Stack(
                        children: [
                          new Center(
                            child: new Container(
                              padding:EdgeInsets.only(top: 10,bottom: 10),
                              child: new Text(
                                '支付方式',
                                style: new TextStyle(
                                    color: CommonColors.mainFontColor,
                                    fontSize: 15
                                ),
                              ),
                            ),
                          ),
                          new Positioned(
                              top: 10,
                              bottom: 10,
                              right: 25,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: new Image.asset(
                                  'images/order/X-gray.png',
                                  width: 15,
                                  height: 15,
                                ),
                              )
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: CommonColors.divisionLineColor,
                                  width: 1
                              )
                          )
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      margin: EdgeInsets.only(left: 10),
                      child: new Center(
                        child: Text(
                          '￥${widget.totalAmount}',
                          style: new TextStyle(
                              color: CommonColors.mainFontColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: CommonColors.divisionLineColor,
                                  width: 1
                              )
                          )
                      ),
                    ),
                    new Column(
                        children:List.generate(payItems.length, (index){
                          return _payItem(payItems[index],index);
                        })
                    ),
                  ],
                ),
                new GestureDetector(
                  onTap: () async{
                    if(payType == 5){
                      if(widget.hasPassWord == 0){
                        Toast.toast(context,msg: '您还未设置支付密码，请至标准版设置支付密码');
                      }else{
                        // 动画退出支付密码界面
                        _startAnimation();
                        // 自动唤起键盘
                        FocusScope.of(context).requestFocus(NumberInput.focusNode);
                      }
                    }else{
                      // 支付宝，微信支付
                      // showSimpleLoadingDialog(context: context);
                      // OrderPayModel orderPayModel = await RequestManager.orderDoNoPayOrder(
                      //     payType: payType,
                      //     orderID: widget.orderId
                      // );
                      // // 返回的base64加密字符中包含\n符号需要剔除掉，才能解析成功
                      // dismissDialog(context);
                      // if(orderPayModel != null){
                      //   if(payType == 1){
                      //     // 支付宝
                      //     _callAlipay(orderPayModel.payParams);
                      //   }else if(payType == 2){
                      //     // 微信
                      //     Map<String, dynamic> map = json.decode(EncryptionUtil.base64Decode(orderPayModel.payParams.replaceAll('\n', '')));
                      //     _callWXpay(map);
                      //   }
                      // }
                      Navigator.pop(context);
                    }
                  },
                  child: new Container(
                    margin: EdgeInsets.only(top: 8),
                    width: width,
                    color: CommonColors.mainColor,
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: new Text(
                      '确定',
                      style: new TextStyle(
                          color: CommonColors.white,
                          fontSize: 15
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
        ),
        Positioned(
            right:rightValue+animation.value,
            child: Container(
              height: 340,
              width: width,
              color: CommonColors.white,
              child: new Column(
                children:[
                  new Container(
                      child: new Stack(
                        children: [
                          new Center(
                            child: new Container(
                              padding:EdgeInsets.only(top: 10,bottom: 10),
                              child: new Text(
                                '输入支付密码',
                                style: new TextStyle(
                                    color: CommonColors.mainFontColor,
                                    fontSize: 17
                                ),
                              ),
                            ),
                          ),
                          new Positioned(
                              top: 10,
                              bottom: 10,
                              left: 25,
                              child: GestureDetector(
                                onTap: (){
                                  _startAnimation();
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                child: new Image.asset(
                                  'images/order/backArrow.png',
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.fill,
                                ),
                              )
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: CommonColors.divisionLineColor,
                                  width: 1
                              )
                          )
                      )
                  ),
                  new NumberInput(inputCompleteCallback:  (value) async{
                    // 余额支付逻辑
                    // showSimpleLoadingDialog(context: context);
                    // OrderPayModel orderPayModel = await RequestManager.orderDoNoPayOrder(
                    //     payType: payType,
                    //     orderID: widget.orderId
                    // );
                    // BaseModel baseModel = await RequestManager.orderBalancePay(
                    //     orderPayCode: orderPayModel.orderPayCode,
                    //     paymentPWD: base64.encode(utf8.encode(value))
                    // );
                    // dismissDialog(context);
                    // if(baseModel != null){
                    //   if(baseModel.code == 0){
                    //     // 发送通知刷新订单列表
                    //     Navigator.pop(context);
                    //     _updatePayOrderStatus();
                    //   }
                    // }
                  })
                ],
              ),
            )
        )

      ],
    );
  }
  void _callAlipay(String payInfo) async {
    print("The pay info is : " + payInfo);
    Map payResult = await aliPay(payInfo);
    if (payResult['resultStatus'] == "6001") {
      // 用户取消操作
      // ToastOk.show(msg: '取消支付');
    } else if (payResult['resultStatus'] == "9000") {
      // 支付成功
      _updatePayOrderStatus();
    }
  }
  void _callWXpay(Map<String, dynamic> map){
    fluwx.payWithWeChat(
        appId: map['appid'],
        partnerId: map['partnerid'],
        prepayId: map['prepayid'],
        packageValue: map['package'],
        nonceStr: map['noncestr'],
        timeStamp: int.parse(map['timestamp']),
        sign: map['sign']
    ).then((isSuccess){
      print("---》$isSuccess");
    });
    // 支付回调
    fluwx.weChatResponseEventHandler.listen((res) {
      if (res is fluwx.WeChatPaymentResponse) {
        // 支付成功
        if(res.errCode == 0){
          _updatePayOrderStatus();
        }else if(res.errCode == -2){
          // 用户取消操作
          print('取消支付操作');
          // ToastOk.show(msg: '取消支付');
        }
      }
    });
  }
  void _updatePayOrderStatus(){
    // 延迟刷新，后台需要3秒更新订单数据
    // Future.delayed(Duration(seconds: 4), () {
    //   RepairEvent.event.fire(OrderListLoadEvent());
    // });
    // // 订单详情
    // RepairEvent.event.fire(HiddenOrderDetailPayTool());
  }
  void _startAnimation(){
    if (animation.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
  Widget _payItem(Map<String,dynamic> itemDict,int index){
    return GestureDetector(
      onTap: (){
        if(index == 2 && widget.balance < widget.totalAmount){
          return;
        }
        // 1.支付宝 2.微信 5.余额
        setState(() {
          payItems.forEach((element) {
            element['isSelect'] = false;
          });
          itemDict['isSelect'] = true;
          if(index == 2){
            payType = 5;
          }else{
            payType = index+1;
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        height: 44,
        child: new Row(
          children: [
            new Container(
              margin: EdgeInsets.only(right: 10),
              child: new Image.asset(
                itemDict['icon'],
                width: 30,
                height: 30,
              ),
            ),
            index == 2 ? new Text(
              itemDict['title'],
              style: new TextStyle(
                  color: CommonColors.mainFontColor,
                  fontSize: 15
              ),
            ):
            new Expanded(
                child: new Text(
                  itemDict['title'],
                  style: new TextStyle(
                      color: CommonColors.mainFontColor,
                      fontSize: 15
                  ),
                )
            ),
            new Expanded(
                child: new Offstage(
                  offstage: index == 2 ? false:true,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new Text(
                      '￥${widget.balance}',
                      style: new TextStyle(
                          color: CommonColors.secondText,
                          fontSize: 13
                      ),
                    ),
                  ),
                )
            ),
            (index == 2 && widget.balance < widget.totalAmount)?
            new Container(
              margin: EdgeInsets.only(right: 15),
              child: Text(
                '余额不足',
                style: new TextStyle(
                    color: CommonColors.mainColor,
                    fontSize: 15
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: CommonColors.mainColor,
                      width: 1
                  )
              ),
            ):
            new Container(
              margin: EdgeInsets.only(right: 10),
              child: new Image.asset(
                itemDict['isSelect']?'images/order/btn-circle-act.png':'images/order/btn-circle-normal.png',
                width: 20,
                height: 20,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: CommonColors.divisionLineColor,
                    width: 1
                )
            )
        ),
      ),
    );
  }
}