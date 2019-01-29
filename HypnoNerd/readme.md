# 第6章 - 视图控制器
1. 视图控制器的创建
	1. init
	2. initWithNibName
		1. 只要xib的文件名和ViewController的文件名一致，使用ViewController的init方法，系统会自动寻找同名的xib文件进行关联，但切记要设置xib文件的class属性为ViewController的文件名
2. 视图的创建
	1. 纯代码创建
	2. 通过Interface Builder创建 xib 文件
		1. xib中的视图如何与ViewController关联？
			1. xib的File’s Owner属性
			2. 按住Control键，点击File’s Owner属性，从列表中点击+号关联视图
3. UITabBarController的使用
	1. 创建
	`
	UITabBarController *tabBarController =  [[UITabBarController alloc] init];
	tabBarController.viewControllers = @[vc1, vc2];
	self.window.rootViewController = tabBarController;
	`
	2. 修改tabBarItem的tile和image属性，定制底部标题和图片
		*. 在子ViewController的initWithNibName方法中，定制title和image
		`
		UITabBarItem *tabBarItem = self.tabBarItem;
		tabBarItem.title = @"title1";
		tabBarItem.iamge = [UIImage imageNamed:@"image1"];
		`

4. 不要在initWithNibName或者init方法中使用self.view对象，应为此时view还没有初始化完成，此时使用会出现崩溃，在`ViewWillAppear或者ViewDidAppear`中设置视图对象(UIDatePicker，UIButton…)
5. `ViewDidLoad`只在创建`ViewController`时调用一次，`ViewWillAppear和ViewDidAppear`在每次ViewController中的视图将要显示到屏幕上时调用
6. 一定要遵循存取方法命名规范，其目的不仅仅是方便其他开发者阅读代码，系统也具有一套依赖于命名规范的工作机制，如果不遵守命名规范，很有可能会发生意外错误，比如：
	1. 某VC定义了clock插座变量，指向一个表示时钟的视图，同时，它(表示时钟的视图)还作为一个按钮的目标，为其定义了动作方法setClock:。该方法用于获取网络最新时间并更新始终视图，方法声明如下：
	`- (IBAction)setClock:(id)sender;`
	这样就会产生一个奇怪的问题：当NIB文件被加载时，该方法会立即执行，同时也无法正确设置clock插座变		量。原因是：
		* 	系统会使用`setClock:`动作方法设置clock - 系统会将`setClock:`视为clock的存方法。
	2. 简单总结上面的例子：动作方法的命名不要和插座变量/实例变量的存方法名称冲突
