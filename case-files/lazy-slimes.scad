//lamystere's lazy slime cases
//insert some meaningless license here
//lamystere.com

//settings for printing/customizing
show_base = true;
//settings for printing/customizing
show_cover = true;
//settings for printing/customizing
show_satellite = true;
//settings for printing/customizing
show_satellite_cover = true;
//settings for printing
position_covers_for_printing = true;
//settings for customizing (not printing)
show_covers_transparent = true;


//settings for the bottom plate
ridge_height = 5;
//settings for the bottom plate
ridge_thickness = 1;
//settings for the bottom plate
bottom_thickness = 1;  //also controls top thickness
//measurements for the strap loops
strap_hole_length = 52;
//measurements for the strap loops
strap_hole_width = 4;
//measurements for the strap loops
satellite_strap_hole_length = 26;  //maybe 27?
//generic 18650 battery holder measurements
battery_length = 78;
//generic 18650 battery holder measurements
battery_width = 21;
//generic 18650 battery holder measurements
battery_height = 21;
//d1 mini board measurements
d1_width = 26;
//d1 mini board measurements
d1_length = 35;
//d1 mini board measurements
d1_height = 8;
//d1 mini board measurements
d1_shield_height = .6;
//d1 mini board measurements
d1_shield_width = 13;
//d1 mini board measurements
d1_shield_length = 16;
//d1 mini board measurements
d1_shield_offset_width = 6;
//d1 mini board measurements
d1_shield_offset_length = 7;
//bmi160 gyro board measurements
bmi160_width = 18;
//bmi160 gyro board measurements
bmi160_length = 14;
//bmi160 gyro board measurements
bmi160_height = 5; //4
//bmi160 gyro board 
bmi160_use_straight_pins = true; //
main_width = d1_width + battery_width + ridge_thickness * 3;
main_length = battery_length + ridge_thickness * 2;
//the 4 pin connector on the bmi160
connector_width = 13;
//the 4 pin connector on the bmi160
connector_height = 9;
//the 4 pin connector on the bmi160
connector_depth = 7;
//the 4 pin connector on the bmi160
connector_offset_z = 1;
//the 4 pin connector on the bmi160
connector_offset_y = 1;
//the 4 pin connector pushes the board up
solder_height = 2; 
//cant make lid slides an exact match, the outer channel must be a hair bigger
slide_tolerance = .5; 
//how thick the grooved sides of the covers are
slide_thickness = 5; //below 4 is too flimsy
//how thick the rail and groove are
slide_rail_thickness = 1;
//the hole at the side where the wire to the satellite runs
cable_run_width = 5; 


if (show_base) {base();}
if (show_cover) {
    if (position_covers_for_printing) {
        translate([-strap_hole_width*3,0,bottom_thickness*2 + connector_height + solder_height]) rotate([0,180,0])  cover(); 
    } else {
        if (show_covers_transparent) {
            #cover(); 
        } else {
            cover(); 
        }
    }
}

translate([0,-satellite_strap_hole_length-strap_hole_width-slide_thickness,0]) {
    if (show_satellite) {
        satellite();
    }
    if (show_satellite_cover) {
        if (position_covers_for_printing) {
            translate([-strap_hole_width*4-slide_thickness,0,bottom_thickness + connector_height + solder_height]) rotate([0,180,0])  satellite_cover();
        } else {
           if (show_covers_transparent) {
               #satellite_cover(); 
           } else {
               satellite_cover(); 
           }
        } 
    }
}

module base() {
    difference() {
        translate([0,0,0]) cube([main_width,main_length,bottom_thickness + ridge_height]);

        translate([ridge_thickness,ridge_thickness,bottom_thickness]) d1();
        translate([ridge_thickness  + d1_width,0,bottom_thickness])battery();
            
        translate([ridge_thickness,main_length -ridge_thickness - bmi160_length,bottom_thickness]) scale([1,1,1.01]) bmi160();
            
        color("purple") translate([ridge_thickness,d1_length +ridge_thickness*2,bottom_thickness]) middle_compartment();
            
        
    }
    translate([0,-slide_rail_thickness,bottom_thickness*2]) slide_ridge(d1_width+ridge_thickness*2);
    translate([0,main_length,bottom_thickness*2])  slide_ridge(d1_width+ridge_thickness*2);

    strap();
    translate([main_width,0,0]) mirror([1,0,0]) strap();
}


module slide_ridge(width) {
    color("magenta") cube([width,slide_rail_thickness,slide_rail_thickness]);
    //translate([0,-ridge_thickness+slide_tolerance,0]) cube([d1_width+ridge_thickness*2,ridge_thickness-slide_tolerance,ridge_thickness-slide_tolerance]);
}

module middle_compartment() {
    cube([main_width - battery_width - ridge_thickness * 3, main_length - d1_length - bmi160_length - ridge_thickness * 4,ridge_height*2]);
}

module battery() {
        color("blue") translate([ridge_thickness,ridge_thickness,0]) cube([battery_width,battery_length,battery_height]);
}

module d1() {
    color("red")  cube([d1_width,d1_length,d1_height]);
    
    //connector
        translate([ connector_width/2,d1_length,connector_offset_z]) cube([connector_width,connector_depth,connector_height]);

    //wifi shield
        translate([ d1_shield_offset_width,d1_shield_offset_length,-d1_shield_height]) cube([d1_shield_width,d1_shield_length,d1_shield_height]);
}

module bmi160() {
    color("green")  cube([bmi160_width,bmi160_length,bmi160_height]);
    
    //connector
    translate([connector_offset_y,-connector_depth,connector_offset_z]) cube([connector_width,connector_depth,connector_height]);
}

module strap() {
    difference() {
    color("orange") linear_extrude(bottom_thickness + ridge_height) polygon([[0,0],[0,main_length],[-strap_hole_width * 2, main_length - ((main_length - strap_hole_length) / 2)], [-strap_hole_width * 2, (main_length - strap_hole_length) / 2],[0,0]]);
        
    translate([-strap_hole_width,(main_length - strap_hole_length) / 2,  -2]) cube([strap_hole_width,strap_hole_length,ridge_height * 2]);
    }
}


module cover() {
    color("cyan") {
        difference() {
            translate([0,-slide_thickness,ridge_height+bottom_thickness]) cube([d1_width+ridge_thickness*2,main_length+slide_thickness*2,bottom_thickness + connector_height + solder_height - ridge_height]);
        
        //inner volume
            translate([ridge_thickness,ridge_thickness,ridge_height+bottom_thickness])   cube([d1_width + ridge_thickness, main_length - ridge_thickness * 2,connector_height + solder_height - ridge_height - bottom_thickness]);
            
        //cable run
        translate([d1_width - cable_run_width/2 - ridge_thickness/2,-ridge_thickness*6,ridge_height+bottom_thickness]) cube([cable_run_width,main_length*1.2,connector_height - ridge_height + 1]);
        }
        
        //middle support
        //translate([d1_width*7/8+ridge_thickness*2,d1_length+ridge_thickness*2,ridge_height]) cube([d1_width/8,ridge_thickness,d1_height - ridge_height]);
    
        side_lock();
        translate([0,main_length,0]) mirror([0,1,0]) side_lock();
    }
}

module side_lock() {
    difference() {
        translate([0,-slide_thickness,0]) cube([d1_width+ridge_thickness*2,slide_thickness,ridge_height+bottom_thickness]);
        
        translate([0,-slide_rail_thickness-slide_tolerance/2,bottom_thickness*2-slide_tolerance/2]) cube([d1_width+ridge_thickness*2,slide_rail_thickness+slide_tolerance,slide_rail_thickness+slide_tolerance]);
    }
}

module satellite() {
    difference() {
        
        cube([bmi160_width + ridge_thickness * 2,bmi160_length + connector_depth + ridge_thickness,bmi160_height + bottom_thickness ]);
            
        //bottom cutout
        translate([ridge_thickness,connector_depth,bottom_thickness]) scale([1,1,1.01]) bmi160();
        
    }
    
    //ridge 1
    translate([0,0,bmi160_height+bottom_thickness-slide_rail_thickness]) rotate([0,0,90]) slide_ridge(bmi160_length + connector_depth + ridge_thickness);
    
    //ridge 2
    translate([bmi160_width+ridge_thickness *2+slide_rail_thickness,0,bmi160_height+bottom_thickness-slide_rail_thickness]) rotate([0,0,90]) slide_ridge(bmi160_length + connector_depth + ridge_thickness);
    
    //straps
    satellite_strap();
    translate([bmi160_width+ridge_thickness*2 ,bmi160_length + connector_depth + ridge_thickness,0]) 
    rotate([0,0,180]) satellite_strap();
}

module satellite_strap() {
    translate([0,(bmi160_length + connector_depth + ridge_thickness - satellite_strap_hole_length - strap_hole_width)/2  ,0]) {
        // 
    difference() {
        translate([-slide_thickness-strap_hole_width*2,0,0]) cube([strap_hole_width*2+slide_thickness,satellite_strap_hole_length + strap_hole_width,bottom_thickness + connector_offset_z]);
        
        translate([-strap_hole_width-slide_thickness,strap_hole_width/2,0]) cube([strap_hole_width,satellite_strap_hole_length,bmi160_height]);
    }
    }
}

module satellite_cover() {
    color("lime") {
        difference() {
            translate([-slide_thickness,0,bottom_thickness + connector_offset_z]) cube([ridge_thickness*2+bmi160_width+slide_thickness*2, bmi160_length + connector_depth+ridge_thickness, connector_height + solder_height - bottom_thickness]);
            
            //inner volume
                translate([ridge_thickness,0,bottom_thickness+connector_offset_z]) cube([bmi160_width, bmi160_length + connector_depth, connector_height + solder_height - connector_offset_z - bottom_thickness * 2 ]);
            
            //bottom volume
            translate([0,0,0]) cube([bmi160_width + ridge_thickness*2, bmi160_length + connector_depth, bmi160_height + bottom_thickness + slide_tolerance/2]);
            
            //side channel 1
            translate([-slide_rail_thickness-slide_tolerance/2,0,bmi160_height+bottom_thickness-slide_rail_thickness-slide_tolerance/2]) cube([slide_rail_thickness+slide_tolerance,bmi160_length + connector_depth,slide_rail_thickness+slide_tolerance]);
            
            //side channel 2
            translate([bmi160_width+ridge_thickness+slide_rail_thickness-slide_tolerance/2,0,bmi160_height+bottom_thickness-slide_rail_thickness-slide_tolerance/2]) cube([slide_rail_thickness+slide_tolerance,bmi160_length + connector_depth,slide_rail_thickness+slide_tolerance]);
            

        }
        
    }
}


