//
//  LNActionSheet.h
//  LNAlertSheetView
//
//  Created by 刘宁 on 2018/8/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#define BG_Color   [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]
#define Bottom_BG_Color [UIColor colorWithHexString:@"EFEFEF"]
#define Desc_Color  [UIColor colorWithHexString:@"#666666"]
#define Desc_Font   [UIFont systemFontOfSize:12]

#define Item_Normal_Color  [UIColor blackColor]
#define Item_Normal_Font   [UIFont systemFontOfSize:16]

#define Sub_Item_Normal_Color  [UIColor blackColor]
#define Sub_Item_Normal_Font   [UIFont systemFontOfSize:12]

#define Item_Delete_Color  [UIColor redColor]
#define Item_Delete_Font   [UIFont systemFontOfSize:13]


#import <UIKit/UIKit.h>

//外观类型
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

//这个model被点击了触发这个block
@property (nonatomic, copy) void(^actionBlock)(void);

@end

@interface LNActionSheet : UIView
+ (void)showWithDesc:(NSString*)desc actionModels:(NSArray<LNActionSheetModel*> *)mdoels action:(void(^)(LNActionSheetModel *model))action;

+ (void)hide;
@end
