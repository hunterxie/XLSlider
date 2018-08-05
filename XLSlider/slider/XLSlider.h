//
//  XLSlider.h
//  LoveWatchProject
//
//  Created by xll on 2017/12/2.
//  Copyright © 2017年 xll. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XLSliderType){
    XLSliderLeftType = 0,//左边开始
    XLSliderCenterType //中间开始
};

@class XLSlider;

@protocol XLSliderDelegate <NSObject>

- (void)slider:(XLSlider *)slider valueChange:(float)value;

@end

@interface XLSlider : UIView

@property (weak, nonatomic) IBOutlet UILabel *mCountLabel;
@property (weak, nonatomic) IBOutlet UIView *mLeftStokeLine;
@property (weak, nonatomic) IBOutlet UIView *mCenterRightStokeLine;
@property (weak, nonatomic) IBOutlet UIView *mCenterLeftStokeLine;
@property (weak, nonatomic) IBOutlet UIImageView *mCenterImgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCenterLeftWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCenterRightWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mLeftWidthCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCenterImgCenterX;

@property(nonatomic,assign)CGFloat totalWidth;//总宽度
@property(nonatomic,assign)XLSliderType sliderType;
@property(nonatomic,assign)int maxValue;
@property(nonatomic,assign)int minValue;

-(void)setDefaultValue:(int)defaultValue;

@property(nonatomic,weak)id <XLSliderDelegate>delegate;


@end
