// ------------------------
// Parameters (km)
// ------------------------

Depth = 80;
Dip = Pi/6;

Shift = Depth/Tan(Dip);   // horizontal offset
Width = 100;

h_fault = 0.5;
h_far   = 5;

// ------------------------
// Points
// ------------------------

Point(1) = {0,0,0,h_far};
Point(2) = {Width,0,0,h_far}; //top corners

Point(3) = {Width+Shift,-Depth,0,h_far};
Point(4) = {Shift,-Depth,0,h_far}; // bottom corners 

Point(5) = {Width/2, 0, 0, h_fault};
Point(6) = {Width/2+Shift, - Depth, 0, h_far}; //fault endpoints


// Outer boundary
Line(1) = {1,5};
Line(2) = {5,2};
Line(3) = {3,6};
Line(4) = {6,4};
Line(5) = {2,3};
Line(6) = {4,1};

// Fault (30° dip)
Line(10) = {5,6};

// Split into two convex surfaces
Curve Loop(1) = {1,10,4,6};
Plane Surface(1) = {1};

Curve Loop(2) = {2,5,3,-10};
Plane Surface(2) = {2};

// ------------------------
// Mesh field
// ------------------------

Field[1] = Distance;
Field[1].CurvesList = {10,11};


Field[2] = MathEval;

Field[2].F = Sprintf(
"Min(5,
0.5*Exp(Max(0,((x-%g)*Cos(%g)-y*Sin(%g))-40)/30)
*Exp(F1/15)
)",
Width/2,
Dip,
Dip
);

Background Field = 2;

Mesh.SubdivisionAlgorithm = 1;
Mesh.RecombinationAlgorithm = 2;
Mesh.RecombineAll = 1;

// ------------------------
// Physical groups
// ------------------------

Physical Curve("surface") = {1,2};
Physical Curve("right")   = {5};
Physical Curve("bottom")  = {3,4};
Physical Curve("left")    = {6};

Physical Curve("fault")   = {10};

Physical Surface("upper") = {1};
Physical Surface("lower") = {2};

Show "*";