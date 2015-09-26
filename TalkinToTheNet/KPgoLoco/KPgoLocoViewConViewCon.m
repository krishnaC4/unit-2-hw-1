//
//  KPgoLocoViewConViewCon.m
//  KPgoLoco
//
//  Created by MacMan on 9/25/15.
//  Copyright © 2015 MacManApp. All rights reserved.
//


#import <MapKit/MapKit.h>
#import "KPgoLocoViewConViewCon.h"
#import "SBJSON4.h"
#import "FoursquareAnnotation.h"

@interface KPgoLocoViewConViewCon ()

@end

@implementation KPgoLocoViewConViewCon

@synthesize mvFoursquare;
@synthesize userCurrentLocation;
@synthesize urlConnection;
@synthesize mutableData;




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMutableData:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self setMutableData: nil];
    
    [mapView removeAnnotations: [mapView annotations]];
    
    NSString *stringURL = [NSString stringWithFormat: @"https://api.foursquare.com/v2/venues/search?ll=%f,%f&client_id=TRVGUWRGA0LPBCQGL5OFNSTMXUYT05JR4SIRPHNSTE43YQNU&client_secret=DRCHGGJGOYXUH5L0GL444J3ZSKWKZZ2P4DH0GIM5QVM0ATCR", [userLocation coordinate].latitude, [userLocation coordinate].longitude];
    NSURL *URLWithString = [NSURL URLWithString: stringURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: URLWithString cachePolicy: NSURLRequestReloadIgnoringCacheData timeoutInterval: 30.f];
    urlConnection = [[NSURLConnection alloc] initWithRequest: urlRequest delegate: self];
    
    CLLocationCoordinate2D userCoords = [userLocation coordinate];
    MKCoordinateRegion region = { { userCoords.latitude , userCoords.longitude }, { 0.009f , 0.009f } };
    [mapView setRegion: region animated: YES];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (mutableData == nil)
    {
        mutableData = [[NSMutableData alloc] init];
    }
    
    [mutableData appendData: data];
}








- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   SBJson4Parser *jsonParser = [[SBJson4Parser alloc] init];
    
    NSString *strData = [[NSString alloc] initWithData: mutableData encoding: NSUTF8StringEncoding];
    
    NSDictionary *dictVenues = [jsonParser objectWithString: strData error: nil];
    NSDictionary *items = [[[[dictVenues objectForKey: @"response"] objectForKey: @"groups"] objectAtIndex: 0] objectForKey: @"items"];
    
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (NSDictionary *venues in items)
    {
        NSString *name = [venues objectForKey: @"name"];
        NSString *address = [[venues objectForKey: @"location"] objectForKey: @"address"];
        
        CGFloat latitude = [[[venues objectForKey: @"location"] objectForKey: @"lat"] floatValue];
        CGFloat longitude = [[[venues objectForKey: @"location"] objectForKey: @"lng"] floatValue];
        
        FoursquareAnnotation *foursquareAnnotation = [[FoursquareAnnotation alloc] init];
        MKCoordinateRegion region = { { latitude , longitude } , { 0.01f , 0.01f } };
        
        [FoursquareAnnotation setCoordinate: region.center];
        [FoursquareAnnotation title: name];
        [FoursquareAnnotation subtitle: address];
        
        [annotations addObject: foursquareAnnotation];
       // [foursquareAnnotation release];
    }
    
    [mvFoursquare addAnnotations: annotations];
    
//    [jsonParser release];
//    [strData release];
//    [annotations release];
    
    [self setMutableData: nil];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
