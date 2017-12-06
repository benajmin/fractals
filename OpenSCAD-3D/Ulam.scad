color("white"){
    ulam(225);
}

module ulam(n){
    for (i=[1:n]){
        x = floor((sqrt(i)-1)/2) - 
            min(ceil((sqrt(i)-1)/2)*2, 
                max(0,i-floor((sqrt(i)+1)/2)*2-
                        pow(floor((sqrt(i)+1)/2)*2-1,2))) + 
            min(ceil((sqrt(i)-1)/2)*2, 
                max(0,i-floor((sqrt(i)+1)/2)*6-
                        pow(floor((sqrt(i)+1)/2)*2-1,2))) + 
            ((floor((sqrt(i)-1)/2)==(sqrt(i)-1)/2)?0:1);

        y = floor((sqrt(i)-1)/2) - 
            min(ceil((sqrt(i)-1)/2)*2-1, 
                max(0,i-1-pow(floor((sqrt(i)+1)/2)*2-1,2))) + 
            min(ceil((sqrt(i)-1)/2)*2, 
                max(0,i-floor((sqrt(i)+1)/2)*4-
                        pow(floor((sqrt(i)+1)/2)*2-1,2))) +
            ((i==1)?-1:0);
        translate([x,y,0]){
            cube([1,1,divisors(i,1)]);
        }
    }
}

function divisors(n, i) = (i==n)?1:(divisors(n,i+1) + ((n%i==0)?1:0));
function height(n) = pow(2, 4-divisors(n,1))+1;