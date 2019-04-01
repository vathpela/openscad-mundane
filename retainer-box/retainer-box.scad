/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GNU LGPL v3+
*/


use <../common/utils.scad>;
use <../common/hinges.scad>;
use <../common/clasp.scad>;
use <clamshell.scad>;


module retainer_box(i_width, i_depth, i_height, wall_thick=1.5) {

     // calculate the exterior dimensions based on the interior and
     // thickness
     e_width = i_width + (wall_thick * 2);
     e_depth = i_depth + (wall_thick * 2);
     e_height = i_height + (wall_thick * 2);

     // the half height will be the z offset needed for the hinge and
     // clasp features
     half_height = e_height / 2;

     // we're going to hard-code these settings for all retainer boxes
     gap = 4;
     hinge_barrel = 4;
     hinge_count = 4;

     half_gap = gap / 2;

     // create two clamshell halves mirroring each other
     full_clamshell(i_width, i_depth, i_height,
		    wall_thick, half_gap);

     // hinge height needs to be such that the center pin is aligned
     // to the top of the clamshell halves
     hinges(hinge_barrel, half_height, half_gap, hinge_count);

     // clasps need to be set on either far end, and then duplicated
     // to be on both halves

     // I like the feature of the clasp base to be visible, so I'm
     // pushing it out slightly
     clasp_fudge = 0.3;

     duplicate(rotate_v=[0, 0, 180]) {
	  translate([0, e_depth + half_gap + clasp_fudge, half_height]) {
	       rotate([90, 0, 180])
		    clasp_half();
	  };
     };
}


// The end.
