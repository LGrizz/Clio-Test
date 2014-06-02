//
//  Notes.h
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic) int uid;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *detail;

-(id)initWithJSON:(NSDictionary *)json;

@end
