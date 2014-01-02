//
//  ViewController.h
//  CABasicAnimation
//
//  Created by Sergio on 26/12/13.
//  Copyright (c) 2013 s0mniloquia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController

@property CALayer * capa_contenedora;
@property CALayer * bola_azul;
@property CALayer * bola_roja;
@property CALayer * bola_verde;
@property CALayer * bola_amarilla;
@property CABasicAnimation * rotation;
@property NSArray * textosBoton;

@property (weak, nonatomic) IBOutlet UIButton *rotarBoton;

- (IBAction)accionBoton:(id)sender;


@property float speed;

@end
