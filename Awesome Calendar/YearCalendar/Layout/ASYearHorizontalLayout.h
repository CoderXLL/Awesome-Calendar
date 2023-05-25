//
//  ASYearHorizontalLayout.h
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASYearHorizontalLayout : UICollectionViewFlowLayout

//  一行中 cell 的个数
@property (nonatomic,assign) NSUInteger itemCountPerRow;
 
//    一页显示多少行
@property (nonatomic,assign) NSUInteger rowCount;

@property (nonatomic, assign) CGFloat edgeSpacing;

@end

NS_ASSUME_NONNULL_END
