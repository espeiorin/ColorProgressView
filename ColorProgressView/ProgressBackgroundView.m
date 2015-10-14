//
//  ProgressBackgroundView.m
//
//  Created by Ralph Shane on 10/13/15.
//

#import "ProgressBackgroundView.h"

@implementation ProgressBackgroundView {
    CAShapeLayer *_maskLayer;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initShapeLayer];
    }
    return self;
}

- (void) initShapeLayer {
    //create shape layer
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.strokeColor = [UIColor redColor].CGColor;
    _maskLayer.fillColor = [UIColor clearColor].CGColor;
    _maskLayer.lineWidth = 5;
    _maskLayer.lineJoin = kCALineJoinRound;
    _maskLayer.lineCap = kCALineCapRound;

    [self.layer setMask:_maskLayer];
}

- (void) drawEmptyLine {
    CGRect rc = self.bounds;
    CGFloat radius = rc.size.height / 2;
    CGFloat xEnd = rc.size.width - radius * 2;

    // create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(radius, radius)];
    [path addLineToPoint:CGPointMake(xEnd, radius)];

    _maskLayer.path = path.CGPath;
    _maskLayer.lineWidth = radius * 2;
}

- (void) grayLineRender {
    CGFloat components[12] = {
        0.0, 0.0, 0.0, 0.1,     //start color(r,g,b,alpha)
        1.0, 1.0, 1.0, 0.5,
        0.0, 0.0, 0.0, 0.1,     //end color
    };
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,3);
    CGContextRef graCtx = UIGraphicsGetCurrentContext();

    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);

    CGContextDrawLinearGradient(graCtx, gradient, startPoint, endPoint, 0);
}

- (void)drawRect:(CGRect)rect {
    [self drawEmptyLine];
    [self grayLineRender];
}

@end
