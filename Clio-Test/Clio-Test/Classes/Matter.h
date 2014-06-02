//
//  Matters.h
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import <Foundation/Foundation.h>

@interface Matter : NSObject

@property (nonatomic) int uid;
@property (nonatomic, strong) NSString *name;

-(id)initWithJSON:(NSDictionary *)json;

@end
