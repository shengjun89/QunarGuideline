
# 一、主要函数





## 1.颜色加深方法函数源码

#颜色加深

```
dark = (a,b)->
	if b-100>0 then b=100 and if b<0 then b=0 else
		originColor = new Color(a)
		newarr = originColor.toHslString().substr(4,14).split(",")
		newParseArr = []
		for i in newarr
			newParseArr.push(parseFloat(i))
		return new Color(h: newParseArr[0], s: newParseArr[1]*(1-b*0.01)*0.01, l: newParseArr[2]*0.01).toHexString()
```

Framer引入上面代码块，执行命令

`dark(color,number)`

`color`为当前原始颜色，支持HEX, RGB, RGBA, HSL， HSLA
`number`为要加深的程度  0-100区间整数

```
dark("blue",10)
dark("#28AFFA",20)
dark("rgb(255, 0, 102)",30)
dark("rgba(255, 0, 102, 1)",40)
dark("hsl(201, 95, 57)",50)
dark("hsla(201, 95, 57, 1)",60)
```





## 2.颜色减淡方法函数源码

#颜色变浅

```
light = (a,b)->
	if b-100>0 then b=100 and if b<0 then b=0 else
		originColor = new Color(a)
		newarr = originColor.toHslString().substr(4,14).split(",")
		newParseArr = []
		
		for i in newarr
			newParseArr.push(parseFloat(i))
		
		return new Color(h: newParseArr[0], s: newParseArr[1]*0.01, l: newParseArr[2]*(1+b*0.01)*0.01).toHexString()
```


Framer引入上面代码块，执行命令

`light(color,number)`

`color`为当前原始颜色，支持HEX, RGB, RGBA, HSL， HSLA
`number`为要加深的程度  0-100区间整数


```
light("blue",10)
light("#28AFFA",20)
light("rgb(255, 0, 102)",30)
light("rgba(255, 0, 102, 1)",40)
light("hsl(201, 95, 57)",50)
light("hsla(201, 95, 57, 1)",60)
```





# 二、如何使用

1. 点击调色盘编辑你想预览的色值

![](http://sjnk88.com/wp-content/uploads/2019/08/DLS01.gif)

2. 点击色卡编辑你想生成的梯度值，根据梯度值自动渲染品牌色的色卡范围，_light_值越高明度越高，_dark_值越高彩度越底

![](http://sjnk88.com/wp-content/uploads/2019/08/DLS02.gif)

3. 双击色卡可复制色值

4. `myDLSurl = "https://lc-OnsG2j7w.cn-n1.lcfile.com/0185410229137d5e7591.json" `是引入的样式表json文件，

5. 你可以按此json格式的要求去添加自己设计系统的投影、圆角、调色盘参数，利用在线json生成工具转成url引入替换



