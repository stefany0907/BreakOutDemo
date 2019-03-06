//
//  GameScene.m
//  BreakOutDemo
//
//  Created by Matt Chen on 2/27/19.
//  Copyright © 2019 Matt Chen. All rights reserved.
//

#import "GameScene.h"
static const CGFloat kTracePointsPerSecond = 1000;

static const uint32_t category_fence    = 0x1 << 3;
static const uint32_t category_paddle   = 0x1 << 2;
static const uint32_t category_block    = 0x1 << 1;
static const uint32_t category_ball     = 0x1 << 0;

@interface GameScene() <SKPhysicsContactDelegate>
@property (nonatomic, strong, nullable) UITouch *motivatingTouch;

@end


@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
    self.name = @"Fence";
    // Setup your scene here
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = category_fence;
    self.physicsBody.collisionBitMask = 0x0;
    self.physicsBody.contactTestBitMask = 0x0;
    
    self.physicsWorld.contactDelegate = self;
    
    SKSpriteNode *background = (SKSpriteNode *)[self childNodeWithName:@"Background.png"];
    background.zPosition = 0; // below all the things drawn
    
    /*
    SKSpriteNode *ball1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueball.png"];
    ball1.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball1.size.width/2];
    ball1.zPosition = 1; // layer 1
    ball1.physicsBody.dynamic = YES;
    ball1.position = CGPointMake(10, self.size.height * 0.9);
    ball1.physicsBody.friction = 0.0;
    ball1.physicsBody.restitution = 1.0;
    ball1.physicsBody.linearDamping = 0.0;
    ball1.physicsBody.angularDamping = 0.0;
    ball1.physicsBody.allowsRotation = NO;
    ball1.physicsBody.mass = 1.0;
    ball1.physicsBody.velocity = CGVectorMake(200.0, 200.0);
    ball1.physicsBody.affectedByGravity = NO;
    ball1.physicsBody.categoryBitMask = category_ball;
    ball1.physicsBody.collisionBitMask = category_fence | category_ball;
    ball1.physicsBody.contactTestBitMask = category_fence | category_ball;
    ball1.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    SKSpriteNode *ball2 = [SKSpriteNode spriteNodeWithImageNamed:@"redball.png"];
    ball2.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball2.size.width/2];
    ball2.physicsBody.dynamic = YES;
    ball2.position = CGPointMake(150, self.size.height/2);
    ball2.physicsBody.friction = 0.0;
    ball2.physicsBody.restitution = 1.0;
    ball2.physicsBody.linearDamping = 0.0;
    ball2.physicsBody.angularDamping = 0.0;
    ball2.physicsBody.allowsRotation = NO;
    ball2.physicsBody.mass = 1.0;
    ball2.physicsBody.velocity = CGVectorMake(0.0, 0.0);
     
    [self addChild:ball1];
    */
    /*
    SKSpriteNode *paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle.png"];
    paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(paddle.size.width, paddle.size.height)];
    paddle.name = @"Paddle";
    paddle.physicsBody.dynamic = NO;
    paddle.position = CGPointMake(self.size.width/2, 100);
    paddle.physicsBody.friction = 0.0;
    paddle.physicsBody.restitution = 1.0;
    paddle.physicsBody.linearDamping = 0.0;
    paddle.physicsBody.angularDamping = 0.0;
    paddle.physicsBody.allowsRotation = NO;
    paddle.physicsBody.mass = 1.0;
    paddle.physicsBody.velocity = CGVectorMake(0.0, 0.0);
    */
    
//    [self addChild:ball2];
//    [self addChild:paddle];
    
    /*
    CGPoint ball1Anchor = CGPointMake(ball1.position.x, ball1.position.y);
    CGPoint ball2Anchor = CGPointMake(ball2.position.x, ball2.position.y);
    SKPhysicsJointSpring *joint = [SKPhysicsJointSpring jointWithBodyA:ball1.physicsBody
                                                                 bodyB:ball2.physicsBody
                                                               anchorA:ball1Anchor
                                                               anchorB:ball2Anchor];
    
    joint.damping = 0.0;
    joint.frequency = 1.5;
    [self.scene.physicsWorld addJoint:joint];
     */
    /*
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    
    _label.alpha = 0.0;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];
    
    CGFloat w = (self.size.width + self.size.height) * 0.05;
    
    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;
    
    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction waitForDuration:0.5],
                                                [SKAction fadeOutWithDuration:0.5],
                                                [SKAction removeFromParent],
                                                ]]];
     */
}


- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    const CGRect touchRegion = CGRectMake(0, 0, self.size.width, self.size.height);
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInNode:self];
        if (CGRectContainsPoint(touchRegion, p)) {
            self.motivatingTouch = touch;
        }
    }
    [self addNewUserBall];
//    [self trackPaddlesToMotivatingTouches];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
    [self trackPaddlesToMotivatingTouches];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
    if ([touches containsObject:self.motivatingTouch]) {
        self.motivatingTouch = nil;
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
    if ([touches containsObject:self.motivatingTouch]) {
        self.motivatingTouch = nil;
    }
}

- (void)addNewUserBall {
    NSLog(@"add new user ball");
    UITouch *touch = self.motivatingTouch;
    if (!touch) return;
    CGFloat xPos = [touch locationInNode:self].x;
    CGFloat yPos = [touch locationInNode:self].y;
    SKSpriteNode *ball3 = [SKSpriteNode spriteNodeWithImageNamed:@"greenball.png"];
    ball3.name = @"ball";
    ball3.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball3.size.width/2];
    ball3.physicsBody.dynamic = YES;
    ball3.position = CGPointMake(xPos, yPos);
    ball3.physicsBody.friction = 0.1;
    ball3.physicsBody.restitution = 0.7;
    ball3.physicsBody.linearDamping = 0.1; // air friction
    ball3.physicsBody.angularDamping = 0.1;
    ball3.physicsBody.allowsRotation = YES;
    ball3.physicsBody.mass = 1.0;
    ball3.physicsBody.velocity = CGVectorMake(200.0, 200.0);
    
    ball3.physicsBody.categoryBitMask = category_ball;
    ball3.physicsBody.collisionBitMask = category_fence | category_ball;
    ball3.physicsBody.contactTestBitMask = category_fence | category_ball;
    
    ball3.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:ball3];
    
}

- (void)trackPaddlesToMotivatingTouches {
    SKNode *node = [self childNodeWithName:@"Paddle"];
    UITouch *touch = self.motivatingTouch;
    if (!touch) return;
    CGFloat xPos = [touch locationInNode:self].x;
    NSTimeInterval duration = ABS(xPos - node.position.x) / kTracePointsPerSecond;
    [node runAction:[SKAction moveToX:xPos duration:duration]];
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSString *nameA = contact.bodyA.node.name;
    NSString *nameB = contact.bodyB.node.name;
    NSLog(@"did begin contact");
    NSLog(@"nameA %@", nameA);
    NSLog(@"nameB %@", nameB);
    if (([nameA containsString:@"ball"] && [nameB containsString:@"Fence"]) || ([nameB containsString:@"ball"] && [nameA containsString:@"Fence"])) {
        SKNode *block;
        if ([nameA containsString:@"ball"]) {
            block = contact.bodyA.node;
        } else {
            block = contact.bodyB.node;
        }
        
        SKAction *actionAudioRamp = [SKAction playSoundFileNamed:@"ballhit.aif" waitForCompletion:NO];
//        SKAction *actionVisualRamp = [SKAction animateWithTextures:self timePerFrame:0.04f resize:NO restore:NO];
        NSString *particleRampPath = [[NSBundle mainBundle] pathForResource:@"ballParticle" ofType:@"sks"];
        SKEmitterNode *particleRamp = [NSKeyedUnarchiver unarchiveObjectWithFile:particleRampPath];
        
        particleRamp.position = CGPointMake(0,0);
        particleRamp.zPosition = 0;
        SKAction *actionParticleRamp = [SKAction runBlock:^{
            [block addChild:particleRamp];
        }];
        SKAction *actionRampSequence = [SKAction group:@[actionAudioRamp, actionParticleRamp]];
        [block runAction:[SKAction sequence:@[actionRampSequence]]];
        NSLog(@"ball hit fence");
        
        
    }
    
    
}

@end
