//
//  UIImage+Extension.h
//  QSPTools
//
//  Created by QSP on 2022/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

- (UIImage *)imageToSize:(CGSize)size;

+ (void)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius completion:(void (^)(UIImage *image))completion;

+ (UIImage *)resizableImage:(UIImage *)image;

+ (void)generateImageWithSize:(CGSize)size draw:(void (^)(CGSize size, CGContextRef context))draw completion:(void (^)(UIImage *image))completion;

@end

NS_ASSUME_NONNULL_END
