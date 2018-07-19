//
//  ViewController.m
//  LCEmitterDemo
//
//  Created by Locke. on 2018/7/18.
//  Copyright © 2018年 Locke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLineEmitter];
//    [self addPointEmitter];
}

#pragma mark - 线性发射粒子
- (void)addLineEmitter
{
    self.view.backgroundColor = [UIColor darkGrayColor];
    CAEmitterLayer *lineEmitter = [CAEmitterLayer layer];
    lineEmitter.emitterPosition = CGPointMake(self.view.center.x, 0);//发射器位置
    lineEmitter.emitterSize = CGSizeMake([UIScreen mainScreen].bounds.size.width + 40, 1);//发射器尺寸
    lineEmitter.emitterMode = kCAEmitterLayerSurface;//发射器形状
    lineEmitter.emitterShape = kCAEmitterLayerLine;//发射模式
    lineEmitter.preservesDepth = YES;//是否启用3D效果
    lineEmitter.renderMode = kCAEmitterLayerUnordered;//发射器渲染模式
    NSMutableArray *cells = @[].mutableCopy;
    for (int i = 0; i < 6; i++) {//单行cell数量，可以用于控制横向密度
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        cell.name = @"ball";
        cell.birthRate = 2.0;//生成速度，必须设置，可以用于控制纵向密度
        cell.velocity = 60.0;//运动速度
        cell.velocityRange = 30.0;//运动速度浮动范围
        cell.scale = .4;//缩放
        cell.scaleRange = .2;//缩放浮动范围
        cell.emissionLongitude = M_PI;//粒子运动方向,0朝上，M_PI_2朝右，M_PI朝下
        cell.emissionRange = M_PI_4;//运动方向偏移范围
        cell.lifetime = 12.0;//生命周期
        cell.lifetimeRange = 5.0;//生命周期浮动范围
        cell.spin = 2.0;//自转速度
        cell.spinRange = 1.0;//自转速度浮动范围
        cell.xAcceleration = 2.0;//x轴加速度，相当于给雪花加点风力
//        cell.yAcceleration = 5;//y轴加速度，好像没必要
        cell.alphaRange = .3;//透明度随机范围
        cell.alphaSpeed = -0.05;//透明度递减
        cell.contents = (__bridge id)[UIImage imageNamed:@"snow"].CGImage;//cell绘制内容
        [cells addObject:cell];
    }
    lineEmitter.emitterCells = cells;
    [self.view.layer addSublayer:lineEmitter];
}

#pragma mark - 从点发射粒子
- (void)addPointEmitter
{
    CAEmitterLayer *lineEmitter = [CAEmitterLayer layer];
    lineEmitter.emitterPosition = CGPointMake(self.view.center.x, 100);
    lineEmitter.emitterShape = kCAEmitterLayerPoint;
    lineEmitter.preservesDepth = YES;
    NSMutableArray *cells = @[].mutableCopy;
    for (int i = 0; i < 5; i++) {
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        cell.velocity = 100.0;
        cell.velocityRange = 60.0;
        cell.scale = .08;
        cell.scaleRange = .05;
        cell.emissionLongitude = M_PI_2;
        cell.emissionRange = M_PI_2 / 4;
        cell.lifetime = 5.0;
        cell.lifetimeRange = 1.5;
        cell.spin = 10.0;
        cell.spinRange = 6.0;
        cell.birthRate = 2.0;
        cell.contents = (__bridge id)[UIImage imageNamed:@"redBall"].CGImage;
        [cells addObject:cell];
    }
    lineEmitter.emitterCells = cells;
    [self.view.layer addSublayer:lineEmitter];
}
@end
