% Check for collisions with objects in the environment and compute the
% total force on the end effector

function F = computeForces(posEE,velocity,posOfBall)
% @param: velocity is a 1x3 vector of velocities in the x y and z
% directions 

global s; 
x = posEE(1); 
y = posEE(2); 
z = posEE(3); 

%% Free space 


%% Spring flat wall 
% Floor 
% define when the flat wall happens
x0Wall = [x y 0];
% find the Force of the flat wall 
kWall = 32;
springWall = (z <= 0); 
FflatWall = -kWall * (posEE - x0Wall);

%% Ball 

%% Interaction of ball with spring flat wall 

%% Texture wall 
% right wall 
% define when the texture wall happens 
textureWall = (y >= s/2); 
% find the normal force
x0WallTexture = [x s/2 z]; 
FNormalTexture = abs(-kWall * (posEE - x0WallTexture));
% Vary the constant with position 
% ////// Currently trying to figure how to change texture with position
cTexture = sin(norm(x+z)); 
% Find the force of the textured wall 
Ftexture = - cTexture * cross(FNormalTexture,velocity); 

%% Viscous wall 
% left wall 
% define when the viscous wall happens 
viscousWall = (y <= -s/2); 
% find the normal force 
x0WallViscous = [x -s/2 z];
FNormalViscous = abs(-kWall * (posEE - x0WallViscous)); 
% find the F of viscous; 
cViscous = 32; 
Fviscous = - cViscous * cross(FNormalViscous,velocity); 

%% Button 
% top right of back wall 


%% Black hole 
% top left of back wall 

%% Do the switch cases 
F = [];

switch (posEE)
    case springWall
        F = FflatWall;
    case textureWall 
        F = Ftexture; 
    case viscousWall
        F = Fviscous; 
    otherwise %freespace 
        
end 

%F needs to be a 3x1 vector not a 1x3 vector
F = F'
end