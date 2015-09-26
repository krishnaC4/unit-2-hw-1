//
//  FourSquareAnnotation.m
//  KPgoLoco
//
//  Created by MacMan on 9/25/15.
//  Copyright © 2015 MacManApp. All rights reserved.
//

#import "FoursquareAnnotation.h"


@implementation FoursquareAnnotation


@synthesize coordinate;
@synthesize title;
@synthesize subtitle;



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
       //[self superclass];
        
    }
    return self;

}


/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/

@end
