//
//  LZLoginView.m
//  UBERWelcome
//
//  Created by nacker on 15/10/31.
//  Copyright © 2015年 nacker. All rights reserved.
//

#import "LZLoginView.h"
#import "Masonry.h"

@interface LZLoginView()

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation LZLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.loginBtn = [self setupButtonWithTitle:@"登录" color:[UIColor blackColor] bgColor:KColor(255, 255, 255) index:KButtonLogin];
        self.registerBtn = [self setupButtonWithTitle:@"注册" color:[UIColor whiteColor] bgColor:KColor(33, 172, 204) index:KDateButtonRegister];
    }
    return self;
}

- (UIButton *)setupButtonWithTitle:(NSString *)title color:(UIColor *)color bgColor:(UIColor *)bgColor index:(KButtonType)index
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = index;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button setTintColor:[UIColor whiteColor]];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(loginView:didSelectButton:)]) {
        [self.delegate loginView:self didSelectButton:btn.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int padding = 20;
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(padding);
        //            make.top.bottom.equalTo(self);
        make.right.equalTo(self.registerBtn.mas_left).with.offset(-padding);
        make.width.equalTo(self.registerBtn);
        make.bottom.top.equalTo(self);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBtn.mas_right).with.offset(padding);
        make.right.equalTo(self.mas_right).with.offset(-padding);
        make.width.equalTo(self.loginBtn);
        make.bottom.top.equalTo(self);
    }];
}
@end
