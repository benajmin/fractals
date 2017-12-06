menger(4);

module menger(n){
    if (n==1){
        cube([1,1,1]);
    }else{
        x = pow(3,n-2);
        
        menger(n-1);
        translate([x,0,0]){
            menger(n-1);
        }
        translate([2*x,0,0]){
            menger(n-1);
        }
        translate([0,x,0]){
            menger(n-1);
        }
        translate([2*x,x,0]){
            menger(n-1);
        }
        translate([0,2*x,0]){
            menger(n-1);
        }
        translate([x,2*x,0]){
            menger(n-1);
        }
        translate([2*x,2*x,0]){
            menger(n-1);
        }
        
        translate([0,0,x]){
            menger(n-1);
        }
        translate([2*x,0,x]){
            menger(n-1);
        }
        translate([0,2*x,x]){
            menger(n-1);
        }
        translate([2*x,2*x,x]){
            menger(n-1);
        }
        
        translate([0,0,2*x]){
            menger(n-1);
        }
        translate([x,0,2*x]){
            menger(n-1);
        }
        translate([2*x,0,2*x]){
            menger(n-1);
        }
        translate([0,x,2*x]){
            menger(n-1);
        }
        translate([2*x,x,2*x]){
            menger(n-1);
        }
        translate([0,2*x,2*x]){
            menger(n-1);
        }
        translate([x,2*x,2*x]){
            menger(n-1);
        }
        translate([2*x,2*x,2*x]){
            menger(n-1);
        }
            
        
    }
}