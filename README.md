# google_ployline
In appdelegate.m you have to import 2 headers namely:-

@import GoogleMaps;
@import GooglePlaces;

And have to enter the API-Key in didFinishLaunchingWithOptions. like this

    [GMSServices provideAPIKey:@"AIzaSyAJmV9MhASB4xHzeHMTc-K9ASXjuFYHAVg"];
    
    [GMSPlacesClient provideAPIKey:@"AIzaSyAJmV9MhASB4xHzeHMTc-K9ASXjuFYHAVg"];
    
   Add this frameworks in podfile
     pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'GoogleMaps'

add a UIview to storyboard and name it as "map_view",click the show the identity inspector.
give the class as "GMSMapview" this is manditory.

drag the view to viewcontroller it will show like below:

@property (strong, nonatomic) IBOutlet GMSMapView *map_view;

Add this code to viewdidload() you will get current location:-

 GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:13.0515
                                                            longitude:80.2498
                                                                 zoom:15];
      _map_view.myLocationEnabled = YES;
    _map_view.camera =camera;
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(13.0515, 80.2498);
    marker.title = @"Chennai";
    marker.snippet = @"India";
    marker.map = _map_view;
    
    Here i used the mvplacesearchtextfield to search the googleplaces and suggestion,for that use have to use the classfiles of mvplacesearch.
    give the class as "mvplacesearchtextfield" to that text_field.(for further Explaination refer viewcontroller.m).
    
    To Get Destination and polyline between source and destination refer method(getLocationFromAddressString:) in viewcontroller.m
    
    
    
    
