//
//  LZLoginView.h
//  UBERWelcome
//
//  Created by nacker on 15/10/31.
//  Copyright © 2015年 nacker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KButtonLogin,
    KDateButtonRegister,
} KButtonType;

@class LZLoginView;

@protocol LZLoginViewDelegate <NSObject>

- (void)loginView:(LZLoginView *)loginView didSelectButton:(KButtonType)buttonType;

@optional

@end

@interface LZLoginView : UIView

@property (nonatomic, weak) id<LZLoginViewDelegate> delegate;

@end
