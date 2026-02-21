// maxmilo - Boîtier avec piliers coniques et fermeture par vis
// Optimisé pour l'adaptateur ESP-01 (42mm x 24.1mm)

// --- Paramètres PCB ---
pcb_l = 42.0;
pcb_w = 24.1;
pcb_h_offset = 4; // Hauteur des supports PCB

// --- Dimensions Intérieures (Élargies pour les piliers) ---
// On ajoute de la marge pour que les piliers coniques ne touchent pas le PCB
inner_l = pcb_l + 12; 
inner_w = pcb_w + 12;
height = 25; 
wall = 2.0;
corner_r = 6;

// Vis
lid_screw_d = 3.2; // M3
pillar_top_d = 8;
pillar_bot_d = 12;

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
        
        // Vidage intérieur principal
        translate([wall, wall, wall])
            rounded_rect(inner_l, inner_w, height + 1, corner_r - wall/2);
            
        // Découpe pour câble CN105
        translate([inner_l + wall - 1, (inner_w + 2*wall)/2 - 6, wall + 6])
            cube([wall + 2, 12, 10]);
    }
    
    // Piliers coniques pour les vis du couvercle
    for (x = [wall + pillar_bot_d/2, inner_l + wall - pillar_bot_d/2])
        for (y = [wall + pillar_bot_d/2, inner_w + wall - pillar_bot_d/2])
            translate([x, y, wall])
                difference() {
                    cylinder(d1 = pillar_bot_d, d2 = pillar_top_d, h = height - wall);
                    // Trou pour la vis (pré-trou pour auto-taraudeuse ou insert)
                    translate([0, 0, height - 12]) cylinder(d = 2.7, h = 13);
                }

    // Supports de fixation du PCB (Centrés dans l'espace restant)
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
            rounded_rect(inner_l + 2*wall, inner_w + 2*wall, wall + 2, corner_r);
            
            // Trous vis couvercle (alignés sur les piliers)
            for (x = [wall + pillar_bot_d/2, inner_l + wall - pillar_bot_d/2])
                for (y = [wall + pillar_bot_d/2, inner_w + wall - pillar_bot_d/2]) {
                    translate([x, y, -1]) cylinder(d = lid_screw_d, h = wall + 4);
                    // Fraisage pour tête de vis
                    translate([x, y, wall]) cylinder(d = 6, h = 3);
                }
                
            // Gravure "maxmilo"
            translate([(inner_l+2*wall)/2, (inner_w+2*wall)/2, wall + 1.5])
                linear_extrude(height = 1.1)
                    text("maxmilo", size = 7, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
        }
    }
}

box();
lid();
