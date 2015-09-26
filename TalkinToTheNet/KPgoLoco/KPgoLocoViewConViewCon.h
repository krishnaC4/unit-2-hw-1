//
//  KPgoLocoViewConViewCon.h
//  KPgoLoco
//
//  Created by MacMan on 9/25/15.
//  Copyright © 2015 MacManApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface KPgoLocoViewConViewCon : UIViewController <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mvFoursquare;

@property (nonatomic, weak) MKUserLocation *userCurrentLocation;

@property (nonatomic, strong) NSURLConnection *urlConnection;

@property (nonatomic, copy) NSMutableData *mutableData;






@end
