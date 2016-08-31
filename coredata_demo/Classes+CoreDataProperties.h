//
//  Classes+CoreDataProperties.h
//  coredata_demo
//
//  Created by Dylan on 16/8/31.
//  Copyright © 2016年 Dylan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Classes (CoreDataProperties)

@property (nonatomic) int64_t c_id;
@property (nullable, nonatomic, retain) NSString *c_name;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *c_stus;

@end

@interface Classes (CoreDataGeneratedAccessors)

- (void)addC_stusObject:(NSManagedObject *)value;
- (void)removeC_stusObject:(NSManagedObject *)value;
- (void)addC_stus:(NSSet<NSManagedObject *> *)values;
- (void)removeC_stus:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
