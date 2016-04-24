//
//  Contatos.h
//  ContatosIP67
//
//  Created by Marcos Felipe Souza on 27/11/15.
//  Copyright © 2015 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface Contatos : NSManagedObject <MKAnnotation>

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *endereco;
@property (strong) NSString *email;
@property (strong) NSString *site;
@property (strong) UIImage *foto;


@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;
@end
