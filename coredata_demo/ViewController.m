//
//  ViewController.m
//  coredata_demo
//
//  Created by Dylan on 16/8/31.
//  Copyright © 2016年 Dylan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}


- (IBAction)btnInsert:(UIButton *)sender {
    
    [self insertWithClassName:@"小明" withClassId:1 withStudentName:@"小明" withStudentId:1];
}


- (IBAction)btnSelectAll:(UIButton *)sender {
    
    [self selectAll];
}


- (IBAction)btnUpdate:(UIButton *)sender {
    
    [self update];
}


- (IBAction)btnDelete:(UIButton *)sender {
    
    [self delete];
}






// 1、 向学生表中插入一条数据
//在使用Core Data的时候，AppDelegate中添加了NSManagedObjectContext对象，需要获得这个管理对象的上下文来进行操作。在操作的过程中，需要得到NSManagedObject实体，然后通过kvc设置实体的属性值，最后通过上下文调用save方法保存数据。

- (void)insertWithClassName:(NSString*)className withClassId:(NSInteger)classId withStudentName:(NSString*)studentName withStudentId:(NSInteger)studentId {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    //1. 获得context
    NSManagedObjectContext *context = delegate.managedObjectContext;
    //2. 找到实体结构,并生成一个实体对象
    /*     NSEntityDescription实体描述，也就是表的结构
     参数1：表名字     参数2:实例化的对象由谁来管理，就是context     */
    NSManagedObject *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    NSManagedObject *class1 = [NSEntityDescription insertNewObjectForEntityForName:@"Classes" inManagedObjectContext:context];
    
    [class1 setValue:[NSNumber numberWithInteger:classId] forKey:@"c_id"];
    [class1 setValue:className forKey:@"c_name"];
    
    //3. 设置实体属性值
    [stu setValue:[NSNumber numberWithInteger:studentId] forKey:@"s_id"];
    [stu setValue:studentName forKey:@"s_name"];
    [stu setValue:class1 forKey:@"s_class"];
    
    //4. 调用context,保存实体,如果没有成功，返回错误信息
    NSError *error;
    if ([context save:&error]) {
        NSLog(@"save ok");
    }    else    {
        NSLog(@"%@",error);
    }
}


//2、查询学生表中全部数据
//　　查询与插入数据操作类似，但是多了构造查询对象的步骤，查询得到结果集是一个数组，遍历数组，可以取出查询数据。

- (void)selectAll {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *stu = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    //构造查询对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:stu];
    //执行查询，返回结果集
    NSArray *resultAry = [context executeFetchRequest:request error:nil];
    //遍历结果集
    for (NSManagedObject *enity in resultAry) {
        
        NSNumber* s_id = [enity valueForKey:@"s_id"];
        NSString* s_name = [enity valueForKey:@"s_name"];
        NSString* c_name = [[enity valueForKey:@"s_class"] valueForKey:@"c_name"];
        
        NSLog(@"id=%@ name=%@ class=%@",s_id,s_name,c_name);
    }
}


//3、查询指定条件的学生信息，并更新
//　　指定条件的查询除了需要构造查询对象，还需要把查询的条件用谓词表示。然后遍历查询结果数组中的数据，进行更行，并保存。

- (void)update{
    //    更新 (从数据库找到-->更新)
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *stu = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:stu];
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"s_id=%i",1];
    //把查询条件放进去
    [request setPredicate:predicate];
    //执行查询
    NSArray *studentAry = [context executeFetchRequest:request error:nil];
    if (studentAry.count>0)    {
        //更新里面的值
        NSManagedObject *obj = studentAry[0];
        [obj setValue:@"小红" forKey:@"s_name"];
    }    [context save:nil];
    //显示
    [self selectAll];
}


//4、删除指定条件的学生信息
//　　删除之前首先需要根据条件进行查询，查询到数据后删除，并保存。

- (void)delete{
    //删除 先找到，然后删除
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *stu = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:stu];
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"s_id=%i",1];
    //把查询条件放进去
    [request setPredicate:predicate];
    //执行查询
    NSManagedObject *obj = [[context executeFetchRequest:request error:nil] lastObject];
    //删除
    if (obj) {
        [context deleteObject:obj];
        [context save:nil];
    }
    [self selectAll];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
