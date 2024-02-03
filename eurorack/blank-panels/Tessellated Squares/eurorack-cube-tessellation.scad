/*
Parametric Eurorack Panel Covers
w/ seed-based texturing
-James Ryg
*/
////////////////////////
//This section contains
//the global parameters
//for generation
////////////////////////

/* [Tesselation] */
Tesselation = true;
Tesselation_Minimum_Height_Millimeters=1.0; //[0.0:0.25:5]
Tesselation_Maximum_Height_Millimeters=3.0; //[0.:0.25:5]
Tesselation_Columns_Per_Slot=3; //[1:10]
/* [Size] */
Horizontal_Pitch = 1; //[1:104]
Eurorack_Base_Thickness_Millimeters=1.5; //[0.5:0.25:5]
/* [Fun] */
Custom_Seed=0; //[0:9999999]
/* [Hidden] */
C_Eurorack_Length_Millimeters=128.5;
C_Eurorack_Slot_Width_Millimeters=5.08;
C_Eurorack_Hole_Radius_Millimeters=1.6;
C_Eurorack_Hole_Offset_Y_Millimeters=3.0;
V_Eurorack_Hole_Offset_X_Millimeters = Horizontal_Pitch<3 ? 2.54 : 7.5;
V_Tesselation_Cube_Size_Millimeters = 5.08/Tesselation_Columns_Per_Slot;
V_Tesselation_Rows_Per_Column=C_Eurorack_Length_Millimeters/V_Tesselation_Cube_Size_Millimeters;
Random_Seed=floor(rands(1,9999999,1)[0]);
Seed=(Custom_Seed==0) ? Random_Seed : Custom_Seed;
////////////////////////
//Main
////////////////////////
plateWidth=Horizontal_Pitch*C_Eurorack_Slot_Width_Millimeters;

randomValues=rands(Tesselation_Minimum_Height_Millimeters,Tesselation_Maximum_Height_Millimeters,((Horizontal_Pitch*Tesselation_Columns_Per_Slot)*V_Tesselation_Rows_Per_Column),Seed);
difference(){
    union(){
        cube([
            plateWidth,
            C_Eurorack_Length_Millimeters,
            Eurorack_Base_Thickness_Millimeters]);
        if(Tesselation){
            for(i = [0:Horizontal_Pitch*Tesselation_Columns_Per_Slot-1]){
                for(j=[0:V_Tesselation_Rows_Per_Column+1]){
                    tesselatedCube([V_Tesselation_Cube_Size_Millimeters,V_Tesselation_Cube_Size_Millimeters,rands(Tesselation_Minimum_Height_Millimeters,Tesselation_Maximum_Height_Millimeters,1,randomValues[i*j+j])[0]],[i*(V_Tesselation_Cube_Size_Millimeters),(j-1)*(V_Tesselation_Cube_Size_Millimeters),Eurorack_Base_Thickness_Millimeters],       Eurorack_Base_Thickness_Millimeters);
                }
            }
        }
    };
    hole1();
    hole1_relief();
    hole2();
    hole2_relief();
    if(Horizontal_Pitch>10){
        hole3();
        hole3_relief();
        hole4();
        hole4_relief();
    }
    //Trimming excess from tesselator function
    if(Tesselation){
        translate([-1,C_Eurorack_Length_Millimeters,-1])
        cube([plateWidth+2, 20, 20]);
        translate([-1,-20,-1])
        cube([plateWidth+2, 20, 20]);
    };
};

////////////////////////
//Modules
////////////////////////

module tesselatedCube(size=[1,1,1], position=[0,0,0], baseThickness=1){
    translate(position)
    cube(size);
}

module hole1(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters,C_Eurorack_Hole_Offset_Y_Millimeters,-1]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters,   C_Eurorack_Hole_Radius_Millimeters,$fn=20);
}
module hole1_relief(){
    union(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters,C_Eurorack_Hole_Offset_Y_Millimeters,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
    
    translate([V_Eurorack_Hole_Offset_X_Millimeters,C_Eurorack_Hole_Offset_Y_Millimeters-2,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
    }
}
module hole2(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters,C_Eurorack_Length_Millimeters-C_Eurorack_Hole_Offset_Y_Millimeters,-1]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters,   C_Eurorack_Hole_Radius_Millimeters,$fn=20);
}
module hole2_relief(){
    union(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters,C_Eurorack_Length_Millimeters-C_Eurorack_Hole_Offset_Y_Millimeters,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
        
    translate([V_Eurorack_Hole_Offset_X_Millimeters,C_Eurorack_Length_Millimeters-C_Eurorack_Hole_Offset_Y_Millimeters+2,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
    }
}
module hole3(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters+(Horizontal_Pitch-3)*C_Eurorack_Slot_Width_Millimeters,C_Eurorack_Hole_Offset_Y_Millimeters,-1]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters,   C_Eurorack_Hole_Radius_Millimeters,$fn=20);
}
module hole3_relief(){
    union(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters+(Horizontal_Pitch-3)*C_Eurorack_Slot_Width_Millimeters,C_Eurorack_Hole_Offset_Y_Millimeters,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
    };
    translate([V_Eurorack_Hole_Offset_X_Millimeters+(Horizontal_Pitch-3)*C_Eurorack_Slot_Width_Millimeters,C_Eurorack_Hole_Offset_Y_Millimeters-2,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
    };
module hole4(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters+(Horizontal_Pitch-3)*C_Eurorack_Slot_Width_Millimeters,C_Eurorack_Length_Millimeters-C_Eurorack_Hole_Offset_Y_Millimeters,-1]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters,   C_Eurorack_Hole_Radius_Millimeters,$fn=20);
}
module hole4_relief(){
    union(){
    translate([V_Eurorack_Hole_Offset_X_Millimeters+(Horizontal_Pitch-3)*C_Eurorack_Slot_Width_Millimeters,C_Eurorack_Length_Millimeters-C_Eurorack_Hole_Offset_Y_Millimeters,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
        
    translate([V_Eurorack_Hole_Offset_X_Millimeters+(Horizontal_Pitch-3)*C_Eurorack_Slot_Width_Millimeters,C_Eurorack_Length_Millimeters-C_Eurorack_Hole_Offset_Y_Millimeters+2,Eurorack_Base_Thickness_Millimeters]) cylinder(10, C_Eurorack_Hole_Radius_Millimeters+1,   C_Eurorack_Hole_Radius_Millimeters+1,$fn=20);
    }
}