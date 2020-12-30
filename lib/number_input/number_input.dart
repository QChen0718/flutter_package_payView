import 'package:flutter_package_payview/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
enum InputType {
  password,
  number,
}
class NumberInput extends StatefulWidget{
  final int passWordCount;
  final InputType inputType;
  final Function(String) inputCompleteCallback;
  // 设置焦点管理
  static FocusNode focusNode = FocusNode();
  const NumberInput({Key key, this.passWordCount = 6, this.inputType = InputType.password, this.inputCompleteCallback}) : super(key: key);
  @override
  _NumberInputState createState() => _NumberInputState();
}
class _NumberInputState extends State<NumberInput>{
  TextEditingController passwordTextEditingController = TextEditingController();
  String inputStr = '';
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Stack(
      children: [
        new Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.passWordCount, (index){
              return new Expanded(
                flex: 1,
                child: Container(
                  // width: (Adapt.screenW()-42)/6,
                  padding: EdgeInsets.only(top: 15,bottom: 15),
                  // child: new Center(
                  child: new Text(
                    getIndexStr(index),
                    style: new TextStyle(
                        color: CommonColors.mainFontColor
                    ),
                    textAlign: TextAlign.center,
                    // ),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          right: (index<widget.passWordCount-1)?BorderSide(
                              color: CommonColors.divisionLineColor,
                              width: 1
                          ):BorderSide(
                              color: CommonColors.clearColor,
                              width: 0
                          )
                      )
                  ),
                ),
              );
            }),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: CommonColors.divisionLineColor,
                  width: 1
              )
          ),
        ),
        new Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 10),
            child: new TextField(
              controller: passwordTextEditingController,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              cursorWidth: 0,
              focusNode: NumberInput.focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.passWordCount)
              ],
              style: TextStyle(
                  color: CommonColors.clearColor
              ),
              onChanged: (value){
                setState(() {
                  inputStr = value;
                });
                //回调出输入内容
                if(inputStr.length == widget.passWordCount){
                  widget.inputCompleteCallback(value);
                }
                print('value=${value}');
              },
            )
        )
      ],
    );
  }
  // 获取对应的值进行赋值
  String getIndexStr(int index) {
    if (inputStr == null || inputStr.isEmpty) return "";
    if (inputStr.length > index) {
      if (widget.inputType == InputType.password) {
        return "●";
      } else {
        return inputStr[index];
      }
    } else {
      return "";
    }
  }
}