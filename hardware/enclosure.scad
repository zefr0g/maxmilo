// maxmilo - Boîtier Robuste avec Fixations par Vis
// Optimisé pour l'adaptateur ESP-01 (42mm x 24.1mm)

// --- Paramètres ---
pcb_l = 42.0;
pcb_w = 24.1;
pcb_h_offset = 5; // Hauteur des supports pour laisser passer les soudures

// Trous de la carte (estimés d'après photo)
pcb_hole_dist_x = 38.0; 
pcb_hole_dist_y = 20.0;
pcb_hole_d = 2.5; // Pour vis M2 ou auto-taraudeuses

// Dimensions extérieures
wall = 2.0;
inner_l = pcb_l + 4; // Marge pour connecteurs
inner_w = pcb_w + 4;
height = 25; // Assez haut pour l'ESP-01 branché sur l'adaptateur
corner_r = 4;

lid_screw_d = 3.2; // Pour vis M3

$fn = 32;

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
        
        // Vidage intérieur
        translate([wall, wall, wall])
            rounded_rect(inner_l, inner_w, height, corner_r - wall/2);
            
        // Découpe pour câble CN105 (côté headers)
        translate([inner_l + wall - 1, (inner_w + 2*wall)/2 - 6, wall + 4])
            cube([wall + 2, 12, 10]);
            
        // Trous pour vis du couvercle dans les coins
        for (x = [wall+3, inner_l+wall-3])
            for (y = [wall+3, inner_w+wall-3])
                translate([x, y, height - 10])
                    cylinder(d = 2.8, h = 11); // Pré-trou pour vis M3
    }
    
    // Supports de la carte PCB
    translate([wall + (inner_l-pcb_l)/2, wall + (inner_w-pcb_w)/2, wall]) {
        off_x = (pcb_l - pcb_hole_dist_x)/2;
        off_y = (pcb_w - pcb_hole_dist_y)/2;
        
        for (x = [off_x, off_x + pcb_hole_dist_x])
            for (y = [off_y, off_y + pcb_hole_dist_y])
                translate([x, y, 0])
                    difference() {
                        cylinder(d = 6, h = pcb_h_offset);
                        translate([0,0,1]) cylinder(d = pcb_hole_d - 0.5, h = pcb_h_offset);
                    }
    }
    
    // Colonnes de support pour les vis du couvercle
    difference() {
        intersection() {
             rounded_rect(inner_l + 2*wall, inner_w + 2*wall, height, corner_r);
             union() {
                for (x = [0, inner_l+wall])
                    for (y = [0, inner_w+wall])
                        translate([x, y, 0]) cube([wall+6, wall+6, height]);
             }
        }
        translate([wall, wall, wall])
            rounded_rect(inner_l, inner_w, height + 1, corner_r - wall/2);
            
        // On refait les trous pour être sûr
        for (x = [wall+3, inner_l+wall-3])
            for (y = [wall+3, inner_w+wall-3])
                translate([x, y, height - 10])
                    cylinder(d = 2.8, h = 11);
    }
}

module lid() {
    translate([0, inner_w + 10, 0]) {
        difference() {
            rounded_rect(inner_l + 2*wall, inner_w + 2*wall, wall + 2, corner_r);
            
            // Trous vis couvercle
            for (x = [wall+3, inner_l+wall-3])
                for (y = [wall+3, inner_w+wall-3]) {
                    translate([x, y, -1]) cylinder(d = lid_screw_d, h = wall + 4);
                    translate([x, y, wall]) cylinder(d = 6, h = 3); // Fraisage
                }
                
            // Gravure "maxmilo"
            translate([(inner_l+2*wall)/2, (inner_w+2*wall)/2, wall + 1.5])
                linear_extrude(height = 1)
                    text("maxmilo", size = 6, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
        }
    }
}

box();
lid();
