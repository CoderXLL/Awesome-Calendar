//
//  ASYearCalendarCalculator.h
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASYearCalendarCalculator : NSObject

@property (readonly, nonatomic) NSInteger numberOfSections;

- (NSDate *)monthDateForIndexPath:(NSIndexPath *)indexPath;
- (NSDate *)monthHeadDateForIndexPath:(NSIndexPath *)indexPath;

- (NSDate *)yearHeadForSection:(NSInteger)section;
- (NSDate *)dayDateForMonthDate:(NSDate *)monthHeadDate row:(NSInteger)row;

- (NSInteger)numberOfHeadPlaceholdersForMonth:(NSDate *)month;
- (NSInteger)numberOfDaysInMonth:(NSDate *)month;
- (NSInteger)numberOfRowsInMonth:(NSDate *)month;

- (NSString *)lunnarYearString:(NSInteger)year;

- (NSCalendar *)getCurrentCalendar;


@end

NS_ASSUME_NONNULL_END
