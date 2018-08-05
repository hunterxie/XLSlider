//
//  XLSlider.m
//  LoveWatchProject
//
//  Created by xll on 2017/12/2.
//  Copyright © 2017年 xll. All rights reserved.
//

#import "XLSlider.h"

@interface XLSlider()
@property(nonatomic,assign)CGPoint panStartPoint;
@property(nonatomic,assign)CGFloat lastCenterX;

@property(nonatomic,assign)CGFloat currentX;
@end

@implementation XLSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self addGestureRecognizer:pan];
}
-(void)setSliderType:(XLSliderType)sliderType
{
    _sliderType = sliderType;
    if (_sliderType == XLSliderLeftType) {
        self.mCenterImgCenterX.constant = - (self.totalWidth / 2);
        self.mCenterLeftStokeLine.hidden = YES;
        self.mCenterRightStokeLine.hidden = YES;
        self.mLeftStokeLine.hidden = NO;
    }
    else
    {
        self.mCenterImgCenterX.constant = 0;
        self.mCenterLeftStokeLine.hidden = NO;
        self.mCenterRightStokeLine.hidden = NO;
        self.mLeftStokeLine.hidden = YES;
    }
}
-(void)setDefaultValue:(int)defaultValue
{
    self.mCountLabel.text = [NSString stringWithFormat:@"%d",defaultValue];
    
    if (_sliderType == XLSliderLeftType) {
        self.mCenterImgCenterX.constant = - (self.totalWidth / 2) + (defaultValue - self.minValue * 1.0)/(self.maxValue - self.minValue) * self.totalWidth * 1.0;
        self.mLeftWidthCons.constant = self.mCenterImgCenterX.constant + self.totalWidth / 2;
    }
    else
    {
        self.mCenterImgCenterX.constant = (defaultValue - (self.maxValue + self.minValue * 1.0)/2)/(self.maxValue - self.minValue) * self.totalWidth * 1.0;
        if (defaultValue > (self.maxValue + self.minValue)/2.0) {
            self.mCenterLeftWidthCons.constant =  0;
            self.mCenterRightWidthCons.constant = MAX(0, self.mCenterImgCenterX.constant);
        }
        else
        {
            self.mCenterRightWidthCons.constant =  0;
            self.mCenterLeftWidthCons.constant = -MIN(self.mCenterImgCenterX.constant, 0);
        }
    }
}
-(void)panGes:(UIPanGestureRecognizer *)recognize
{
    switch (recognize.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognize translationInView:self];
            self.lastCenterX = self.mCenterImgCenterX.constant;
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint currentPoint = [recognize translationInView:self];

            int totalCount = self.maxValue - self.minValue;
            CGFloat everyDistance = totalCount * 1.0 / self.totalWidth;

            CGFloat offsetX = currentPoint.x - self.panStartPoint.x;
            
            if (self.lastCenterX + offsetX  <= self.totalWidth / 2&& self.lastCenterX + offsetX >= - self.totalWidth / 2) {
                self.mCenterImgCenterX.constant = self.lastCenterX + offsetX;
            }
            else if(self.lastCenterX + offsetX  > self.totalWidth / 2)
            {
                self.mCenterImgCenterX.constant = self.totalWidth / 2;
            }
            else
            {
                self.mCenterImgCenterX.constant = - self.totalWidth / 2;
            }
            
            if (self.sliderType == XLSliderLeftType) {
                
                self.mLeftWidthCons.constant = self.mCenterImgCenterX.constant + self.totalWidth / 2;
                self.mCountLabel.text = [NSString stringWithFormat:@"%.0f",(self.mCenterImgCenterX.constant + self.totalWidth / 2) * everyDistance + self.minValue];
            }
            else
            {
                if (self.mCenterImgCenterX.constant >= 0) {
                    self.mCenterLeftWidthCons.constant =  0;
                    self.mCenterRightWidthCons.constant = MAX(0, self.mCenterImgCenterX.constant);
                }
                else
                {
                    self.mCenterRightWidthCons.constant =  0;
                    self.mCenterLeftWidthCons.constant = -MIN(self.mCenterImgCenterX.constant, 0);
                }
                if (self.mCenterImgCenterX.constant == 0) {
                    self.mCountLabel.text = [NSString stringWithFormat:@"%.0f",(self.maxValue + self.minValue)/2.0] ;
                }
                else
                {
                    self.mCountLabel.text = [NSString stringWithFormat:@"%.0f",self.mCenterImgCenterX.constant * everyDistance  + (self.maxValue + self.minValue)/2.0];
                }
            }
            if ([self.mCountLabel.text floatValue] == 0) {
                self.mCountLabel.text = @"0";
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(slider:valueChange:)]) {
                [self.delegate slider:self valueChange:[self.mCountLabel.text floatValue]];
            }
            
        }
            break;
    
        default:
            break;
    }
}

@end
