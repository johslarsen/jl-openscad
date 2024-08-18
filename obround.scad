// Two circles with diameter (d) stretched so the endpoints are length (l)
// apart. https://en.wikipedia.org/wiki/Stadium_(geometry)
module obround(d, l)
{
    x = (l - d) / 2;
    hull()
    {
        translate([ -x, 0, 0 ]) circle(d = d);
        translate([ x, 0, 0 ]) circle(d = d);
    }
}

// Two circles with diameter (d) stretched so the endpoints are length (l)
// apart, but squeezed by up-to concavity towards the center.
module obroundSqueezed(d, l, concavity, concavityFN = 0)
{
    x = (l - d) / 2; // distance to the center of the outer circles
    module middle()
    {
        R = d / 2;               // radius of outer circles
        r = (d - concavity) / 2; // shrunk to this radius in the middle of the obround

        // part between outer circles (R) with sides removed by a huge
        // circle (c) that is perpendicular to the center, and tangents the
        // both outer circles and the imagined circle (r) at the middle.

        // y := r + c // center of huge circle
        // H := R + c // hypotenuse between origin, y, and outer circle

        // H*H                 = x*x + y*y      // Pythagoras
        // (R+c)**2            = x+x + (r+c)**2
        // R*R + 2*R*c + c*c   = x*x + r*r + 2*r*c + c*c
        //       2*R*c - 2*r*c = x*x + r*r - R*R
        //       2*(R  -  r)*c = (x*x + r*r - R*R)
        c = (x * x + r * r - R * R) / (2 * (R - r));
        y = r + c;

        tangentX = x * (c / (R + c)); // itersection point between middle and outer circles
        difference()
        {
            translate([ -tangentX, -y ]) square([ 2 * tangentX, 2 * y ]);

            indent();
            mirror([ 0, 1, 0 ]) indent();
        }
        module indent()
        {
            translate([ 0, y ]) circle(r = c, $fn = concavityFN ? concavityFN : $fn);
        }
    }

    if (concavity == 0)
    {
        obround(d, l, h);
    }
    else
    {
        translate([ -x, 0, 0 ]) circle(d = d);
        middle();
        translate([ x, 0, 0 ]) circle(d = d);
    }
}
