# LNAlertSheetView
一套友好的、方便集成的底部item选择视图,性能优秀，集成简单，对原有代码风格不产生任何影响！

# 本次优化
1. 改成单利实现，性能更优秀
2. 多种显示样式可供选择
3. 多样化的事件处理方式



# Interduce 【简单介绍】
- 按照苹果官方的MVC的设计模式封装的Cell控件，类似UITableView的实现方式
- LNSwipeCell的编辑功能的数据由*LNSwipeCellDataSource*提供
- LNSwipeCell的编辑功能的事件由*LNSwipeCellDelegate*提供


# Features【能做什么】
 - [x] 实现左滑显示，标为已读、删除、置顶等多个按钮
 - [x] 触摸到已经打开的cell的contentView区域，关闭cell
 - [x] 触模到其他cell，关闭已经打开的cell
 - [x] 滑动tableView，关闭已经打开的cell
 - [x] 触摸到tableView的空白区域，关闭打开的cell
 - [x] 打开和关闭cell时，编辑按钮按照微信一样的动画出现
 - [ ] 点击删除按钮，变化为确认删除按钮
 
# 目前存在的问题
1. 由删除变化到确认删除的操作有问题，因为一旦改变tableview的子视图的frame，tabelview就会吧contentView归零，目前没找到合适的解决方式
2. 极端情况细节的处理不够完美

# Class【使用到的类】
1. LNSwipeCell   -- 封装了左滑编辑的cell


# Getting Started【开始使用】

## 效果演示

![](https://github.com/lengningLN/LNSwipeCellDemo/blob/master/LNSwipeCellDemo/resource/swipecell2.gif)  


## 文字介绍
- 把LNSwipeCell类拖进工程中
- 让你的cell继承LNSwipeCell，因为lNSwipeCell只封装了左滑编辑的逻辑和实现，因此你要根据需求自己绘制cell的UI
- 接受LNSwipeCellDataSource和LNSwipeCellDelegate
- 根据需要实现对应的协议方法

## 代码介绍
- 创建cell的设置
```

```




# more about  【更多】
1. 如果有什么问题，请在[issues](https://github.com/lengningLN/LNSwipeCellDemo/issues)区域提问，我会抽时间改进。
2. [我的博客](https://www.jianshu.com/u/dbd52f0e4f1c)
### 打赏
![](http://m.qpic.cn/psb?/V11R4JcH0fAdbu/h4vWrizoOlby*zntVMiu.1F9CMMMx2T9BOWUjSEnCE8!/b/dDUBAAAAAAAA&bo=nALQAgAAAAADB24!&rf=viewer_4)
