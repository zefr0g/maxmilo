// maxmilo - Professional 3D Printable Enclosure
// Optimized for ESP-01 Adapter (42mm x 24.1mm)

$fn = 64;

// PCB Dimensions
pcb_l = 42.0;
pcb_w = 24.1;
pcb_hole_dist_x = 38.0; 
pcb_hole_dist_y = 20.0;
pcb_h_offset = 3; 

// Enclosure Dimensions
inner_l = pcb_l + 8; 
inner_w = pcb_w + 8;
height = 24; 
wall = 2.0;
corner_r = 5;

// Screws & Inserts
m3_pilot_d = 2.4; // For self-tapping screws
m3_insert_d = 4.2; // Optimized for standard M3 heat-set inserts
m3_insert_depth = 6.0;
m3_clearance_d = 3.2;

// Toggle this to switch between self-tapping and threaded inserts
use_threaded_inserts = true;

module rounded_box(l, w, h, r) {
    hull() {
        translate([r, r, 0]) cylinder(r=r, h=h);
        translate([l-r, r, 0]) cylinder(r=r, h=h);
        translate([r, w-r, 0]) cylinder(r=r, h=h);
        translate([l-r, w-r, 0]) cylinder(r=r, h=h);
    }
}

module box() {
    difference() {
        // Outer Body
        rounded_box(inner_l + 2*wall, inner_w + 2*wall, height, corner_r);
        
        // Inner Cavity
        translate([wall, wall, wall])
            rounded_box(inner_l, inner_w, height + 1, corner_r - wall/2);
            
        // Cable Cutout
        translate([inner_l + wall - 1, (inner_w + 2*wall)/2 - 6, wall + 5])
            cube([wall + 2, 12, 10]);
            
        // Screw Holes
        screw_hole_d = use_threaded_inserts ? m3_insert_d : m3_pilot_d;
        screw_hole_h = use_threaded_inserts ? m3_insert_depth : 12;
        
        for (x = [wall + 5, inner_l + wall - 5])
            for (y = [wall + 5, inner_w + wall - 5])
                translate([x, y, height - screw_hole_h + 0.1])
                    cylinder(d = screw_hole_d, h = screw_hole_h);
    }
    
    // Inverted Corner Supports (45 degree slope for supportless printing)
    for (x = [wall, inner_l + wall - 10])
        for (y = [wall, inner_w + wall - 10])
            translate([x, y, height - 10])
            intersection() {
                cube([10, 10, 10]);
                hull() {
                    translate([0,0,9]) cube([10,10,1]);
                    // Stronger anchor point
                    if (x == wall && y == wall) translate([0,0,0]) cube([3,3,3]);
                    if (x > wall && y == wall) translate([7,0,0]) cube([3,3,3]);
                    if (x == wall && y > wall) translate([0,7,0]) cube([3,3,3]);
                    if (x > wall && y > wall) translate([7,7,0]) cube([3,3,3]);
                }
            }

    // PCB Mounting Posts
    translate([wall + (inner_l-pcb_l)/2, wall + (inner_w-pcb_w)/2, wall]) {
        off_x = (pcb_l - pcb_hole_dist_x)/2;
        off_y = (pcb_w - pcb_hole_dist_y)/2;
        
        for (ax = [off_x, off_x + pcb_hole_dist_x])
            for (ay = [off_y, off_y + pcb_hole_dist_y])
                translate([ax, ay, 0])
                    difference() {
                        cylinder(d = 6, h = pcb_h_offset);
                        translate([0,0,1]) cylinder(d = 2.0, h = pcb_h_offset);
                    }
    }
}

module lid() {
    difference() {
        rounded_box(inner_l + 2*wall, inner_w + 2*wall, wall + 1.5, corner_r);
        
        // Screw Holes
        for (x = [wall + 5, inner_l + wall - 5])
            for (y = [wall + 5, inner_w + wall - 5]) {
                translate([x, y, -1]) cylinder(d = m3_clearance_d, h = wall + 4);
                // Simple chamfer
                translate([x, y, wall + 0.5]) cylinder(d1=m3_clearance_d, d2=6, h=1.5);
            }
            
        // Branding
        translate([(inner_l+2*wall)/2, (inner_w+2*wall)/2, wall + 0.5])
            linear_extrude(height = 1.1)
                text("maxmilo", size = 7, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    }
}

// Multi-part export logic
part = "all"; // [all, box, lid]

if (part == "all") {
    box();
    translate([0, inner_w + 15, 0]) lid();
} else if (part == "box") {
    box();
} else if (part == "lid") {
    lid();
}
