# LNAlertSheetView
一套友好的、方便集成的底部item选择视图,性能优秀，集成简单，对原有代码风格不产生任何影响！

# 本次优化
1. 改成单利实现，性能更优秀
2. 多种显示样式可供选择
3. 多样化的事件处理方式



# Interduce 【简单介绍】
- 使用极其简单，一行代码全部搞定
- UI的显示分为有没有头部描述、有没有子标题
- 事件的处理分为在LNActionSheetModel内部处理 和 在显示的回调中处理，根据个人的使用习惯而定，没有什么区别



# Features【能做什么】
 更快、更简洁
 
# 目前存在的问题
 目前没发现问题

# Class【使用到的类】
LNActionSheet


# Getting Started【开始使用】

## 效果演示
![1](/1.PNG)
![2](/2.PNG)
![3](/3.PNG)

## 文字介绍
- 只需要引入LNActionSheet类，调用+ (void)showWithDesc:(NSString*)desc actionModels:(NSArray<LNActionSheetModel*> *)mdoels action:(void(^)(LNActionSheetModel *model))action; 美好的事情立刻发生


-如果需要改变现实的外观，请直接修改头文件中的宏
#define BG_Color             [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]    
#define Bottom_BG_Color      [UIColor colorWithHexString:@"EFEFEF"]     
#define Desc_Color           [UIColor colorWithHexString:@"#666666"]   
#define Desc_Font            [UIFont systemFontOfSize:12]
#define Item_Normal_Color      [UIColor blackColor]
#define Item_Normal_Font       [UIFont systemFontOfSize:16]
#define Sub_Item_Normal_Color  [UIColor blackColor]
#define Sub_Item_Normal_Font   [UIFont systemFontOfSize:12]
#define Item_Delete_Color      [UIColor redColor]
#define Item_Delete_Font       [UIFont systemFontOfSize:13]


## 代码介绍
首先创建需要操作的item对应的model
```
 NSMutableArray *array = [NSMutableArray new];
    NSArray *titles = @[@"加好友",@"加关注",@"收藏",@"举报",@"删除"];
    NSArray *subTitles = @[@"找也找也找朋友，找到一个好朋友",
                           @"加关注是成为好友的第一步",
                           @"喜欢的话就保存起来吧",
                           @"涉黄、赌博、消沉的可以举报，帮我们净化环境",
                           @"要慎重哦，删了就全没了"];
    for (int i = 0; i < titles.count; i++) {
        LNActionSheetModel *model = [[LNActionSheetModel alloc]init];
        model.title = titles[i];
        model.subTitle = subTitles[i];
        model.sheetId = i;
        model.itemType = LNActionSheetItemNoraml;
        if (i == titles.count-1) {
            model.itemType = LNActionSheetItemDelete;
        }
        [array addObject:model];
    }
```

其中model中用到一个枚举，从来表明对应的item的类型
```
/**
 item的类型

 - LNActionSheetItemNoraml: 默认都是普通类型的
 */
typedef  NS_OPTIONS(NSUInteger,LNActionSheetItemType){
    LNActionSheetItemNoraml = 0,    //普通
    LNActionSheetItemDelete,        //删除
    LNActionSheetItemSure,          //确定
};
```

然后创建并显示
```
 [LNActionSheet showWithDesc:@"有标题和子标题的sheet" actionModels:[NSArray arrayWithArray:array] action:^(LNActionSheetModel *model) {
    }];
```



# more about  【更多】
1. 如果有什么问题，请在[issues](https://github.com/lengningLN/LNAlertSheetView/issues)区域提问，我会抽时间改进。
2. [我的博客](http://lengningln.github.io/)
3. [我的微博](http://weibo.com/liuning185)
### 打赏
![](http://m.qpic.cn/psb?/V11R4JcH0fAdbu/h4vWrizoOlby*zntVMiu.1F9CMMMx2T9BOWUjSEnCE8!/b/dDUBAAAAAAAA&bo=nALQAgAAAAADB24!&rf=viewer_4)
