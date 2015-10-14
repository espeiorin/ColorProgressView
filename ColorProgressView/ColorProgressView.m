//
//  ColorProgressView.m
//
//  Created by Ralph Shane on 10/12/15.
//

#import "ColorProgressView.h"
#import "ProgressBackgroundView.h"
#import "ProgressFrontView.h"

@implementation ColorProgressView {
    ProgressBackgroundView *_backgroundView;
    ProgressFrontView *_frontView;
}

//+ (Class) layerClass {
//    return [CAGradientLayer class];
//}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _backgroundView = [[ProgressBackgroundView alloc] initWithFrame:frame];
        _frontView = [[ProgressFrontView alloc] initWithFrame:frame];
        [self addSubview:_backgroundView];
        [self addSubview:_frontView];
    }
    return self;
}

- (void) setProgress:(CGFloat)progress {
    _progress = MIN(1.0, fabs(progress));
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {
    _backgroundView.frame = rect;
    _frontView.frame = rect;
    _frontView.progress = _progress;
}

@end
