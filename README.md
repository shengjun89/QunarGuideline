# 一、主要函数

## 1.颜色加深方法函数源码

#颜色加深
''dark = (a,b)->
	if b-100>0 then b==100 and if b<0 then b==0 else
		originColor = new Color(a)
		newarr = originColor.toHslString().substr(4,14).split(",")
		newParseArr = []
		for i in newarr
			newParseArr.push(parseFloat(i))
		return new Color(h: newParseArr[0], s: newParseArr[1]*(1-b*0.01)*0.01, l: newParseArr[2]*0.01).toHexString()''


#### .调用方法；引入上面代码块，执行命令

`dark(color,value)`

a 为当前原始颜色，HEX16进制色值或rgba
b为要加深的程度  最大为100，最小为0


## 2.颜色减淡方法函数源码

#颜色变浅

``


#### 调用方法；引入上面代码块，执行命令

`light(color,value)`

a 为当前原始颜色，HEX16进制色值或rgba
b为要加深的程度  最大为100，最小为0



# 二、工具使用

1，点击调色盘编辑你想预览的色值
2，点击色卡编辑你想生成的梯度值，根据梯度值自动渲染品牌色的色卡范围，_light_值越高明度越高，_dark_值越低彩度越底
3，双击色卡可复制色值
4，`myDLSurl = "https://lc-OnsG2j7w.cn-n1.lcfile.com/0185410229137d5e7591.json" `是引入的样式表json文件，
你可以按此json格式的要求去添加自己设计系统的投影、圆角、调色盘参数，利用在线json生成工具转成url引入替换
