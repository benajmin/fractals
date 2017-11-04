WIDTH = 10;
LENGTH = 20;
RES = 10;

color("MediumPurple", 1){hilbert(3);}

module hilbert(n){
    if (n == 0){
        // do nothing
    }else{
        connectors(n);

        translate([sizeof(n-1), sizeof(n-1), 0]){
            rotate([0, -90, 90]){
                hilbert(n-1);
            }
        }
        translate([2*sizeof(n-1)+LENGTH, sizeof(n-1), 0]){
            rotate([0, -90, 90]){
                hilbert(n-1);
            }
        }
        translate([0, sizeof(n-1)+LENGTH, 0]){
            rotate([0, -90, -90]){
                hilbert(n-1);
            }
        }
        translate([sizeof(n-1)+LENGTH, sizeof(n-1)+LENGTH, 0]){
            rotate([0, -90, -90]){
                hilbert(n-1);
            }
        }
        
        translate([sizeof(n-1), 0, sizeof(n)]){
            rotate([0, 180, 0]){
                hilbert(n-1);
            }
        }
        translate([sizeof(n-1), sizeof(n-1)+LENGTH, sizeof(n)]){
            rotate([0, 180, 0]){
                hilbert(n-1);
            }
        }
        translate([sizeof(n-1)+LENGTH, sizeof(n-1), sizeof(n)]){
            rotate([-90, 0, -90]){
                hilbert(n-1);
            }
        }
        translate([sizeof(n-1)+LENGTH, sizeof(n-1)+LENGTH, sizeof(n-1)+LENGTH]){
            rotate([90, 0, 90]){
                hilbert(n-1);
            }
        }
    }
}

module connectors(n){
    translate([sizeof(n), 0, sizeof(n-1)]){
        arm();
    }
    translate([sizeof(n), sizeof(n), sizeof(n-1)]){
        arm();
    }
    translate([sizeof(n-1), 0, sizeof(n-1)]){
        rotate([0, 90 ,0]){
            arm();
        }
    }
    translate([sizeof(n-1), sizeof(n), sizeof(n-1)]){
        rotate([0, 90 ,0]){
            arm();
        }
    }
    translate([0, sizeof(n-1), sizeof(n-1)+LENGTH]){
        rotate([-90, 0,0]){
            arm();
        }
    }
    translate([0, 0, sizeof(n-1)]){
        arm();
    }
    translate([0, sizeof(n), sizeof(n-1)]){
        arm();
    }
}

module arm(){
    translate([-WIDTH/2, -WIDTH/2, -WIDTH/2]){
        cube ( [WIDTH, WIDTH, LENGTH+WIDTH], $fn = RES);
    }
}

function sizeof(n) = (pow(2, n) - 1)*LENGTH;