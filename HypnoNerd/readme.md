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
	```
	UITabBarController *tabBarController =  [[UITabBarController alloc] init];
	tabBarController.viewControllers = @[vc1, vc2];
	self.window.rootViewController = tabBarController;
	```
	2. 修改tabBarItem的tile和image属性，定制底部标题和图片  
		* 在子ViewController的initWithNibName方法中，定制title和image
		```
		UITabBarItem *tabBarItem = self.tabBarItem;
		tabBarItem.title = @"title1";
		tabBarItem.iamge = [UIImage imageNamed:@"image1"];
		```

4. 不要在initWithNibName或者init方法中使用self.view对象，应为此时view还没有初始化完成，此时使用会出现崩溃，在`ViewWillAppear或者ViewDidAppear`中设置视图对象(UIDatePicker，UIButton…)
5. `ViewDidLoad`只在创建`ViewController`时调用一次，`ViewWillAppear和ViewDidAppear`在每次ViewController中的视图将要显示到屏幕上时调用
6. 一定要遵循存取方法命名规范，其目的不仅仅是方便其他开发者阅读代码，系统也具有一套依赖于命名规范的工作机制，如果不遵守命名规范，很有可能会发生意外错误，比如：
	1. 某VC定义了clock插座变量，指向一个表示时钟的视图，同时，它(表示时钟的视图)还作为一个按钮的目标，为其定义了动作方法setClock:。该方法用于获取网络最新时间并更新始终视图，方法声明如下：
	`- (IBAction)setClock:(id)sender;`
	这样就会产生一个奇怪的问题：当NIB文件被加载时，该方法会立即执行，同时也无法正确设置clock插座变量。原因是：
		* 系统会使用`setClock:`动作方法设置clock - 系统会将`setClock:`视为clock的存方法。
	2. 简单总结上面的例子：动作方法的命名不要和插座变量/实例变量的存方法名称冲突

# 第7章 - 委托与文本输入(Delegation and Text Input)
### 概述
1. 委托是Cocoa Touch中的一种[常见设计模式]
2. `UITextField`是常用的文本输入控件

### 详细总结
1. `UITextField` - `firstResponder(第一响应者)`
	1. 创建`UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40,70,240,30)];`
	2.  ::UIResponder:: - UIKit框架中的一个抽象类，`UIView、UIViewController、UIApplication`都是它的子类
		1. `UIResponder`定义了一系列方法，用于接收和处理用户事件，例如触摸事件、运动事件（如摇晃设备）和功能控制事件（如编辑文本和播放音乐）等。`UIResponder`的子类会覆盖这些方法，实现自己的事件响应代码。
		2. 触摸事件由被触摸的视图负责处理，系统会将触摸事件发送给被触摸的视图 - 参见第5章[触摸事件的处理](bear://x-callback-url/open-note?id=ED55DAB3-CA95-4815-AB73-3965FD0841AF-299-0000F5AAD8AD50A7)
		3. 其他类型的事件则会由第一响应者(`firstResponder`)处理，`UIWindow`有一个`firstResponder`属性指向第一响应者。例如，当用户点击`UITextField`对象时，`UITextField`对象就会成为第一响应者。`UIWindow`会将`firstResponder`指向该对象，之后，如果应用接收到运动事件和功能控制事件，都会发送给`UITextField`对象(如图7-2)  
![image](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/Resources/firstResponder.png)  
					图7-2  第一响应者				
		4. 当某个`UITextField`对象或`UITextView`对象成为第一响应者时，屏幕会弹出键盘。
		5. 除了用户点击之外，还可以在代码中向`UITextField`对象发送`becomeFirstResponder`消息，使其成为第一响应者
		6. 相反，如果要关闭键盘，则可以向`UITextField`对象发送`resignFirstResponder`，要求该对象放弃第一响应者身份。
		7. 一旦第一响应者不是`UITextField`对象，键盘就会消失
		8. 实际上，大部分视图不需要成为第一响应者。例如UISlider对象，该对象只处理用户触摸事件（用户拖拽滑块），而不会接受其他类型的事件，因此不需要成为第一响应者。
	3. 设置UITextField的键盘的一些属性
		1. placeholder - 占位符文本
		2. returnKeyType - 键盘的换行键类型（Return(默认)、Done）
		3. autocapitalizationType - 自动大写功能
		4. autocorrectionType - 拼写建议功能
		5. enablesReturnKeyAutomatically - 换行键自动检测功能
		6. keyboardType - 弹出键盘类型
		7. secureTextEntry - 安全输入功能，即常见的密码文本框
2. 委托（delegation）
	1. UITextField对象有一个委托属性	`@property（nonatomatic, weak）UITextFieldDelegate *delegate;`，通过为UITextField对象设置委托，UITextField对象会在事件发生时向委托发送相应的信息，由委托处理该事件。
		* 例如，对于编辑UITextField对象文本内容的事件，有如下两个对应的委托方法：
```
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder

- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called	
```
		* 	还有一类带有返回值的委托方法，用于从委托中查询需要的信息，例如：
```
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
```
	2. 委托方法中，第一个参数通常为对象自身。多个对象可能具有相同的委托，当委托收到消息时，需要根据该参数判断发送消息的对象。
		* 例如，如果某个视图控制器包含多个UiTextField对象，它们的委托都是该视图控制器，那么视图控制器就需要根据textField参数获取不同的UITextField对象并执行不同的操作。
3. 协议（Protocols）
	1. 凡是支持委托的对象，其背后都有一个相应的协议（类似 Java/C#中的接口），声明可以向该对象的委托发送的消息
	2. 委托对象需要根据这个协议为其”感兴趣“的事件实现相应的方法。如果一个类实现了某个协议中规定的方法，就称这个类**遵守(conform)**该协议。
	3. UITextField的协议示例代码如下：
```
// 声明协议的语法是：@protocol+协议名，如下所示
// <NSObject>是指NSObject协议，作用是：声明UITextFieldDelegate包含NSObject协议的全部方法
@protocol UITextFieldDelegate <NSObject>

@optional

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0); // if implemented, called in place of textFieldDidEndEditing:

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.

@end	
```
	4. 协议所声明的方法有required的和optional的
		* `@required` - 必需协议方法（默认）
		* `@optional` - 可选协议方法（委托协议中的方法通常都是可选的）
	5. 发送方在发送可选方法前，会先向其委托发送另一个名为`respondsToSelector:`的消息 - 在运行时检查对象是否实现了指定的方法。例如，UITextField可以实现如下方法：
```
-（void)clearButtonTapped
{
	// textFieldShouldClear:是可选方法，需要先检查委托是否实现了该方法
	SEL clearSelector = @selector(textFieldShouldClear:);
	
	if([self.delegate respondsToSelector:clearSelector]) {
		if([self.delegate textFieldShouldClera:self]) {
			self.text = @"";
		}
	}
}	
```
	6. 如果委托对象没有实现响应的方法，应用就会抛出位置选择器（unrecognized selector）异常，导致应用崩溃。
	7. 将相应的类声明为遵守指定的协议，编译器会自动检查某个类是否实现了相关协议的必须方法
		* 语法格式为：在头文件或者类扩展的@interface指令末尾，将类所遵守的协议以逗号分隔的形式写在尖括号里。
```
@interface BNRHypnosisViewController() <UITextFieldDelegate> 
@end
```
	8. 几乎所有的委托都是弱引用属性，这是为了避免[强引用循环]
![image](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/Resources/weakDelegate.png)

