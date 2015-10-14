//
//  ProgressBackgroundView.m
//
//  Created by Ralph Shane on 10/13/15.
//

#import "ProgressBackgroundView.h"

@implementation ProgressBackgroundView {
    CAShapeLayer *_shapeLayer;
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
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = 5;
    _shapeLayer.lineJoin = kCALineJoinRound;
    _shapeLayer.lineCap = kCALineCapRound;

    [self.layer setMask:_shapeLayer];
}

- (void) drawEmptyLine {
    CGRect rc = self.bounds;
    CGFloat radius = rc.size.height / 2;
    CGFloat xEnd = rc.size.width - radius * 2;

    // create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(radius, radius)];
    [path addLineToPoint:CGPointMake(xEnd, radius)];

    _shapeLayer.path = path.CGPath;
    _shapeLayer.lineWidth = radius * 2;
}

- (void) ddd {
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

//- (void)layoutSubviews {
//    [super layoutSubviews];
//}

- (void)drawRect:(CGRect)rect {
    [self drawEmptyLine];
    [self ddd];
}

@end
