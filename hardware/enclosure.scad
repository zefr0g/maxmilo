// maxmilo - Boîtier avec supports de vis "inversés" (haut vers bas)
// Optimisé pour l'adaptateur ESP-01 (42mm x 24.1mm)

// --- Paramètres PCB ---
pcb_l = 42.0;
pcb_w = 24.1;
pcb_h_offset = 3; 

// --- Dimensions Intérieures ---
// On garde une marge confortable pour la carte au fond
inner_l = pcb_l + 4; 
inner_w = pcb_w + 4;
height = 24; 
wall = 2.0;
corner_r = 5;

// Vis Couvercle
lid_screw_d = 3.2; // M3
pillar_size = 8;

$fn = 64;

module rounded_rect(l, w, h, r) {
    translate([r, r, 0])
    minkowski() {
        cube([l - 2*r, w - 2*r, h/2]);
        cylinder(r = r, h = h/2);
    }
}

module box() {
    difference() {
        // Corps extérieur
        rounded_rect(inner_l + 2*wall, inner_w + 2*wall, height, corner_r);
        
        // Vidage intérieur TOTAL (le sol est libre)
        translate([wall, wall, wall])
            rounded_rect(inner_l, inner_w, height + 1, corner_r - wall/2);
            
        // Découpe pour câble CN105
        translate([inner_l + wall - 1, (inner_w + 2*wall)/2 - 6, wall + 5])
            cube([wall + 2, 12, 10]);
    }
    
    // --- Supports de vis INVERSÉS (en haut des coins) ---
    // Ces formes partent du haut et s'évasent vers le bas à 45° pour l'impression
    for (x = [wall, inner_l + wall - pillar_size])
        for (y = [wall, inner_w + wall - pillar_size])
            translate([x, y, height - pillar_size])
                difference() {
                    // Forme pyramidale/conique inversée fixée aux parois
                    // Elle ne touche pas le fond du boîtier !
                    intersection() {
                        // On limite la forme à l'intérieur du boîtier
                        translate([0,0,0]) cube([pillar_size, pillar_size, pillar_size]);
                        // Pente à 45° pour impression sans support
                        hull() {
                            translate([0,0,pillar_size-1]) cube([pillar_size, pillar_size, 1]);
                            // Point de raccordement à la paroi
                            if (x == wall && y == wall) translate([0,0,0]) cube([1,1,1]);
                            if (x > wall && y == wall) translate([pillar_size-1,0,0]) cube([1,1,1]);
                            if (x == wall && y > wall) translate([0,pillar_size-1,0]) cube([1,1,1]);
                            if (x > wall && y > wall) translate([pillar_size-1,pillar_size-1,0]) cube([1,1,1]);
                        }
                    }
                    // Trou pour la vis M3 (dans le support suspendu)
                    translate([x == wall ? 4 : pillar_size-4, y == wall ? 4 : pillar_size-4, -1]) 
                        cylinder(d = 2.7, h = pillar_size + 2);
                }

    // --- Supports de fixation du PCB au fond ---
    // Centrés sur le sol désormais dégagé
    translate([wall + (inner_l-pcb_l)/2, wall + (inner_w-pcb_w)/2, wall]) {
        pcb_hole_dist_x = 38.0; 
        pcb_hole_dist_y = 20.0;
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
    translate([0, inner_w + 2*wall + 10, 0]) {
        difference() {
            rounded_rect(inner_l + 2*wall, inner_w + 2*wall, wall + 1.5, corner_r);
            
            // Trous vis couvercle (alignés sur les supports suspendus)
            for (x = [wall + 4, inner_l + wall - 4])
                for (y = [wall + 4, inner_w + wall - 4]) {
                    translate([x, y, -1]) cylinder(d = lid_screw_d, h = wall + 4);
                    // Fraisage
                    translate([x, y, wall]) cylinder(d = 6, h = 3);
                }
                
            // Gravure "maxmilo"
            translate([(inner_l+2*wall)/2, (inner_w+2*wall)/2, wall + 1.0])
                linear_extrude(height = 1)
                    text("maxmilo", size = 7, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
        }
    }
}

box();
lid();
