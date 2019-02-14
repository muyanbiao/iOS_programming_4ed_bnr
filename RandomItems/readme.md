# 第2章 - Object-C基础
### 本章重点
1. 对象
2. 适用对象
	1. 创建对象
	2. 发送消息
	3. 释放对象
3. 通过编写命令行工具学习基本语法、常用数据类型
	1. NSObject - 位于层次结构顶部的父类
	2. NSArray/NSMutableArray
	3. NSString/NSMutableString
	4. NSDictionary
4. 创建Objective-C类的子类
	1. 创建NSObject子类
	2. 实例变量
	3. 存取实例变量
	4. 使用点语法
	5. 类方法和实例方法
	6. 覆盖父类方法(override)
	7. 初始化方法 - 
	8. 指定初始化方法
	9. instancetype - 该关键字表示方法的返回类型和调用方法的对象类型相同，init方法的返回类型都声明为instancetype - 这样有助于子类覆盖父类的init方法
	10. id - 相当于C语言的 void*
	11. self - 是一个隐式(implicit)局部变量
	12. super - 在覆盖父类的某个方法时，往往需要保留该方法在父类中的实现，然后在其基础上扩充子类的实现
		```
		[super someMethod];
		[self doMoreStuff];
		```
	13. 确认父类的初始化结果
		```
		if (self = [super init]) {
			// 初始化当前类的实例变量
		}
		```
	14. 初始化方法中的实例变量
		* 在一般方法中，不要直接访问实例变量，而要使用存取方法
		* 在初始化方法中，应该直接访问实例变量
		```
		- (instancetype)init(id ivar) {
			if (self = [super init]) {
				_ivar = ivar;
				...
			}
		}
		```
	15. 其他初始化方法与初始化方法链
	16. 初始化方法规则：
		1. 类会继承父类所有的初始化方法，也可以为类加入任意数量的初始化方法
		2. 每个类都要选定一个指定初始化方法
		3. 在执行其他初始化工作之前，必须先用指定初始化方法调用父类的指定初始化方法(直接或间接)
		4. 其他初始化方法要调用指定初始化方法(直接或间接)
		5. 如果某个类所声明的指定初始化方法与其父类的不同，就必须覆盖父类的指定初始化方法，并调用新的制定初始化方法(直接或间接)

---
# 第3章 - 通过ARC管理内存(Managing Memory with ARC)
### ARC(automatic reference counting) - 自动引用计数
1. **栈（The Stack）**
	1. 当程序执行某个方法（或函数）时:
		* 会从内存中名为栈（Stack）的区域分配一块内存，这块内存空间称为帧（frame）
		* 帧负责保存在程序在方法内声明的变量的值
		* 在方法内声明的变量称为**局部变量（local variable）**
	2. 当某个应用启动并运行`main`函数时，它的帧会被保存在栈的底部。
		1. 当`main`调用另一个方法（或函数）时，这个方法（或函数）的帧会压入栈的顶部。
		2. 被调用的方法还可以调用其它方法，依此类推，最终会在栈中形成一个塔状的帧序列。
		3. 当被调用的方法（或函数）结束时，程序会将其帧从栈顶”弹出“并释放。
		4. 如果同一个方法再次被调用，则应用会创建一个全新的帧，并将其压入栈的顶部
![image](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/Resources/funCallWithStack.png)
2. **堆（The Heap）**
	1. **堆（heap）**是指内存中的另一块区域，和**栈**是分开的。
		1. **栈** - 按后进先出的顺序保存一组帧
		2. **堆** - 包含大量无序的活动对象，需要通过**指针**来保存这些对象在堆中的地址。
	2. 当应用向某个类发送`alloc`消息时，系统会从堆中分配一块内存，其大小足够存放相应对象的全部实例变量。
		* 以[BNRItem](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/RandomItems/RandomItems/BNRItem.h)对象为例，BNRItem包含5个实例变量，包含
			* 4个指针变量（isa、_itemName、_serialNumber、_dateCreated）
			* 1个int变量（_valueInDollars）
		* 系统会为1个int变量和4个指针变量分配内存，其中指针变量保存其他对象在堆中的地址
	3. 编写iOS应用时，只需要通过ARC(automatic reference counting)管理内存，也就是自动引用计数
3. 指针变量和对象所有权（Pointer Variables and Object Ownership）
指针变量暗含了对其所指向的对象的**所有权（ownership）**
	1. 当某个方法（或函数）有一个指向某个对象的局部变量时，可以称该变量**拥有（own）**该变量所指向的对象
	2. 当某个对象有一个指向其他对象的实例变量时，可以称该对象拥有该实例变量所指向的对象。
![image](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/Resources/RandomItems%E5%AF%B9%E8%B1%A1%E5%9B%BE.png)
	3. 对象所有权概念可以帮助我们决定是否应该释放某个对象并回收该对象占有的内存
		1. 如果某个对象没有拥有者，就应该将其释放。没有拥有者的对象是孤立的，程序无法向其发送消息。保留这样的对象只会浪费宝贵的内存空间，导致**内存泄漏（memory leak）**问题。
		2. 如果某个对象有一个或多个拥有者，就必须保留不释放。如果释放了某个对象，但是其他对象或方法仍然有指向该对象的指针（准确的说，是指向该对象被释放前的地址），那么向该指针指向的对象发送消息，就会导致程序崩溃。释放正在使用的对象的错误称为**过早释放**。指向不存在的对象的指针称为**空指针（dangling pointer）**或者**空引用（dangling reference）**。
	4. 哪些情况会使对象失去拥有者？
		1. 当程序修改某个指向特定对象的变量并将其指向另一个对象时。
		2. 当程序将某个指向特定对象的变量设置为nil时
		3. 当程序释放对象的某个拥有者时
		4. 当从collection类中（例如数组）删除对象时
	5. 所有权链（Ownership chains）
		* 因为对象可以拥有其他对象，后者也可以在拥有别的对象，所以释放一个对象可能会产生连锁反应，导致多个对象失去拥有者，进而释放对象并归还内存。
5. 强引用和弱引用（Strong and Weak Reference）
	1. 只要指针变量指向某个对象，那么相应的对象就会多一个拥有者，并且不会被程序释放。这种**指针特性(attribute)** 称为 **强引用（strong reference）**
	2. 程序也可以选择让指针变量不影响其指向的对象的拥有者个数。这种不会改变对象拥有者个数的**指针特性**称为**弱引用（weak reference）**
	3. **弱引用**非常适合解决一种称为**强引用循环（strong reference cycle**，有时也称为**保留循环）**的内存管理问题。
		1. 当两个或两个以上的对象相互之间有强引用的指针关联时，就会产生强引用循环
		2. 强引用循环会导致内存泄漏
		3. 当两个对象互相拥有时，将无法通过ARC机制来释放
		4. 即使应用中的其他对象都释放了这两个对象的所有权，这两个对象及其拥有的所有对象也无法被释放
	4. 参照[RandomItems项目中BNRItem.h](https://github.com/muyanbiao/iOS_programming_4ed_bnr/blob/master/RandomItems/RandomItems/BNRItem.h)项目`containedItem`和`container`的使用来避免强引用循环
6. 属性
7. 深入学习：属性合成
8. 深入学习：Autorelease池与ARC历史
