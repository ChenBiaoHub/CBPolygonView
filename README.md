# CBPolygonView
能力图，分布图，雷达图，蜘蛛网图
- 一句话调用
```
cb_drawPolygon(percent:[0.5, 0.6, 0.4, 0.8, 0.6, 0.8, 0.9] , titles: ["击杀", "金钱", "防御", "魔法", "物理", "助攻","生存"], radius: 120)
```
![image](https://github.com/ChenBiaoHub/CBPolygonView/blob/master/IMG_0093.PNG?raw=true)
- 可自定义选项
```
样式(多边形 : polygon, 圆形 : circle) : type

连接线颜色 : lineColor
连接线宽度 : lineWidth

多边形连接点点图片（有图片会优先使用图片）: pointImage

多边形连接点点颜色 : pointColor
多边形连接点点宽度 : pointWidth

中心点到外圈连线颜色 : centerLineColor
中心点到外圈连线线宽 : centerLineWidth

线圈类型(实线 : soild, 虚线 : dotted) : circleType
线圈线宽 : circleLineWidth
线圈颜色 : circleLineColor

描述文字中心距外圈距离 : titleDistance
描述文字中心点的字体 : titleFont
描述文字 : titleColor

内圈 : circles
区域内填充颜色 : fillColor

旋转角度(180°写成 π ) : angle
```

- 如有任何疑问或者需求，欢迎提交到issues或者我的邮箱 chenbiao9494@163.com
