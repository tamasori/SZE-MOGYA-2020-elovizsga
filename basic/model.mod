param nRows;
param cashierCount;
param cashierLength;

set ProductGroups;
param space{ProductGroups};
var BuildingLength;

var assignCashiers{1..nRows, 1..cashierCount} binary;
var assignProductGroups{1..nRows, ProductGroups} binary;


s.t. everyCashierMustBeAssigned{c in 1..cashierCount}:
    sum{r in 1..nRows} assignCashiers[r,c]=1;
s.t. everyProductGroupMustBeAssigned{p in ProductGroups}:
    sum{r in 1..nRows} assignProductGroups[r,p]=1;
s.t. everyRowHasToContainSomething{r in 1..nRows}:
    ((sum{c in 1..cashierCount}assignCashiers[r,c]) + (sum{p in ProductGroups} assignProductGroups[r,p])) >= 1;

subject to C2 {r in 1..nRows}: BuildingLength >= ((sum{c in 1..cashierCount}assignCashiers[r,c]*cashierLength) + (sum{p in ProductGroups} assignProductGroups[r,p]*space[p]));


param totalLength;

minimize obj:BuildingLength;

solve;
printf "%f\n",BuildingLength;
