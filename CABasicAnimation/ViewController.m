//
//  ViewController.m
//  CABasicAnimation
//
//  Created by Sergio on 26/12/13.
//  Copyright (c) 2013 s0mniloquia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    @property CGPoint actualizarPunto;
@end

@implementation ViewController

@synthesize bola_azul;
@synthesize bola_roja;
@synthesize bola_amarilla;
@synthesize bola_verde;
@synthesize rotation;
@synthesize capa_contenedora;
@synthesize speed;
@synthesize textosBoton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textosBoton = [[NSArray alloc] initWithObjects:@"Rotar",@"Parar",@"Para, para",@"Paaarar",@"Ostiaaaa", nil];
    
    self.rotarBoton.tag=0;
    [self.rotarBoton setTitle:[textosBoton objectAtIndex:self.rotarBoton.tag] forState:UIControlStateNormal];
    
    
    capa_contenedora = [CALayer layer];
    capa_contenedora.bounds = CGRectMake(0,0,200,200);
    capa_contenedora.position = self.view.center;
    capa_contenedora.anchorPoint = CGPointMake(0.5,0.5);
    
    bola_azul = [CALayer layer];
    bola_azul.bounds = CGRectMake(0, 0, 50, 50);
    bola_azul.backgroundColor=[UIColor blueColor].CGColor;
    bola_azul.cornerRadius = 25.0f;
    bola_azul.position = CGPointMake(CGRectGetMidX(capa_contenedora.bounds), 0);
    bola_azul.anchorPoint = CGPointMake(0.5, 0);
    
    bola_verde = [CALayer layer];
    bola_verde.bounds = CGRectMake(0, 0, 50, 50);
    bola_verde.backgroundColor = [UIColor greenColor].CGColor;
    bola_verde.cornerRadius = 25.0f;
    bola_verde.position = CGPointMake(0,CGRectGetMidY(capa_contenedora.bounds));
    bola_verde.anchorPoint = CGPointMake(0, 0.5);
    
    bola_roja = [CALayer layer];
    bola_roja.bounds = CGRectMake(0, 0, 50, 50);
    bola_roja.backgroundColor = [UIColor redColor].CGColor;
    bola_roja.cornerRadius = 25.0f;
    bola_roja.position = CGPointMake(CGRectGetMidX(capa_contenedora.bounds),CGRectGetMaxY(capa_contenedora.bounds));
    bola_roja.anchorPoint = CGPointMake(0.5, 1);
    
    bola_amarilla = [CALayer layer];
    bola_amarilla.bounds = CGRectMake(0, 0, 50, 50);
    bola_amarilla.backgroundColor = [UIColor yellowColor].CGColor;
    bola_amarilla.cornerRadius = 25.0f;
    bola_amarilla.position = CGPointMake(CGRectGetMaxX(capa_contenedora.bounds),CGRectGetMidY(capa_contenedora.bounds));
    bola_amarilla.anchorPoint = CGPointMake(1,0.5);
    
    [self.view.layer addSublayer:capa_contenedora];
    [capa_contenedora addSublayer:bola_azul];
    [capa_contenedora addSublayer:bola_verde];
    [capa_contenedora addSublayer:bola_roja];
    [capa_contenedora addSublayer:bola_amarilla];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)accionBoton:(id)sender {
    
    
    if(self.rotarBoton.tag != 4){
        self.rotarBoton.tag = self.rotarBoton.tag+1;
        [self.rotarBoton setTitle:[textosBoton objectAtIndex:self.rotarBoton.tag] forState:UIControlStateNormal];
        
        [capa_contenedora removeAllAnimations];
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.repeatCount = HUGE_VALF;
        float angulo = 3*360*M_PI/180;
        animation.duration = 10;
        
        animation.speed = self.rotarBoton.tag*2;
        animation.toValue = [NSNumber numberWithFloat:angulo];
        [capa_contenedora addAnimation:animation forKey:@"rotando"];
    }else{
        [capa_contenedora removeAllAnimations];
        self.rotarBoton.enabled = NO;
        [self.rotarBoton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self.rotarBoton setTitle:@"Fin" forState:UIControlStateDisabled];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationAllBolitas:) userInfo:nil repeats:NO];
    
    }
    
    
}

- (void) animarPosition:(CALayer *)bolitaAMover{
    //Calculamos el punto que ocuparia la posicion de la bola respecto al layer general.
    CGPoint point = [capa_contenedora convertPoint:bolitaAMover.position toLayer:self.view.layer];
    
    //Calculamos la coordenada y del punto maximo inferior que ocuparia el layer general.
    point.y = CGRectGetMaxY(self.view.layer.bounds);
    
    //Calculamos el punto maximo inferior del layer general respecto a la capa contenedora.
    CGPoint pointFinal = [self.view.layer convertPoint:point toLayer:capa_contenedora];
    
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation2.fromValue = [NSValue valueWithCGPoint:bolitaAMover.position];
    bolitaAMover.position = pointFinal;
    
    float coorXAnchorPointBolita = bolitaAMover.anchorPoint.x;
    bolitaAMover.anchorPoint = CGPointMake(coorXAnchorPointBolita,1);
    
    animation2.toValue = [NSValue valueWithCGPoint:pointFinal];
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    //Calculamos el tiempo que ha de tardar en caer la bola en funcion de la distancia que ha de recorrer
    animation2.duration = (pointFinal.y-bolitaAMover.position.y)/100;
    
    
    [bolitaAMover addAnimation:animation2 forKey:@"mueveMueve"];

}

-(void) animationAllBolitas:(NSTimer *)timer{
    [self animarPosition:bola_roja];
    [self animarPosition:bola_amarilla];
    [self animarPosition:bola_azul];
    [self animarPosition:bola_verde];
}
@end
