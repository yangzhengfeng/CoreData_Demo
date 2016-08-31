//
//  Student+CoreDataProperties.h
//  coredata_demo
//
//  Created by Dylan on 16/8/31.
//  Copyright © 2016年 Dylan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nonatomic) int64_t s_id;
@property (nullable, nonatomic, retain) NSString *s_name;
@property (nullable, nonatomic, retain) Classes *s_class;

@end

NS_ASSUME_NONNULL_END
