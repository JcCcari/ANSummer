This program find the intersection points of two functions.

1) Select two functions by clicking on them (Sometimes you have to try several times, be patient).
2) Click 'Get Intersection' Button.
3) Wait the program find the intersections.

Testing:
This cases are especials, normal cases are fine.

1) Case: There are no Intersections.
  f(x) = ln(x)
  g(x) = exp(x)

  NOTE: This bug is fixed.

2) Case: There are greather than one intersection.
  f(x) = sin(x)
  g(x) = cos(x)

  NOTE: This case is done.

3) First Especial Case
  f(x) = 10
  g(x) = tan(x)

  NOTE: For some reason, this example generates points out of range initial ( Min, Max in Form1 )
        but this bug is fixed.

4) Second Especial Case
   f(x) = sin(x)
   g(x) = cos(2*x)

   NOTE: This case is solved by aproximation.

5) Thirth Especial Case
   f(x) = 1
   g(x) = sin(x)

   NOTE: This case is solved by aproximation.

6) Fourth Especial Case
   f(x) = 1-x
   g(x) = (sin(x)/power(x,2))+ln(x)-x

   NOTE: This case is solved by aproximation.
