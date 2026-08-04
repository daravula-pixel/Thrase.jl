// ------------------------
//  Parameters (km)
// ------------------------
Lx = 40/Tan(Pi/6); //  x length
Ly = 40;  // y length
h  = 5;   // max height spacing
h_far   = 5;     // km
h_fault = 0.5;   // km

// ------------------------
// Domain in a rectangle using parameters
// ------------------------
Point(1) = {0,   0,   0, h};
Point(2) = {Lx,  0,   0, h};
Point(3) = {Lx, -Ly,  0, h};
Point(4) = {0,  -Ly,  0, h};

Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};

// ------------------------
// Fault geometry (line only)
// ------------------------

// fault starting point (middle surface)
//Point(10) = {0, 0, 0, h}; // shouldnt do this since now im defining same node as two different things

// compute end point using 30 degree dip
// tan(30°) ≈ 0.577
//Point(11) = {Lx, -Ly, 0, h}; // same issue here

// fault line
Line(10) = {1,3}; //use what has already been defined 

// uniform mesh
Mesh.MeshSizeMin = h_fault;
Mesh.MeshSizeMax = h_far;

Curve Loop(1) = {1,2,-10};
Plane Surface(1) = {1}; //splitting the two triangles

Curve Loop(2) = {10,3,4};
Plane Surface(2) = {2};

// ------------------------
// Distance Field
// ------------------------

Field[1] = Distance;
Field[1].CurvesList = {10}; //distance to fault

Field[2] = MathEval;
Field[2].F = "Min(5,0.5*Exp(F1/10))"; //exp field
Background Field = 2;

// ------------------------
// Side sets
// ------------------------

Physical Curve("surface") = {1};
Physical Curve("right")   = {2};
Physical Curve("bottom")  = {3};
Physical Curve("left")    = {4};

Physical Curve("fault")   = {10};

Physical Surface("upper_triangle") = {1};
Physical Surface("lower_triangle") = {2};//+
Show "*";
