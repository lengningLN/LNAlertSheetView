//
//  LNActionSheet.h
//  LNAlertSheetView
//
//  Created by 刘宁 on 2018/8/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//



#import <UIKit/UIKit.h>
/**
 item的类型

 - LNActionSheetItemNoraml: 默认都是普通类型的
 */
typedef  NS_OPTIONS(NSUInteger,LNActionSheetItemType){
    LNActionSheetItemNoraml = 0,    //普通
    LNActionSheetItemDelete,        //删除
    LNActionSheetItemSure,          //确定
};

@interface LNActionSheetModel : NSObject
/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 介绍，可为空
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 标示id
 */
@property (nonatomic, assign) int sheetId;


/**
 选择item的类型
 */
@property (nonatomic, assign) LNActionSheetItemType itemType;


/**
 这个model所在的item被点击了触发这个block
 */
@property (nonatomic, copy) void(^actionBlock)(void);

@end

@interface LNActionSheet : UIView

/**
 显示sheetView

 @param desc 头部描述
 @param mdoels 操作的item数据
 @param action 操作每个item时触发的事件
 */
+ (void)showWithDesc:(NSString*)desc actionModels:(NSArray<LNActionSheetModel*> *)mdoels action:(void(^)(LNActionSheetModel *model))action;


/**
 隐藏
 */
+ (void)hide;
@end
