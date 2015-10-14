//
//  ProgressFrontView.m
//
//  Created by Ralph Shane on 10/13/15.
//

#import "ProgressFrontView.h"

#define kCircleDegree 360
#define kColorGreen   0.4


@implementation ProgressFrontView {
    CAGradientLayer *_colorLayer;
    CAShapeLayer *_maskLayer;
    NSArray *_cachedColors;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        _colorLayer = [self createColorLayer];
        _maskLayer = [self createMaskLayer];

        [_colorLayer setMask:_maskLayer];
        [self.layer addSublayer:_colorLayer];

        _cachedColors = _colorLayer.colors.copy;
    }
    return self;
}

- (CAGradientLayer *) createColorLayer {
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.startPoint = CGPointMake(0.0, 0.5);
    layer.endPoint = CGPointMake(1.0, 0.5);

    NSMutableArray *_colors = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i <= kCircleDegree*kColorGreen; i+=5) {
        UIColor *color = [UIColor colorWithHue:(1.0*i/kCircleDegree)
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
        [_colors addObject:(id)color.CGColor];
    }
    layer.colors = _colors;

    return layer;
}

- (CAShapeLayer *) createMaskLayer {
    // 设置蒙板 .
    CAShapeLayer *layer = [CAShapeLayer layer];

    layer.fillColor = [[UIColor clearColor]CGColor];
    layer.strokeColor = [[UIColor redColor] CGColor];
    layer.backgroundColor = [[UIColor clearColor] CGColor];
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineCapRound;
    layer.frame = CGRectMake(0, 0, 0, 0);

    return layer;
}

- (void) colorsShift {
    int count = _cachedColors.count;
    if (count) {
        int index = MIN((int)(_progress * count), count-1);
        [_colorLayer setColors: @[ _cachedColors[index], _cachedColors[index] ] ];
    }
}

- (void) doDrawing {
    CGRect rc = self.bounds;
    CGFloat radius = rc.size.height / 2;
    CGFloat xEnd = rc.size.width - radius * 2;

    _colorLayer.frame = rc;

    _maskLayer.frame = rc;
    _maskLayer.lineWidth = (radius - 1) * 2;

    // create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(radius, radius)];
    [path addLineToPoint:CGPointMake(xEnd, radius)];

    _maskLayer.path = path.CGPath;

    _maskLayer.strokeEnd = (_progress>0.005) ? _progress : 0.005;

    if (_singleColor) {
        [self colorsShift];
    }
}

// 设置阴影 .
- (void) doShadow {
    self.layer.shadowOffset = CGSizeMake(5, 5); // 设置阴影的偏移量 .
    self.layer.shadowRadius = 5.0;  // 设置阴影的半径 .
    self.layer.shadowColor = [UIColor blackColor].CGColor; // 设置阴影的颜色为黑色 .
    self.layer.shadowOpacity = 1; // 透明度 .
}

- (void)drawRect:(CGRect)rect {
    [self doDrawing];
    [self doShadow];
}

- (void) setProgress:(CGFloat)progress {
    _progress = MIN(1.0, fabs(progress));
    [self setNeedsDisplay];
}

- (void) setSingleColor:(BOOL)singleColor {
    _singleColor = singleColor;
    [self setNeedsDisplay];
}

@end
