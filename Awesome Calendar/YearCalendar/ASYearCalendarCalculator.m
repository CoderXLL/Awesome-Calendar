//
//  ASYearCalendarCalculator.m
//  Awesome Calendar
//
//  Created by 肖乐乐 on 2023/5/18.
//

#import "ASYearCalendarCalculator.h"
#import "FSCalendarExtensions.h"

@interface ASYearCalendarCalculator()
{
    NSDate *_minimumDate;
    NSDate *_maximumDate;
}

@property (nonatomic, assign, readwrite) NSInteger numberOfSections;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSCalendar *gregorian;

@property (strong, nonatomic) NSMutableDictionary<NSNumber *, NSDate *> *years;
@property (strong, nonatomic) NSMutableDictionary<NSNumber *, NSDate *> *yearHeads;

@property (strong, nonatomic) NSMutableDictionary<NSNumber *, NSDate *> *months;
@property (strong, nonatomic) NSMutableDictionary<NSNumber *, NSDate *> *monthHeads;

@property (nonatomic, strong) NSArray *lunnarGan;
@property (nonatomic, strong) NSArray *lunnarZhi;
@property (nonatomic, strong) NSArray *lunnarAnimal;

@end

@implementation ASYearCalendarCalculator

- (instancetype)init {
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

#pragma mark - private methods

- (void)initData {
    NSDate *newMin = [self.dateFormatter dateFromString:@"1970-01-01"];
    newMin = [self.gregorian startOfDayForDate:newMin];
    NSDate *newMax = [self.dateFormatter dateFromString:@"2099-12-31"];
    newMax = [self.gregorian startOfDayForDate:newMax];
    
    NSAssert([self.gregorian compareDate:newMin toDate:newMax toUnitGranularity:NSCalendarUnitDay] != NSOrderedDescending, @"The minimum date of calendar should be earlier than the maximum.");
    
    _minimumDate = newMin;
    _maximumDate = newMax;
    
    self.years = [NSMutableDictionary dictionary];
    self.months = [NSMutableDictionary dictionary];
    self.monthHeads = [NSMutableDictionary dictionary];
    
    self.lunnarGan = @[@"甲", @"乙", @"丙", @"丁", @"戊", @"己", @"庚", @"辛", @"壬", @"癸"];
    self.lunnarZhi = @[@"子", @"丑", @"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥"];
    self.lunnarAnimal = @[@"鼠", @"牛", @"虎", @"兔", @"龙", @"蛇", @"马", @"羊", @"猴", @"鸡", @"狗", @"猪"];
    
    self.numberOfSections = [self.gregorian components:NSCalendarUnitYear fromDate:[self.gregorian fs_firstDayOfMonth:_minimumDate] toDate:_maximumDate options:0].year + 1;
}

#pragma mark - public methods
// section 年  item 月
- (NSDate *)monthDateForIndexPath:(NSIndexPath *)indexPath {
    NSDate *year = [self yearHeadForSection:indexPath.section];
    NSUInteger monthOffset = indexPath.item;
    NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:monthOffset toDate:year options:0];
    return date;
}

- (NSDate *)monthHeadDateForIndexPath:(NSIndexPath *)indexPath {
    NSDate *month = [self monthDateForIndexPath:indexPath];
    NSInteger numberOfHeadPlaceholders = [self numberOfHeadPlaceholdersForMonth:month];
    NSDate *monthHead = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-numberOfHeadPlaceholders toDate:month options:0];
    return monthHead;
}

- (NSInteger)numberOfHeadPlaceholdersForMonth:(NSDate *)month {
    NSInteger currentWeekday = [self.gregorian component:NSCalendarUnitWeekday fromDate:month];
    NSInteger number = ((currentWeekday - self.gregorian.firstWeekday) + 7) % 7 ?: 0;
    return number;
}

- (NSInteger)numberOfDaysInMonth:(NSDate *)month {
    return [self.gregorian fs_numberOfDaysInMonth:month];
}

- (NSInteger)numberOfRowsInMonth:(NSDate *)month {
    NSDate *firstDayOfMonth = [self.gregorian fs_firstDayOfMonth:month];
    NSInteger weekdayOfFirstDay = [self.gregorian component:NSCalendarUnitWeekday fromDate:firstDayOfMonth];
    NSInteger numberOfDaysInMonth = [self numberOfDaysInMonth:month];
    NSInteger numberOfPlaceholdersForPrev = ((weekdayOfFirstDay - self.gregorian.firstWeekday) + 7) % 7;
    NSInteger headDayCount = numberOfDaysInMonth + numberOfPlaceholdersForPrev;
    NSInteger numberOfRows = (headDayCount/7) + (headDayCount%7>0);
    return numberOfRows;
}

- (NSDate *)yearHeadForSection:(NSInteger)section {
    NSNumber *key = @(section);
    NSDate *year = self.years[key];
    if (!year) {
        year = [self.gregorian dateByAddingUnit:NSCalendarUnitYear value:section toDate:[self.gregorian fs_firstDayOfMonth:_minimumDate] options:0];
        self.years[key] = year;
    }
    return year;
}

- (NSDate *)dayDateForMonthDate:(NSDate *)monthHeadDate row:(NSInteger)row; {
    NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:row toDate:monthHeadDate options:0];
    return date;
}

- (NSCalendar *)getCurrentCalendar {
    return self.gregorian;
}

- (NSString *)lunnarYearString:(NSInteger)year {
    int ganIndex = (year - 4) % 10;
    int zhiIndex = (year - 4) % 12;
    return [NSString stringWithFormat:@"%@%@%@年", self.lunnarGan[ganIndex], self.lunnarZhi[zhiIndex], self.lunnarAnimal[zhiIndex]];
}

#pragma mark - lazy loading

- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (NSCalendar *)gregorian {
    if (_gregorian == nil) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _gregorian.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        _gregorian.firstWeekday = 1;
    }
    return _gregorian;
}

@end
