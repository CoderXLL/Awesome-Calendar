//
//  QQIMEmotionsCollectionViewFlowLayout.m
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/20.
//

#import "ASYearHorizontalLayout.h"
 
@interface ASYearHorizontalLayout () <UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray *allAttributes;
 
@end
 
@implementation ASYearHorizontalLayout
 
-(instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}
 
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.allAttributes = [NSMutableArray array];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (int i = 0; i < sections; i++)
    {   
        UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        [self.allAttributes addObject:headerAttributes];
        
        NSUInteger count = [self.collectionView numberOfItemsInSection:i];
        
        for (NSUInteger j = 0; j<count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.allAttributes addObject:attributes];
        }
    }
}
 
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.numberOfSections * self.collectionView.frame.size.width + (self.collectionView.numberOfSections - 1) * (self.sectionInset.left + self.sectionInset.right), self.collectionView.frame.size.height);
//    return [super collectionViewContentSize];
}
 
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    NSInteger row = item / self.itemCountPerRow;
    NSInteger colume = item % self.itemCountPerRow;
    NSInteger page = indexPath.section;
    theNewAttr.frame = CGRectMake(
                                  page * (self.collectionView.frame.size.width + self.sectionInset.left + self.sectionInset.right) + colume * (self.minimumLineSpacing  + theNewAttr.frame.size.width) + self.edgeSpacing,
                                  self.headerReferenceSize.height + row * (self.minimumLineSpacing + theNewAttr.frame.size.height),
                                  theNewAttr.frame.size.width,
                                  theNewAttr.frame.size.height);
    return theNewAttr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *headerAttributes = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    headerAttributes.frame = CGRectMake((self.headerReferenceSize.width + self.sectionInset.left + self.sectionInset.right) * indexPath.section, 0, self.headerReferenceSize.width, self.headerReferenceSize.height);
    return headerAttributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x;
    NSInteger page = proposedContentOffset.x / (self.collectionView.frame.size.width + self.sectionInset.left + self.sectionInset.right);
    NSArray *attributeArray = @[];

    if (page == 0) {
        UICollectionViewLayoutAttributes *currentAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:page]];
        UICollectionViewLayoutAttributes *lastAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:page + 1]];
        attributeArray = @[currentAttribute, lastAttribute];
    } else if (page == self.collectionView.numberOfSections - 1) {
        UICollectionViewLayoutAttributes *currentAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:page]];
        UICollectionViewLayoutAttributes *preAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:page - 1]];
        attributeArray = @[currentAttribute, preAttribute];
    } else {
        UICollectionViewLayoutAttributes *currentAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:page]];
        UICollectionViewLayoutAttributes *preAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:page - 1]];
        UICollectionViewLayoutAttributes *lastAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:page + 1]];
        attributeArray = @[currentAttribute, preAttribute, lastAttribute];
    }

    UICollectionViewLayoutAttributes *lala = nil;
    for (UICollectionViewLayoutAttributes *layoutAttributes in attributeArray) {
        CGFloat startX = layoutAttributes.frame.origin.x;
        if (ABS(startX - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = startX - horizontalCenter;
            lala = layoutAttributes;
        }
    }
    CGPoint targetContentOffset = CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    return targetContentOffset;
}
 
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.allAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
 
// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y
{
    NSUInteger page = item/(self.itemCountPerRow*self.rowCount);
    
    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self.rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
    
}
 
// 根据偏移量计算item
- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y
{
    NSUInteger item = x * self.rowCount + y;
    return item;
}
 
@end
