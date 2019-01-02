# 第4章 - 视图与视图层次结构
1. 视图基础
	1. 视图是UIView对象，或是UIView子类对象
	2. 视图知道如何绘制自己
	3. 视图可以处理时间，例如触摸(touch)
	4. 视图会按照层次结构排列，位于视图层次结构顶端的是应用窗口
2. 视图层次结构
3. 如何创建UIView子类
	* initWithFrame - UIView对象初始化方法
4. 在UIView子类的drawRect:方法中自定义绘图
	1. CGPoint - 定义点的结构体
	```
	struct CGPoint {
	    CGFloat x;
	    CGFloat y;
	};
	```
	2. CGRect - A structure that contains the location and dimensions of a rectangle.
	```
	struct CGRect {
    CGPoint origin;
    CGSize size;
	};
	```
	3. UIBezierPath - 用来绘制图形的类
	4. UIImage、UIBezierPath和NSString都提供了至少一种在drawRect:中绘图的方法
		1. UIImage: [logoImage drawInRect:someRect];
		2. UIBezierPath:参见项目代码
		3. NSString:```[logoString drawInRect:<#(CGRect)#> withAttributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#>];```

### BNRHypnosisView.m为UIView的子类，自定义绘图的实现代码都在该文件中
