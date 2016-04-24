//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 15/01/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ContatoDao.h"

@interface ContatosNoMapaViewController : UIViewController <MKMapViewDelegate>

@property ContatoDao *dao;
@property (nonatomic, weak) NSMutableArray *contatos;
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property CLLocationManager *locationManager;

@end
