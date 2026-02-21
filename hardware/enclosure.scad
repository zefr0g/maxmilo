// maxmilo - Sleek Rounded Enclosure for ESP-01 + Adapter
// Designed for 3D printing (FDM)

// Dimensions
length = 45;
width = 30;
height = 20;
wall_thickness = 2;
corner_radius = 3;
clearance = 0.5;

$fn = 32; // Smoothness for curves

module rounded_box(l, w, h, r) {
    translate([r, r, 0])
    minkowski() {
        cube([l - 2*r, w - 2*r, h/2]);
        cylinder(r = r, h = h/2);
    }
}

module box() {
    difference() {
        // Outer box
        rounded_box(length + wall_thickness*2, width + wall_thickness*2, height + wall_thickness, corner_radius);
        
        // Inner cavity (hollow out)
        translate([wall_thickness, wall_thickness, wall_thickness])
            rounded_box(length, width, height + 1, corner_radius - wall_thickness/2);
            
        // Cutout for cable (CN105)
        translate([-1, (width+wall_thickness*2)/2 - 5, wall_thickness + 2])
            cube([wall_thickness + 2, 10, 8]);
    }
}

module lid() {
    translate([0, width + wall_thickness*3, 0]) {
        difference() {
            // Main lid plate
            rounded_box(length + wall_thickness*2, width + wall_thickness*2, wall_thickness, corner_radius);
            
            // "maxmilo" text engraving
            translate([(length + wall_thickness*2)/2, (width + wall_thickness*2)/2, wall_thickness - 0.5])
                linear_extrude(height = 1)
                    text("maxmilo", size = 6, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
        }

        // Friction fit lip
        translate([wall_thickness + clearance, wall_thickness + clearance, wall_thickness])
            difference() {
                rounded_box(length - clearance*2, width - clearance*2, 2, corner_radius - wall_thickness/2);
                translate([wall_thickness, wall_thickness, -1])
                    rounded_box(length - wall_thickness*2 - clearance*2, width - wall_thickness*2 - clearance*2, 4, corner_radius - wall_thickness);
            }
    }
}

box();
lid();

// Instructions:
// 1. Install OpenSCAD
// 2. Adjust dimensions if your specific adapter varies
// 3. Export to STL for printing
