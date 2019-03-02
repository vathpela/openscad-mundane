

module rounded_box(width, height, thickness, turn_r=4, $fn=100) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0]) {
	  hull() {
	       cylinder(thickness, turn_r, turn_r);
	       translate([width - turn_d, 0, 0])
		    cylinder(thickness, turn_r, turn_r);
	       translate([width - turn_d, height - turn_d, 0])
		    cylinder(thickness, turn_r, turn_r);
	       translate([0, height - turn_d, 0])
		    cylinder(thickness, turn_r, turn_r);
	  };
     };
}


module subtract_inset_same(width, height, rim, thick, inset) {

     difference() {
	  children();

	  translate([rim, rim, inset]) {
	       resize([width - (2 * rim), height - (2 * rim), thick]) {
		    children();
	       }
	  }
     };
}


module plaque_base(width=30, height=20, rim=1, thick=2, inset=1, $fn=100) {

     // magnet sizing
     magnet_d = 8;  // mm diameter
     magnet_h = 3;  // mm thickness
     magnet_r = magnet_d / 2;

     magnetc_r = magnet_r + 0.5;

     difference() {
	  union() {
	       subtract_inset_same(width, height, rim, thick, inset) {
		    render() rounded_box(width, height, thick);
	       };

	       // magnet holes
	       translate([magnetc_r + 2, magnetc_r + 2, 0])
		    cylinder(thick, magnetc_r, magnetc_r);
	       translate([width - magnet_r - 2, magnetc_r + 2, 0])
		    cylinder(thick, magnetc_r, magnetc_r);
	       translate([width - magnet_r - 2, height - magnetc_r - 2, 0])
		    cylinder(thick, magnetc_r, magnetc_r);
	       translate([magnet_r + 2, height - magnetc_r - 2, 0])
		    cylinder(thick, magnetc_r, magnetc_r);
	  };

	  // magnet holes
	  translate([magnet_r + 2, magnet_r + 2, -1])
	       cylinder(thick, magnet_r, magnet_r);
	  translate([width - magnet_r - 2, magnet_r + 2, -1])
	       cylinder(thick, magnet_r, magnet_r);
	  translate([width - magnet_r - 2, height - magnet_r - 2, -1])
	       cylinder(thick, magnet_r, magnet_r);
	  translate([magnet_r + 2, height - magnet_r - 2, -1])
	       cylinder(thick, magnet_r, magnet_r);
     };
}


module plaque(width=60, height=40, rim=6, thick=4, inset=1, $fn=100) {
     plaque_base(width, height, rim, thick, inset);

     offs = rim + 0.5;
     delt = (2 * rim) - 1;

     if ($children) {
	  translate([offs, offs, thick - inset]) {
	       intersection() {
		    resize([width - delt, height - delt, inset])
			 rounded_box(width, height, inset);

		    children();
	       }
	  }
     }
}


// The end.