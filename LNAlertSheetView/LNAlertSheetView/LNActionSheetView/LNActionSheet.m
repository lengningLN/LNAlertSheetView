//
//  LNActionSheet.m
//  LNAlertSheetView
//
//  Created by 刘宁 on 2018/8/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "LNActionSheet.h"

@implementation LNActionSheetModel
@end

@interface UIColor (Extend)
+ (UIColor *) colorWithHexString:(NSString *)stringToConvert;
@end

@implementation UIColor (Extend)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return nil;
    
    // strip 0X if it appearss
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
        return nil;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end

@interface LNActionSheet ()
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) UILabel *descriptionL;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *actionModels;
@property (nonatomic, copy) void(^click)(LNActionSheetModel *model);

@end

#define itemHeight 50
#define middleGap 10
#define itemOriginTag 23

@implementation LNActionSheet

static LNActionSheet *sheet = nil;
+ (void)initialize
{
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        sheet = [[LNActionSheet alloc]initWithFrame:CGRectZero];
    });
}

+ (void)showWithDesc:(NSString *)desc actionModels:(NSArray<LNActionSheetModel *> *)models action:(void (^)(LNActionSheetModel *))action
{
    sheet.desc = desc;
    sheet.actionModels = models;
    sheet.click = action;
    [sheet createUI];
    [sheet show];
}

-(void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];

    
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:4
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.bgView.frame = CGRectMake(0, self.bounds.size.height-self.bgView.bounds.size.height, self.bounds.size.width, self.bgView.bounds.size.height);
                     } completion:^(BOOL finished){
                     }];
    
}

+ (void)hide
{
    [sheet hide];
}

-(void)setFrame:(CGRect)frame
{
    CGRect rect = [UIScreen mainScreen].bounds;
    [super setFrame:rect];
}

- (void)createUI
{
   
    self.backgroundColor = BG_Color;
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = Bottom_BG_Color;
    //加一个介绍
    CGFloat orginItemY = 0;
    if (sheet.desc.length) {
        [sheet addDescrioptionLabel];
        orginItemY = [sheet descriptionStringHeight]+1;
    }
    //确定整个视图的frame
    CGFloat screenWidth = self.bounds.size.width;
    CGFloat screenHeight = self.bounds.size.height;
    self.bgView.frame = CGRectMake(0, screenHeight, screenWidth,orginItemY+(self.actionModels.count+1)*(itemHeight+1)+middleGap);
    
    for (int i = 0;i < self.actionModels.count; i++) {
        LNActionSheetModel * model = self.actionModels[i];
        UIButton * button = [[UIButton alloc]init];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = itemOriginTag + i;
        button.frame = CGRectMake(0,orginItemY+(itemHeight+1)*i, screenWidth, itemHeight);
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:button];
        
        UILabel * title = [[UILabel alloc]init];
        if (model.subTitle.length) {
            title.frame = CGRectMake(0, 0, screenWidth, 30);
        }else{
            title.frame = button.bounds;
        }
        
        title.textAlignment = NSTextAlignmentCenter;
        if (model.itemType == LNActionSheetItemDelete) {
            title.textColor = Item_Delete_Color;
        }else{
            title.textColor = Item_Normal_Color;
        }
        title.font = Item_Normal_Font;
        title.text = model.title;
        [button addSubview:title];
        
        if (model.subTitle) {
            UILabel * subTitle = [[UILabel alloc]init];
            subTitle.frame = CGRectMake(0, 30, screenWidth, 20);
            subTitle.textAlignment = NSTextAlignmentCenter;
            subTitle.textColor = Sub_Item_Normal_Color;
            subTitle.font = Sub_Item_Normal_Font;
            subTitle.text = model.subTitle;
            [button addSubview:subTitle];
        }
    }
    
    
    UIButton * button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = itemOriginTag + self.actionModels.count;
    button.frame = CGRectMake(0,  self.bgView.frame.size.height-itemHeight-1, screenWidth, itemHeight);
    [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:button];
    
    UILabel * title = [[UILabel alloc]init];
    title.frame = CGRectMake(0, 0, screenWidth, itemHeight);
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = Item_Normal_Color;
    title.font = Item_Normal_Font;
    title.text = NSLocalizedString(@"取消", nil);
    [button addSubview:title];
    
    [self.bgView addSubview:button];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
    
}


//添加描述的label
-(void)addDescrioptionLabel
{
    _descriptionL = [[UILabel alloc]init];
    _descriptionL.font = Desc_Font;
    _descriptionL.textColor = Desc_Color;
    _descriptionL.textAlignment = NSTextAlignmentCenter;
    _descriptionL.text = self.desc;
    CGFloat height = [self descriptionStringHeight];
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, self.bounds.size.width, height);
    _descriptionL.frame = CGRectMake(15, 0, view.bounds.size.width-15*2, height);
    [view addSubview:_descriptionL];
    [self.bgView addSubview:view];
}

//获取描述的label的高度
-(CGFloat)descriptionStringHeight
{
    CGSize size = [self.desc boundingRectWithSize:CGSizeMake(self.bounds.size.width-15*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.descriptionL.font} context:nil].size;
    if (size.height < itemHeight) {
        return itemHeight;
    }
    return size.height;
}


-(void)itemClick:(UIButton*)button
{
    [sheet hide];
    NSInteger index = button.tag - itemOriginTag;
    if (index == self.actionModels.count) {
        //用户点击取消
        return;
    }
    LNActionSheetModel * model = self.actionModels[index];
    if (model.actionBlock) {
        model.actionBlock();
    }
    
    if (self.click) {
        self.click(model);
    }
}

-(void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bgView.bounds.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self.bgView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
