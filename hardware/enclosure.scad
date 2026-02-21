// maxmilo - Extra-Safe Professional Enclosure
// Optimized for ESP-01 Adapter (42mm x 24.1mm) with tall components

$fn = 64;

// PCB Dimensions
pcb_l = 42.0;
pcb_w = 24.1;
pcb_hole_dist_x = 38.0; 
pcb_hole_dist_y = 20.0;
pcb_h_offset = 3; 

// Enclosure Dimensions - Increased margin for safety
inner_l = pcb_l + 16; 
inner_w = pcb_w + 16;
height = 22; // Slimmer profile (down from 26mm)
wall = 2.2;  // Thicker walls for better insert retention
corner_r = 6;

// Screws & Inserts
m3_insert_d = 4.2; 
m3_insert_depth = 6.0;
m3_clearance_d = 3.4;
support_size = 7.5; // Small enough to stay outside the PCB area

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
        union() {
            // Main Hollow Shell
            difference() {
                rounded_box(inner_l + 2*wall, inner_w + 2*wall, height, corner_r);
                translate([wall, wall, wall])
                    rounded_box(inner_l, inner_w, height + 1, corner_r - wall/2);
            }
            
            // Hanging Corner Supports (45 degree slope)
            // Positioned exactly in the corners to stay away from the PCB
            for (x = [wall, inner_l + wall - support_size])
                for (y = [wall, inner_w + wall - support_size])
                    translate([x, y, height - 10])
                    intersection() {
                        cube([support_size, support_size, 10]);
                        hull() {
                            translate([0,0,9]) cube([support_size, support_size, 1]);
                            // Anchors to walls
                            if (x == wall && y == wall) translate([0,0,0]) cube([1,1,1]);
                            if (x > wall && y == wall) translate([support_size-1,0,0]) cube([1,1,1]);
                            if (x == wall && y > wall) translate([0,support_size-1,0]) cube([1,1,1]);
                            if (x > wall && y > wall) translate([support_size-1,support_size-1,0]) cube([1,1,1]);
                        }
                    }
        }
        
        // Subtract Functional Cutouts
        // Cable Cutout
        translate([inner_l + wall - 1, (inner_w + 2*wall)/2 - 6, wall + 6])
            cube([wall + 2, 12, 10]);
            
        // Screw Holes for Inserts (Centered in supports)
        for (x = [wall + support_size/2, inner_l + wall - support_size/2])
            for (y = [wall + support_size/2, inner_w + wall - support_size/2])
                translate([x, y, height - m3_insert_depth + 0.1])
                    cylinder(d = m3_insert_d, h = m3_insert_depth + 1);
    }

    // PCB Mounting Posts (Centrally located)
    translate([wall + (inner_l-pcb_l)/2, wall + (inner_w-pcb_w)/2, wall]) {
        off_x = (pcb_l - pcb_hole_dist_x)/2;
        off_y = (pcb_w - pcb_hole_dist_y)/2;
        
        for (ax = [off_x, off_x + pcb_hole_dist_x])
            for (ay = [off_y, off_y + pcb_hole_dist_y])
                translate([ax, ay, 0])
                    difference() {
                        cylinder(d = 6, h = pcb_h_offset);
                        translate([0,0,1]) cylinder(d = 2.0, h = pcb_h_offset + 1);
                    }
    }
}

module lid() {
    difference() {
        rounded_box(inner_l + 2*wall, inner_w + 2*wall, wall + 1.5, corner_r);
        
        // Screw Holes aligned with the supports
        for (x = [wall + support_size/2, inner_l + wall - support_size/2])
            for (y = [wall + support_size/2, inner_w + wall - support_size/2]) {
                translate([x, y, -1]) cylinder(d = m3_clearance_d, h = wall + 4);
                // Chamfer for screw head
                translate([x, y, wall + 0.5]) cylinder(d1=m3_clearance_d, d2=6, h=1.5);
            }
            
        // Branding
        translate([(inner_l+2*wall)/2, (inner_w+2*wall)/2, wall + 1.0])
            linear_extrude(height = 1)
                text("MaxMiLo", size = 9, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    }
}

// Multi-part export logic
part = "all"; // [all, box, lid]

if (part == "all") {
    box();
    translate([0, inner_w + 2*wall + 10, 0]) lid();
} else if (part == "box") {
    box();
} else if (part == "lid") {
    lid();
}
