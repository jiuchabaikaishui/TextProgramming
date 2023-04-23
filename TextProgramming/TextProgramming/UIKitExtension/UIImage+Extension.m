//
//  UIImage+Extension.m
//  QSPTools
//
//  Created by QSP on 2022/10/26.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)imageToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [self drawInRect:(CGRect){{0, 0}, size}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)imageToSize:(CGSize)size completion:(void (^)(UIImage *image))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        [self drawInRect:(CGRect){{0, 0}, size}];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRestoreGState(context);
        UIGraphicsEndImageContext();
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }
    });
}
+ (void)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius completion:(void (^)(UIImage *image))completion {
    [self generateImageWithSize:size draw:^(CGSize size, CGContextRef context) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){{0, 0}, size} cornerRadius:radius];
        [color setFill];
        [path fill];
    } completion:^(UIImage *image) {
        if (completion) {
            completion(image);
        }
    }];
}
+ (void)generateImageWithSize:(CGSize)size draw:(void (^)(CGSize size, CGContextRef context))draw completion:(void (^)(UIImage *image))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        if (draw) {
            draw(size, context);
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRestoreGState(context);
        UIGraphicsEndImageContext();
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }
    });
}

+ (UIImage *)resizableImage:(UIImage *)image
{
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

@end
