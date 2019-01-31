# 第7章 - 委托与文本输入(Delegation and Text Input)
### 概述
1. 委托是Cocoa Touch中的一种[常见设计模式]
2. `UITextField`是常用的文本输入控件

### 详细总结
1. `UITextField` - `firstResponder(第一响应者)`
	1. 创建`UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40,70,240,30)];`
	2.  **UIResponder** - UIKit框架中的一个抽象类，`UIView、UIViewController、UIApplication`都是它的子类
		1. `UIResponder`定义了一系列方法，用于接收和处理用户事件，例如触摸事件、运动事件（如摇晃设备）和功能控制事件（如编辑文本和播放音乐）等。`UIResponder`的子类会覆盖这些方法，实现自己的事件响应代码。
		2. 触摸事件由被触摸的视图负责处理，系统会将触摸事件发送给被触摸的视图 - 参见第5章[触摸事件的处理]
		3. 其他类型的事件则会由第一响应者(`firstResponder`)处理，`UIWindow`有一个`firstResponder`属性指向第一响应者。例如，当用户点击`UITextField`对象时，`UITextField`对象就会成为第一响应者。`UIWindow`会将`firstResponder`指向该对象，之后，如果应用接收到运动事件和功能控制事件，都会发送给`UITextField`对象(如图7-2)	
		![image](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/Resources/firstResponder.png)
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
		* 还有一类带有返回值的委托方法，用于从委托中查询需要的信息，例如：
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
	8. 几乎所有的委托都是弱引用属性，这是为了避免[强引用循环]。
	![image](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/Resources/weakDelegate.png)
4. 向屏幕中添加UILabel对象
	* 在屏幕上的随机位置绘制20个UILabel
		1. 随机点的获取 - 随机x+随机y
		2. 改变UILabel的frame.origin值
5. 运动效果（Motion Effects）
	1. 视差 - 大脑对空间和速度差异产生的一种错觉，例如：
		1. 坐在飞驰的汽车上向车窗外望去，会发现远处的景物倒退的速度比近处的要慢得多
		2. iOS7之后，在主屏幕中，稍微倾斜设备，主屏幕上的图标会随着倾斜方向相对于壁纸移动
	2. 应用可以通过`UIInterpolatingMotionEffect`类实现相同的效果
		* 创建一个`UIInterpolatingMotionEffect`对象
		* 设置其方向（水平或者垂直）
		* 键路径（key path，需要使用视差效果的属性）
		* 相对最小/最大值（视差的范围）
		* 添加到某个视图上，该视图就能获得相应的视差效果
        ```
	UIInterpolatingMotionEffect *motionEffect;
	motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	motionEffect.minimumRelativeValue = @(-25);
	motionEffect.maximumRelativeValue = @(25);
	[messageLabel.addMotionEffect:motionEffect];
        ```
6. 使用调试器
	1. 是用断点
	2. 单步执行代码
	3. 删除断点
	4. 设置异常断点
7. 深入学习：main()与UIApplication
	1. 用C语言编写的程序，其执行入口都是main()。用Objective-C语言编写的程序也是这样
        ```
        int main(int argc, char *argv[])	
        {
        	@autoreleasepool {
        		return UIApplicationMain(argc, argv, nil, NSStringFromClass([BNRAppDelegate class]));
        	}
        }
        ```
	2. 上面这段代码中的`UIApplicationMain`函数会创建一个`UIApplication`对象
		* 每个iOS应用都有且仅有一个`UIApplication`对象，该对象的作用是维护运行循环
		* 一旦创建了某个`UIApplication`对象该对象的运行循环就会一直循环下去，`main()`的执行也会因此阻塞
	3. 此外，`UIApplicationMain`函数还会创建某个指定类的对象，并将其设置为`UIApplication`对象的delegate。
		* 该对象的类是由`UIApplicationMain`函数的最后一个实参指定的，该实参的类型是NSString对象，代表某各类的名称。
		* 所以在以上这段代码中，`UIApplicationMain`函数会创建一个BNRAppDelegate对象，并将其设置为UIApplication对象的delegate
	4. 在应用启动运行循环并开始接收事件之前，UIApplication对象会向其委托发送一个特定的消息，使应用能有机会完成相应的初始化工作。这个消息的名称是`application:didFinishLaunchingWithOptions:`。
	5. 每个iOS应用都有一个`main()`，完成的都是相同的任务
8. 中级练习：捏合-缩放（Silver Challenge:Pinch to Zoom）
	* 通过
