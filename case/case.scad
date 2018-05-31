use <MCAD/boxes.scad>
//use <OPENSCAD/Autobot_Latches.scad>

width = 25.5;
depth = 91;
height = 14;
wall = 2;

usb_height = 6.5;
usb_width = 2;
usb_depth = 13.75;

module rpi_hub(width=24.1, depth=90, height=14, wall=2){

    // The main hub case
    translate([width/2, depth/2,height/2]){
        difference(){
            // Account for the hub platform being 2 mm thick
            cube([width,depth,height+wall], true);
            translate([1,1,0]){
                cube([width-wall+3,depth,height+wall*2], true);
            }
        }
        // Holder for hub card
        translate([-12,44,-6]){
            cube([width-1,1,4]);
        }
    }

    // bottom portion
    translate([width/2, depth/2,0]){
        cube([width,depth,wall],true);
    }
}

// USB port
module usb_port(width=usb_width,depth=usb_depth,height=usb_height){ 
    //height=5.75; // z-axis
    //width=2;  // x-axis
   //depth=13.25; // y-axis
    cube([4, depth, height]);
}

module eth_jack(){
    //Ethernet Jack
    e_width = 15;
    e_height = 1;
    e_depth = 12.0;

    x = 5.8;
    y = 0;
    z = 1;
    translate([x,y,z]){
        cube([e_width, e_height, e_depth]);
        translate([5.5,0,-2]){
            cube([3.6, 3, 3]);
        }
    }
}

module eth_hub(){
    // USB Ports
    offset_z_1 = 6.4;
    offset_y_1 = 30.35;
    offset_x_1 = 24.1;
    
    offset_z_2 = 6.4;
    offset_y_2 = offset_y_1 + 6+ usb_depth;
    offset_x_2 = 24.1;
    
    offset_z_3 = 6.4;
    offset_y_3 = offset_y_2 + 4 + usb_depth;
    offset_x_3 = 24.1;
    
    difference(){
        // Bottom piece
        rpi_hub(width,depth,height,wall);
        
        // Ethernet
        eth_jack();
                
        // Power
        p_depth = 7.4;
        p_height = 6.5;
        p_width = 2;
    
        translate([-1,78,2]){
            cube([4, 12, 6.5]);
        }
    }
}

module usb_micro(x=0,y=0,z=0){
    usb_micro_port_width = 8.75-.9;
    usb_micro_port_height = 3.4;

        translate([x,y,z]){
            cube([wall,usb_micro_port_width,usb_micro_port_height]);
        }
}

module hdmi(x=0,y=0,z=0){
    hdmi_port_width = 12.25;
    hdmi_port_height = 4.25-.3;

        translate([x,y,z]){
            cube([wall,hdmi_port_width,hdmi_port_height]);
        }
}

module vent(x=0,y=0,z=0){
    translate([x,y,z]){
        cube([2,20,wall]);
    }
 }


// RPI
module rpi_box(){
    box_width = 33;
    box_depth =92;
    box_height = 14;
    wall = 2;
    
    usb_micro_port_width = 8.75;
    usb_micro_port_height = 3.4;
    
    hdmi_port_width = 12.25;
    hdmi_port_height = 4.25;

    // The main hub case
    translate([box_width/2+.25, box_depth/2,box_height/2]){
        difference(){
            // Account for the hub platform being 2 mm thick
            cube([box_width-.9,box_depth,box_height+wall], true);
            translate([1,1,0]){
                cube([box_width+1.5,box_depth,box_height+wall*2], true);
            }
        }
    }
    
    // bottom portion
    translate([box_width/2+.5, box_depth/2,0]){
        cube([box_width-.5,box_depth-2,wall],true);
    }

    translate([4.7,6,0]){
        cylinder(7.5, d=2.4);
        // rest portion
        cylinder(3.8,d=6);
    }

    translate([27.7,6,0]){
        cylinder(7.5, d=2.4);
        
        // rest portion
        cylinder(3.8,d=6);
    }

    translate([4.7,64,0]){
        cylinder(7.5, d=2.4);

        // rest portion
        cylinder(3.8,d=6);
    }

    translate([27.7,64,0]){
        cylinder(7.5, d=2.4);

        // rest portion
        cylinder(3.8,d=6);
    }

}

module rpi_bottom(){
    difference(){
        rpi_box(); 
    
        usb_micro(x=0,y=21+1.35,z=5.3);
        usb_micro(x=0,y=8.5+1.35,z=5.3);
        hdmi(x=0, y=48+1.35,z=4.8);   
        
        vent(x=7.5,y=9.75,z=-1);
        vent(x=11.5,y=9.75,z=-1);
        vent(x=15.5,y=9.75,z=-1);
        vent(x=19.5,y=9.75,z=-1);
        vent(x=23.5,y=9.75,z=-1);
    
        vent(x=7.5,y=40.75,z=-1);
        vent(x=11.5,y=40.75,z=-1);
        vent(x=15.5,y=40.75,z=-1);
        vent(x=19.5,y=40.75,z=-1);
        vent(x=23.5,y=40.75,z=-1);

    }
}


module lid(){
    
    offset_z_1 = 6.4;
    offset_y_1 = 30.35;
    offset_x_1 = 24.1;
    
    offset_z_2 = 6.4;
    offset_y_2 = offset_y_1 + 6+ usb_depth;
    offset_x_2 = 24.1;
    
    offset_z_3 = 6.4;
    offset_y_3 = offset_y_2 + 4 + usb_depth;
    offset_x_3 = 24.1;
    
    // outer casing
    difference(){
        translate([0,0,1]){
            difference(){
                cube([59.5,92,17.5]);
                translate([1,0,0]){
                    cube([57.5,91,17.5]);
                }
            }
        }
        
        // RPI ports
        usb_micro(x=58.5,y=21+1.35,z=5.55+wall);
        usb_micro(x=58.5,y=8.5+1.35,z=5.55+wall);
        hdmi(x=58.5, y=48+1.35,z=5.55+wall);   

        // USB Port 1
        translate([-1, offset_y_1-wall+.5,2.3+wall]){
            usb_port();
        }
    
        // USB Port 2
        translate([-1, offset_y_2-3,2.3+wall]){
            usb_port();
        }
        
        // USB Port 3
        translate([-1,offset_y_3-1.9,2.3+wall]){
            usb_port();
        }
    }

    // Y axis Rail
    translate([1,0,17.5]){
        cube([4,92,1]);
    }

    // Y axis Rail opposite side
    translate([54,0,17.5]){
        cube([5,92,1]);
    }

    // X axis rail
    translate([0,80,17.5]){
        cube([58,12,1]);
    }

    // Top portion
    cube([59.5,92,1]);

}

// RPI Housing 
translate([0,0,0]){
    rpi_bottom();
    translate([31.5,0,0]){
        cube([2,depth-13.5,15]);
    }
}
translate([32.5,0,0]){
    eth_hub();
}

// Outer Casing
translate([69.5, 0, 0]){
    rotate(a=[0,180,0]){
        rotate([0,180,0]){
            lid();
        }
    }
}


