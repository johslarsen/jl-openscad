// https://en.wikipedia.org/wiki/Hexagon#Parameters

// The length of sides in / inradius in a hexagon with circumradius (R).
function hexagonSide(R) = (sqrt(3) / 2) * R;

// The circumradius in a hexagon with sides/inradius (s).
//
// A centered hexagon with vertices facing x-wards and sides facing y-wards can
// be created with e.g: (use rotate([0,0,30]) to orient the other way)
//
//     cylinder(r = hexagonRadius(s), $fn = 6);
function hexagonRadius(s) = (2 / sqrt(3)) * s;

// A honeycomb structure made up of hexagons with circumradius (R) with the
// given spacing and number of layers wrapped around a center hexagon outwards
// in a hexagonal pattern.
module honeycomb(R, spacing, layers)
{
    module triangularSection()
    {
        d = 2 * hexagonSide(R) + spacing;
        for (i = [1:layers])
            for (j = [0:i - 1])
                translate([ j * hexagonSide(d), j / 2 * d - i * d ]) circle(r = R, $fn = 6);
    }

    rotate([ 0, 0, 30 ]) // orient the same way as an openscad "hexagon"
    {
        circle(r = R, $fn = 6);
        for (q = [1:6])
            rotate([ 0, 0, q * 60 ]) triangularSection();
    }
}
