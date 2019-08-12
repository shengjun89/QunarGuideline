{input} = require "Input/input"
# Info 
Framer.Info =
	title: "dashboard"
	author: "snow_sheng"
	twitter: "奔跑の刷牙君"
	description: "DLS"

whiteSpaceSm = 16
paletteAmount = 12
#引入json资源
# 
# colorUrl = "framer/json/ColorConfigure.json"
# color = JSON.parse Utils.domLoadDataSync colorUrl
# # print color
# fontUrl = "framer/json/FontSizeConfigure.json"
# font = JSON.parse Utils.domLoadDataSync fontUrl
# # print font
# # ShadowConfigure
# shadowUrl = "framer/json/ShadowConfigure.json"
# shadow = JSON.parse Utils.domLoadDataSync shadowUrl
# # print font	
# radiusUrl = "framer/json/BorderRadiusConfigure.json"
# radius = JSON.parse Utils.domLoadDataSync radiusUrl
# 
# alphaUrl = "framer/json/AlphaConfigure.json"
# alpha = JSON.parse Utils.domLoadDataSync alphaUrl


primarycolor = "#0FCAE2"

myDLSurl = "https://lc-OnsG2j7w.cn-n1.lcfile.com/75481bf830d3a752c1fd.json"
# myDLSurl = "https://lc-OnsG2j7w.cn-n1.lcfile.com/b454df0c4016367db7d4.json"


TxtArr = []
TxtArrReverse = []
colorResultArr = []
colorHexResultArr = []
alphaNameArr = []
alphaValueArr = []
alphaGroup = []

# colorResultArr = []
# colorHexResultArr = []
# colorHexResultReverse = []
# colorResultArrDark = []

#颜色加深
dark = (a,b)->
	if b-100>0 then b=100 and if b<0 then b=0 else
		originColor = new Color(a)
		newarr = originColor.toHslString().substr(4,14).split(",")
		newParseArr = []
		for i in newarr
			newParseArr.push(parseFloat(i))
		return new Color(h: newParseArr[0], s: newParseArr[1]*(1-b*0.01)*0.01, l: newParseArr[2]*0.01).toHexString()

#颜色变浅
light = (a,b)->
	if b-100>0 then b=100 and if b<0 then b=0 else
		originColor = new Color(a)
		newarr = originColor.toHslString().substr(4,14).split(",")
		newParseArr = []
		
		for i in newarr
			newParseArr.push(parseFloat(i))
		
		return new Color(h: newParseArr[0], s: newParseArr[1]*0.01, l: newParseArr[2]*(1+b*0.01)*0.01).toHexString()

avatar.onClick (event, layer) ->
	window.location = "https://github.com/shengjun89/QunarGuideline"		




sqrwidth = (Screen.width-whiteSpaceSm*2)/5
scroll = new ScrollComponent
	size: Screen.size
	parent: main
scroll.scrollHorizontal = false

#为元素添加双击事件，复制色值
addClickEvent = (a,arr3)->
	a.onDoubleClick (event, layer) ->
		showValue.visible = true
		mask.visible = true
		sheet02.animate "stateA",
			curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
			time: 0.2
		showValue.value = arr3[@index]
		DoneBtn.visible = false
		sheetTxt01.text = "当前颜色"
		sheetTxt01.x = Align.center()
		

#为元素添加鼠标经过事件，悬停显示值		
addMouseEvent = (a,arr1,arr2,arr3,layout)->
	a.onMouseOver (event, layer) ->
		for i in [0...arr1.length]
			arr1[i].children[0].text = arr2[i]
			
		@children[0].text = arr3[@index]
		@children[0].x = layout

	a.onMouseOut (event, layer) ->
		for i in [0...arr1.length]
			arr1[i].children[0].text = arr2[i]
			arr1[i].children[0].x = layout


# print (new Color(primarycolor)).toHslString()
# print (new Color(dark(primarycolor,10))).toHslString()
# print (new Color(light(primarycolor,10))).toHslString()

# print dark("rgba(241,213,123,0.2)",10)
# print dark("#FF0000",32)


#替换json路径，色卡数量并且渲染样式
	
creatPalette = (paletteAmount,primarycolor) ->
	Utils.domLoadJSON myDLSurl, (error, DLSDataApi) ->
		col = 0
		row = 0
		colorResultArr = []
		colorHexResultArr = []
		colorHexResultReverse = []
		colorResultArrDark = []

			
		fstScreen = new Layer
			parent: scroll.content
			y: 0
			width: Screen.width
			backgroundColor: null
				
		primarybox = new Layer
			parent: fstScreen
			x: whiteSpaceSm
			y: 12
			width: sqrwidth*2
			height: sqrwidth*2
			backgroundColor: primarycolor
			
		primarytxt = new TextLayer
			parent: primarybox
			fontSize: 12
			point: Align.center()
			color: "#FFF"
			text: "primary"
			backgroundColor: "rgba(0,0,0,0.2)"
					
		primarybox.onMouseOver (event, layer) ->
			@children[0].text = primarycolor
			@children[0].x = Align.center	
		primarybox.onMouseOut (event, layer) ->
			@children[0].text = "primary"
			@children[0].x = Align.center
			
		alphaSection = new Layer
			parent: fstScreen
			width: sqrwidth*3
			x: sqrwidth*2+whiteSpaceSm
			y: 12
			backgroundColor: null
		
		
		
		
		# print primarycolor
		for i in [1...paletteAmount+1]
				value = parseInt(100*i/paletteAmount)
				lightTxt = "light"+value
				colorResultArr.push(value)
				TxtArr.push(lightTxt)	
					
		for i in TxtArr.reverse()
			TxtArrReverse.push(i)
		
		for i in [1...paletteAmount+1]
			value = parseInt(100*i/paletteAmount)
			darkTxt = "dark"+value
			colorResultArrDark.push(value)
			TxtArrReverse.push(darkTxt)
			
		for i in [0...paletteAmount]
			colorHexResultArr.push(new Color(light(primarycolor,colorResultArr[i])).toHexString())
						
		for i in colorHexResultArr.reverse()	
			colorHexResultReverse.push(i)
		
		for i in [0...colorHexResultReverse.length]
			colorHexResultReverse.push(new Color(dark(primarycolor,colorResultArrDark[i])).toHexString())
		
			
		for i in [0...paletteAmount*2]	
			if i%3==0
				row = 0
				col++	
			palette = new Layer
				parent: alphaSection
				width: sqrwidth
				height: sqrwidth
				x: sqrwidth*row
				y: sqrwidth*col-sqrwidth
				backgroundColor: colorHexResultReverse[i]
		# 					opacity: alphaValueArr[i-1]
				borderWidth: 0.5
				borderColor: "#EEEEEE"
			
			paletteTxt = new TextLayer
				parent: palette
				fontSize: 12
				color: "#FFF"
				x: Align.center
				y: Align.center
				text: TxtArrReverse[i]
				backgroundColor: "rgba(0,0,0,0.2)"
			row++
			alphaGroup.push(palette)	
			addClickEvent(palette,colorHexResultReverse)
# 			addMouseEvent(palette,alphaGroup,TxtArrReverse,colorHexResultReverse,Align.center())
		
		currentRow = col+1
		
		#品牌色盘
					
		primarybox.height = sqrwidth*(currentRow-1)
		alphaSection.height = sqrwidth*(currentRow-1)
		alphaSection.y = 12
# 		print TxtArrReverse.length
creatPalette(paletteAmount,primarycolor)


ResetJson = (jsonUrl,paletteAmount,primarycolor) ->
	Utils.domLoadJSON jsonUrl, (error, DLSDataApi) ->
# 		for a in DLSDataApi.palette
# 			paletteAmount = a
		renderStytle = ()->
			col = 0
			for i in [0...paletteAmount*2]	
				if i%3==0
					row = 0
					col++	
					
			currentRow = col+1
			#调色盘

			paletteGroup = []
			TxtArr = []
			TxtArrReverse = []	
			colorNameArr = []
			colorValueArr = []
			removePrimaryResult = []
			removePrimaryValue = []
						
					
			srdScreen = new Layer
				width: Screen.height
				backgroundColor: null
				parent: scroll.content
							
			for color in DLSDataApi.colorData
			# 	print color.value
				colorNameArr.push(color.name)
				colorValueArr.push(color.value)
			
			paletteSection = new Layer
				width: Screen.width-2*whiteSpaceSm
				parent: srdScreen
				x: whiteSpaceSm
				y: sqrwidth*(currentRow-1)+12
				backgroundColor: null
							
			
			#移除primary
			for i in colorNameArr.splice(1,colorNameArr.length)
				removePrimaryResult.push(i)
			for i in colorValueArr.splice(1,colorValueArr.length)	
				removePrimaryValue.push(i)
# 			print removePrimaryResult
			for i in [0...removePrimaryResult.length]
				if i%5==0
					row = 0
					col++	
					
				palettecolor = new Layer
					z: 2
					parent: paletteSection
					width: sqrwidth
					height: sqrwidth
					borderWidth: 0.5
					borderColor: "#EEEEEE"
					x: sqrwidth*row
					y: sqrwidth*(col-1)-(currentRow-1)*sqrwidth
					backgroundColor: removePrimaryValue[i]
				row++		
				
				paletteTxt = new TextLayer
					parent: palettecolor
					fontSize: 12
					color: "#FFF"
					x: Align.center
					y: Align.center
					text: removePrimaryResult[i]
					backgroundColor: "rgba(0,0,0,0.2)"
			# 		shadowY: 1
			# 		shadowBlur: 4
			# 		shadowColor: "#616161"
				paletteGroup.push(palettecolor)
				addClickEvent(palettecolor,removePrimaryValue)
				addMouseEvent(palettecolor,paletteGroup,removePrimaryResult,removePrimaryValue,Align.center())
							
			paletteSection.height = paletteSection.contentFrame().height
			
			
				
			#渐变色
			
			gradiantNameArr = []
			gradiantStartArr = []
			gradiantEndArr = []
			gradiantGroup = []
			gradiantValueArr = []
			gradiantSection = new Layer
				parent: srdScreen
				width: Screen.width-2*whiteSpaceSm
				y: paletteSection.y+paletteSection.height
				x: whiteSpaceSm
			for gradiant in DLSDataApi.gradiantData
				gradiantNameArr.push(gradiant.name)
				gradiantStartArr.push(gradiant.value.start)
				gradiantEndArr.push(gradiant.value.end)
				gradiantValueArr.push(gradiant.value)
			
			
			
			# 渐变色
			for i in [0...DLSDataApi.gradiantData.length]
				gradiantLayer = new Layer
					parent: gradiantSection
					width: Screen.width-2*whiteSpaceSm
					height: sqrwidth
					x: 0
					y: sqrwidth*i
				gradiantLayer.gradient =
					start: gradiantStartArr[i]
					end: gradiantEndArr[i]
					angle: 90
				gradiantTxt = new TextLayer
					parent: gradiantLayer
					fontSize: 12
					color: "#FFF"
					backgroundColor: "rgba(0,0,0,0.2)"
					y: Align.center()
					x: 16
					text: gradiantNameArr[i]
				gradiantEnd = new TextLayer
					parent: gradiantLayer
					fontSize: 12
					color: "#FFF"
					backgroundColor: "rgba(0,0,0,0.2)"
					y: Align.center()
					x: Align.right(-whiteSpaceSm)
					text: ""	
				gradiantGroup.push(gradiantLayer)	
				addMouseEvent(gradiantLayer,gradiantGroup,gradiantNameArr,gradiantStartArr,Align.left(whiteSpaceSm))
				
				
				gradiantLayer.onMouseOver (event, layer) ->
			# 		print @index
					@children[1].text = gradiantEndArr[@index]
					@children[1].x = Align.right(-whiteSpaceSm)
				gradiantLayer.onMouseOut (event, layer) ->
					for i in [0...gradiantGroup.length]
						gradiantGroup[i].children[1].text = ""
						gradiantGroup[i].children[1].x = Align.right(-whiteSpaceSm)
						
			gradiantSection.height = gradiantSection.contentFrame().height
			
			
			#圆角
			radiusNameArr=[]
			radiusValueArr=[]
			radiusGroup = []
			
			radiusSection = new Layer
				parent: srdScreen
				width: Screen.width-whiteSpaceSm*2
				y: gradiantSection.y+gradiantSection.height+32
				x: whiteSpaceSm
				height: 48
				backgroundColor: null
			
			for i in DLSDataApi.radiusData
				radiusNameArr.push(i.name)
				radiusValueArr.push(i.value)
			
			for i in [0...DLSDataApi.radiusData.length]
				radius = new Layer
					parent: radiusSection
					width: (Screen.width-whiteSpaceSm*2-24)/DLSDataApi.radiusData.length
					x: (Screen.width-whiteSpaceSm*2+8)*i/DLSDataApi.radiusData.length
					height: 48
					y: 0
					borderRadius: radiusValueArr[i]
					backgroundColor: primarycolor
					borderWidth: 1
					borderColor: dark(primarycolor,10)
				radiusGroup.push(radius)	
					
					
				radiusTxt = new TextLayer
					parent: radius
					fontSize: 12
					fontWeight: "bold"
					color: "#FFF"
					x: Align.center()
					y: Align.center()
					text: radiusNameArr[i]
			# 		textAlign: center
				addMouseEvent(radius,radiusGroup,radiusNameArr,radiusValueArr,Align.center())
				
			#投影	
			shadowNameArr = []
			shadowValueArr = []
			shadowYArr = []
			shadowBlurArr = []
			shadowGroup = []
			
			shadowBox = new Layer
				parent: srdScreen
				y: radiusSection.y+radiusSection.height+32
				x: whiteSpaceSm
				width: Screen.width-whiteSpaceSm*2
				backgroundColor: null
			
			for i in DLSDataApi.shadowData
				shadowNameArr.push(i.name)
				shadowValueArr.push(i.value)
				shadowYArr.push(i.value.y)
				shadowBlurArr.push(i.value.blur)
				
			for i in [0...DLSDataApi.shadowData.length]
				shadow = new Layer
					parent: shadowBox
					y: 0
					x: (Screen.width-whiteSpaceSm*2+8)*i/DLSDataApi.shadowData.length
					width: (shadowBox.width-24)/DLSDataApi.shadowData.length
					height: 160
					backgroundColor: "#FFF"
					shadow1:
						y : shadowYArr[i]
						blur : shadowBlurArr[i]
						color: "rgba(0,0,0,0.08)"
						
				shadowTxtA = new TextLayer
					parent: shadow
					text: shadowNameArr[i]
					fontSize: 12
					color: "#212121"
					point: Align.center()		
			# 		backgroundColor: 
			
				shadowTxtB = new TextLayer
					parent: shadow
					text: ""
					fontSize: 12
					color: "#212121"
					point: Align.center(12)	
			
				shadow.onMouseOver (event, layer) ->
					@children[0].text = "y:"+shadowYArr[@index]
					@children[1].text = "blur:"+shadowBlurArr[@index]
					@children[0].x = Align.center()
					@children[1].x = Align.center()
					@children[0].animate
						y: Align.center(-6)
						options:
							time:0.14
					@children[1].y = Align.center(12)
					
				shadow.onMouseOut (event, layer) ->	
					@children[0].text = shadowNameArr[@index]
					@children[1].text = ""
					@children[0].x = Align.center()
					@children[1].x = Align.center()
					@children[0].animate
						y: Align.center(0)	
						options:
							time:0.14
			#字体
			fontNameArr = []
			fontValueArr = []
			fontWeightArr = []
			fontSizeArr = []
			textguidGroup = []
			textSizeGroup = []
			textWeightGroup = []
			
			for i in DLSDataApi.fontStyleData
				fontNameArr.push(i.name)
				fontValueArr.push(i.value)
				fontWeightArr.push(i.value.weight)
				fontSizeArr.push(i.value.size)
			
			
			# print fontSizeArr
			for i in [0...DLSDataApi.fontStyleData.length]
				textguide = new TextLayer
					parent: srdScreen
					width: Screen.width-2*whiteSpaceSm
		# 			height: 36
					y: 48*i+shadowBox.y+shadowBox.height
					x: Align.left(whiteSpaceSm)
					text: "去哪儿旅行"
					color: "#212121"
					lineHeight: 1.6
					fontSize: fontSizeArr[i]
					fontWeight: fontWeightArr[i]
					
				textsub = new TextLayer
					parent: textguide	
					y: Align.center()
					fontSize: 12
					color: "#BDBDBD"
					x: Align.right()
					text: fontNameArr[i]
					
					
				textSize = new TextLayer
					parent: textguide	
					y: Align.center()
					fontSize: 12
					color: "#212121"
					x: Align.right(-40)
					text: fontSizeArr[i]+"pt /"
					opacity: 0
				
				textWeight = new TextLayer
					parent: textguide	
					y: Align.center()
					fontSize: 12
					color: "#212121"
					x: Align.right()
					textAlign: "left"
					text: fontWeightArr[i]
					opacity: 0	
					
				textguidGroup.push(textguide)	
				textSizeGroup.push(textSize)
				textWeightGroup.push(textWeight)
				
				
				textguide.onMouseOver (event, layer) ->
					for i in [0...textguidGroup.length]
						textguidGroup[i].backgroundColor = null
# 						textguidGroup[i].children[0].opacity = 0
						textSizeGroup[i].animate
							opacity:0
							options:
								time:0.2
						textWeightGroup[i].animate
							opacity:0
							options:
								time:0.2	
					@backgroundColor = light(primarycolor,90)
					@children[0].animate
						opacity:0
						options:
							time:0.2
					@children[1].animate
						opacity: 1
						options:
							time:0.2
					@children[2].animate
						opacity: 1
						options:
							time:0.2	
						
				textguide.onMouseOut (event, layer) ->
					for i in [0...textguidGroup.length]
						textguidGroup[i].backgroundColor = null
						textguidGroup[i].children[0].animate
							opacity:1
							options:
								time:0.2
						textguidGroup[i].children[0].color = "#BDBDBD"			
						textSizeGroup[i].animate
							opacity:0
							options:
								time:0.2
						textWeightGroup[i].animate
							opacity:0
							options:
								time:0.2	
			
			#动画时长			
			animateNameArr = []
			animateValueArr = []
			tagLayer = new Layer
				parent: srdScreen
				y: textguide.y+56
				x: whiteSpaceSm
				backgroundColor: null
				height: 80
				width: Screen.width-whiteSpaceSm*2
			
			for i in DLSDataApi.animateData
				animateNameArr.push(i.name)
				animateValueArr.push(i.value)
				
			
			Tagcur = tag_sel.copy()
			Tagcur.parent = srdScreen
			Tagcur.width = (Screen.width-whiteSpaceSm*2)/animateNameArr.length
			Tagcur.x = Tagcur.width+whiteSpaceSm
			Tagcur.y = textguide.y+56
			Tagcur.backgroundColor = light(primarycolor,90)
			tagGroup = []
			duration = 0.2
			
			for i in [0...animateNameArr.length]
				Tag = tag.copy()
				Tag.parent = tagLayer
				Tag.width = (Screen.width-whiteSpaceSm*2)/animateNameArr.length
				Tag.x = Tag.width*i
				Tag.y = 0
			# 	Tag.children[0].visible = true
				Tag.children[0].text = animateNameArr[i]
				Tag.children[0].color = primarycolor
				Tag.children[0].x = Align.center()
				tagGroup.push(Tag)
				Tag.value = animateValueArr[i]
				
				
			# 	print Tag.value
				Tag.onClick (event, layer) ->
					Tagcur.animate
						midX: @midX+whiteSpaceSm
						options: 
							curve: "cubic-bezier(0.215, 0.61, 0.355, 1)"
							time: 0.2

# 				Tag.onMouseOver (event, layer) ->
# 					@children[0].text = animateValueArr[@index-15]
# 					@children[0].x = Align.center()
# 				Tag.onMouseOut (event, layer) ->
# 					@children[0].text = animateNameArr[@index-15]
# 					@children[0].x = Align.center()		
#		 	addMouseEvent(Tag,tagGroup,animateNameArr,animateValueArr,Align.center())								
			#缓动
			curveNameArr = []
			curveValueArr = []
			rollGroup = []
			rollBtnGroup = []
			
			rollArea = new Layer
				parent: srdScreen
				width:Screen.width-whiteSpaceSm*2
				x: whiteSpaceSm
				y: Tagcur.y+Tagcur.height
				backgroundColor: null
			
				
			rollBtnLayer = new Layer
				width: rollArea.width
				parent: rollArea
				x: 0
				y: 0
				backgroundColor: null
				
			rollLayer = new Layer
				width: rollArea.width
				parent: rollArea
				x: 0
				y: 0
				backgroundColor: null	
				
			
			for i in DLSDataApi.curve
				curveNameArr.push(i.name)
				curveValueArr.push(i.value)
			
				
			for i in [0...DLSDataApi.curve.length]
				rollBtn = new Layer
					parent: rollBtnLayer
					width: 64
					height: 64
					x: 0
					borderRadius: 100
					backgroundColor: "#FFF"
					borderColor: dark(primarycolor,10)
					borderWidth: 1
					y: 24+(64+32)*i	
				rollBtnGroup.push(rollBtn)	
					
				rolltxt = new TextLayer
					parent: rollBtn
					text: curveNameArr[i]
					fontSize: 12
					x: Align.center()
					y: Align.center()
					color: primarycolor
			# print rollGroup[0]
			
			
			for i in [0...DLSDataApi.curve.length]	
				roll = new Layer
					parent: rollLayer
					x: 0
					opacity: 0.2
					width: 64
					height: 64
					borderRadius: 100
					backgroundColor:light(primarycolor,90)
					y: 24+(64+32)*i
				rollGroup.push(roll)
				
			initialRollStates = ()->
				for i in [0...DLSDataApi.curve.length]
			# 		print curveValueArr[i]
					rollGroup[i].states.stateA =
							x: Align.right(-whiteSpaceSm)
							opacity: 1
							backgroundColor:primarycolor
							options: 
								curve: curveValueArr[i]
								time: duration
			
					rollGroup[i].states.stateB =
							x: 0
							opacity: 0.2
							backgroundColor: light(primarycolor,90)
							options: 
								curve: curveValueArr[i]
								time: duration	
			initialRollStates()
			
			
			
			changeDuration = (a)->
				duration = a
				initialRollStates()
			
			tips.parent = rollArea
			tips.midY = rollGroup[0].midY
			tips.opacity = 0
			tips.x = 64
			tips.states.stateA =
				opacity: 1
			# print curveValueArr
			
			rollLayer.height = rollLayer.contentFrame().height
			rollBtnLayer.height = rollBtnLayer.contentFrame().height+120
			rollArea.height = rollArea.contentFrame().height+120
			
			for i in [0...animateNameArr.length]
				tagGroup[i].onClick (event, layer) ->
			# 		print parseFloat(@value)
					changeDuration(parseFloat(@value))
				
			for i in [0...DLSDataApi.curve.length]	
				rollGroup[i].onClick (event, layer) ->
					@stateCycle("stateA","stateB")
			# 		tips.stateCycle("default","stateA")
					
				rollGroup[i].onMouseOver (event, layer) ->
			# 		print @midY
					tips.animate
						midY: @midY
						opacity: 1
						options: 
							time: 0.2
			# 		print curveValueArr[@index]
					tips_txt.text = curveValueArr[@index]		
					
				rollGroup[i].onMouseOut (event, layer) ->
			# 		print @midY
					tips.animate
						opacity: 0
						options: 
							time: 0.2			
					
			for i in [0...DLSDataApi.curve.length]
				rollBtnGroup[i].onClick	(event, layer) ->
					for i in [0...DLSDataApi.curve.length]
						rollGroup[i].stateSwitch("stateB")				
			srdScreen.height = srdScreen.contentFrame().height+paletteSection.height+currentRow*sqrwidth	
			scroll.contentInset = top: 0
# 			print srdScreen		
		renderStytle()
ResetJson(myDLSurl,paletteAmount,primarycolor)
						

#创建面版及事件
mask = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "rgba(0,0,0,0.7)"
	y: Align.bottom
	visible: false
	
sheet01 = new Layer
	width: 300
	height: 200
	point: Align.center()
	backgroundColor: "#FFF"
	borderRadius: 12
	scale: 0.6
	opacity: 0

sheet02 = new Layer
	width: 300
	height: 200
	point: Align.center()
	backgroundColor: "#FFF"
	borderRadius: 12
	scale: 0.6
	opacity: 0

DoneBtn = new Layer
	parent: sheet02
	width: 80
	height: 32
	x: Align.right(-24)
	y: Align.bottom(-16)
	borderRadius: 100
	backgroundColor: "0FCAE2"
	visible: false
	
DoneTxt = new TextLayer
	parent: DoneBtn
	fontSize: 12
	color: "#FFF"
	text: "Done"
	fontWeight: "bold"
	point: Align.center()	
# 

InputModule = require "Input/input"
input = new InputModule.Input
	parent:sheet01
	setup: true # Change to true when positioning the input so you can see it
	y: Align.center(-20)
	width: 240
	x: Align.center(-10)
	height: 80
	backgroundColor: "#F5F5F5"
	fontSize: 14 # Size in px
	fontFamily: "-apple-system"
	fontWeight:"400"
	textarea: true
	textColor: "#333"
	placeholder: "输入要生成的色卡数量"
	goButton: true
	submit: true
	virtualKeyboard: false
	visible :false
		
showValue = new InputModule.Input
	parent:sheet02
	setup: true # Change to true when positioning the input so you can see it
	y: Align.center(-20)
	width: 240
	x: Align.center(-10)
	height: 80
	backgroundColor: "#F5F5F5"
	fontSize: 14 # Size in px
	fontFamily: "-apple-system"
	fontWeight:"400"
	textarea: true
	textColor: "#333"
	goButton: true
	submit: true
	virtualKeyboard: false
	visible:false

 
ViewBtn = new Layer
	parent: sheet01
	width: 80
	height: 32
	x: Align.right(-24)
	y: Align.bottom(-16)
	borderRadius: 100
	backgroundColor: "0FCAE2"
	
ViewTxt = new TextLayer
	parent: ViewBtn
	fontSize: 12
	color: "#FFF"
	text: "Done"
	fontWeight: "bold"
	point: Align.center()	

#avatar
wechatcode.x = Align.right()
wechatcode.y = Align.top(72)
wechatcode.originx = 1
wechatcode.originY = 0
wechatcode.scale = 0
wechatcode.opacity = 0
wechatcode.states.stateA =
	originx : 0.5
	originY : 0
	opacity: 1
	scale: 1
	options: 
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0.15
wechatcode.states.stateB =
	originx : 0.5
	originY : 0
	opacity: 1
	scale: 0
	options: 
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0	
# 
# avatar.onClick (event, layer) ->
# 	wechatcode.stateCycle("stateA","stateB")


sheet01.states.stateA = 
	scale: 1
	opacity: 1

sheet02.states.stateA = 
	scale: 1
	opacity: 1
	
sheetTxt01 = new TextLayer
	parent: sheet02
	text: "请输入要预览的色值"
	fontSize: 12
	x: Align.center
	y: 12
	
sheetTxt02 = new TextLayer
	parent: sheet01
	text: "请输入要渲染梯度数量"
	fontSize: 12
	x: Align.center
	y: 12			
	
preview.onClick (event, layer) ->
	mask.visible = true
	input.visible = true
	sheet01.animate "stateA",
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0.2
	sheetTxt02.text = "梯度值"
	sheetTxt02.x = Align.center()	

mask.onClick (event, layer) ->
	mask.visible = false
	input.visible = false
	sheet01.animate "default",
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0.2
	sheet02.animate "default",
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0.2
setting.onClick (event, layer) ->
	DoneBtn.visible = true
	showValue.visible = true
	mask.visible = true
	sheet02.animate "stateA",
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0.2
	showValue.value = primarycolor
	DoneBtn.visible = true	
	

DoneBtn.onClick (event, layer) ->
	showValue.visible = false
	DoneBtn.visible = false
	mask.visible = false
	sheet02.animate "default",
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0.2
	primarycolor = showValue.value
	scroll.content.children[0].children[0].destroy()
	scroll.content.children[1].destroy()
	scroll.content.children[0].destroy()
	if showValue.value == ""
		ResetJson(myDLSurl,paletteAmount,"#0FCAE2")
		creatPalette(paletteAmount,"#0FCAE2")
	else
		ResetJson(myDLSurl,paletteAmount,primarycolor)	
		creatPalette(paletteAmount,primarycolor)
	
# 
ViewBtn.onClick (event, layer) ->
	sheet01.animate "default",
		curve: "cubic-bezier(0.175, 0.885, 0.32, 1.275)"
		time: 0.2
	mask.visible = false
	scroll.content.children[0].children[0].destroy()
	scroll.content.children[1].destroy()
	scroll.content.children[0].destroy()
	paletteAmount = parseInt(input.value)
	if input.value == ""
		ResetJson(myDLSurl,6,primarycolor)
		creatPalette(6,primarycolor)
	else
		ResetJson(myDLSurl,paletteAmount,primarycolor)
		creatPalette(paletteAmount,primarycolor)
		
