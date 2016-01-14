//
//  ViewController.m
//  UBERWelcome
//
//  Created by nacker on 15/10/31.
//  Copyright © 2015年 nacker. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "Masonry.h"
#import "LZLoginView.h"
#import "EMAlertView.h"

@interface ViewController ()<LZLoginViewDelegate>
@property (nonatomic, weak) UIView *circleView;
@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupCircleView];
    
    [self performSelector:@selector(animationOfCABasicAnimation) withObject:nil afterDelay:2.0f];
    [self performSelector:@selector(runAnimationWithImage) withObject:nil afterDelay:2.0f];
    [self performSelector:@selector(SetupVideoPlayer) withObject:nil afterDelay:5.0f];
}

- (void)setupCircleView
{
    CGRect rx = [UIScreen mainScreen].bounds;
    CGFloat myW = 2;
    UIView *circleView = [[UIView alloc]initWithFrame:CGRectMake((rx.size.width-myW)/2, (rx.size.height-myW)/2, myW, myW)];
    circleView.layer.borderWidth = 2;
    circleView.layer.borderColor = [[UIColor colorWithRed:(33/255.0 ) green: (172/255.0) blue: (204/255.0) alpha:1.0] CGColor];
    [self.view addSubview:circleView];
    self.circleView = circleView;
    
}

- (void)runAnimationWithImage
{
    UIImageView *imgView = [[UIImageView alloc] init];
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 68; i++) {
        NSString *filename = [NSString stringWithFormat:@"logo-%03d.png",i];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        NSString *filename = [NSString stringWithFormat:@"logo-%03d",i];
//        UIImage *image = [UIImage imageNamed:filename];
        [images addObject:image];
    }
    [imgView setImage:[UIImage imageNamed:@"logo-067"]];
    imgView.animationImages = images;
    imgView.animationDuration = 5.0;
    imgView.animationRepeatCount = 1;
    [imgView startAnimating];
    [self.view insertSubview:imgView atIndex:[[self.view subviews] count]];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(277, 277));
    }];
    
    CGFloat delay = imgView.animationDuration + 1.0;
    [imgView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:delay];
}

- (void)animationOfCABasicAnimation
{
    CGRect rx = [UIScreen mainScreen].bounds;
    CGFloat myW = rx.size.width - 20;
    self.circleView.frame = CGRectMake((rx.size.width-myW)/2, (rx.size.height-myW)/2, myW, myW);
    self.circleView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yyy"]];
    //将图层的边框设置为圆脚
    self.circleView.layer.cornerRadius = myW / 2;
    self.circleView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.circleView.layer.borderWidth = 2;
    self.circleView.layer.borderColor = [[UIColor colorWithRed:(33/255.0 ) green: (172/255.0) blue: (204/255.0) alpha:1.0] CGColor];
    
    [self.view addSubview:self.circleView];
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.circleView.layer.anchorPoint = CGPointMake(.5,.5);
    animation.fromValue = @0.0f;
    animation.toValue = @1.0f;
    //动画时间
    animation.duration=0.5;
    //是否反转变为原来的属性值
    //     animation.autoreverses=YES;
    //把animation添加到图层的layer中，便可以播放动画了。forKey指定要应用此动画的属性
    [self.circleView.layer addAnimation:animation forKey:@"scale"];
    [UIView animateWithDuration:3 animations:^{
        self.circleView.alpha = 0;
    }];
}

- (void)SetupVideoPlayer
{
    NSString *myFilePath = [[NSBundle mainBundle]pathForResource:@"welcome_video"ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:myFilePath];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [self.view insertSubview:self.player.view atIndex:[[self.view subviews] count] - 1];
    self.player.shouldAutoplay = YES;
    [self.player setControlStyle:MPMovieControlStyleNone];
    self.player.repeatMode = MPMovieRepeatModeOne;
    [self.player.view setFrame:self.view.bounds];
    self.player.view.alpha = 0;
    [UIView animateWithDuration:3 animations:^{
        self.player.view.alpha = 1;
        [self.player prepareToPlay];
    }];
    
    [self setupLoginView];
}

- (void)setupLoginView
{
    LZLoginView *loginView = [[LZLoginView alloc] init];
    loginView.alpha = 0.0;
    loginView.delegate = self;
    [self.player.view addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.player.view);
        make.bottom.equalTo(self.player.view.mas_bottom).with.offset(-20);
        make.height.equalTo(@35);
    }];
    
    [UIView animateWithDuration:3.0 animations:^{
        loginView.alpha = 1.0;
    }];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - LZLoginViewDelegate
- (void)loginView:(LZLoginView *)loginView didSelectButton:(KButtonType)buttonType
{
    switch (buttonType) {
        case KButtonLogin:
            [self loginAlert];
            break;
            
        case KDateButtonRegister:
            [self registerAlert];
            break;
    }
}

- (void)loginAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"1" message:@"1" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alertView show];
}

- (void)registerAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"2" message:@"2" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alertView show];
}

@end
