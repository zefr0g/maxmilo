// maxmilo - Minimal Enclosure for ESP-01 + Adapter
// Designed for 3D printing (FDM)

// Dimensions (approximate for typical ESP-01 Adapter)
length = 45;
width = 30;
height = 20;
wall_thickness = 2;
clearance = 0.5;

module box() {
    difference() {
        // Outer box
        cube([length + wall_thickness*2, width + wall_thickness*2, height + wall_thickness]);
        
        // Inner cavity
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([length, width, height + 1]);
            
        // Cutout for cable (CN105)
        translate([-1, (width+wall_thickness*2)/2 - 5, wall_thickness + 2])
            cube([wall_thickness + 2, 10, 8]);
    }
}

module lid() {
    translate([0, width + wall_thickness*3, 0]) {
        cube([length + wall_thickness*2, width + wall_thickness*2, wall_thickness]);
        // Simple friction fit lip
        translate([wall_thickness + clearance, wall_thickness + clearance, wall_thickness])
            difference() {
                cube([length - clearance*2, width - clearance*2, 2]);
                translate([wall_thickness, wall_thickness, -1])
                    cube([length - wall_thickness*2 - clearance*2, width - wall_thickness*2 - clearance*2, 4]);
            }
    }
}

box();
lid();

// Instructions:
// 1. Install OpenSCAD
// 2. Adjust dimensions if your specific adapter varies
// 3. Export to STL for printing
