//
//  ViewController.m
//  XLSlider
//
//  Created by xll on 2018/8/5.
//  Copyright © 2018年 xll. All rights reserved.
//

#import "ViewController.h"
#import "XLSlider.h"
@interface ViewController ()<XLSliderDelegate>
{
    XLSlider *slider;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIType:2];
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)setupUIType:(int)type
{
    //center
    if (type == 1) {
        slider = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XLSlider class]) owner:nil options:nil] firstObject];
        slider.totalWidth = 290;
        slider.sliderType = XLSliderCenterType;
        slider.minValue = -100;
        slider.maxValue = 100;
        slider.delegate = self;
        slider.frame = CGRectMake(0, 0, 320, 100);
        slider.center = self.view.center;
        slider.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:slider];
    }
    else
    {
        slider = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XLSlider class]) owner:nil options:nil] firstObject];
        slider.totalWidth = 290;
        slider.sliderType = XLSliderLeftType;
        slider.minValue = 0;
        slider.maxValue = 200;
        slider.delegate = self;
        slider.frame = CGRectMake(0, 0, 320, 100);
        slider.center = self.view.center;
        slider.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:slider];
    }
}
-(void)slider:(XLSlider *)slider valueChange:(float)value
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
