// https://en.wikipedia.org/wiki/Circular_segment#Radius_and_central_angle

// Radius of a circle with a segment that has height/sagitta (h) and chord (c)
function segmentRadius(h, c) = h / 2 + (c * c) / (8 * h);
// Chord of segment with height/sagitta (h) in a circle with radius (r)
function segmentChord(r, h) = 2 * sqrt(2 * r * h - h * h);
// Height/sagitta of segment with chord (c) in a circle with radius (r)
function segmentHeight(r, c) = r - sqrt(r * r - (c * c) / 4);

// Angle of the arc forming a segment with chord length (c) in a circle with radius (r)
function arcAngle(r, c) = 2 * asin(c / (2 * r));
// The radius of the circle for a segment with arc and chord length (c)
function arcRadius(arc, c) = c / (2*sin(arc/2));

// A 2-D circular segment
module segment(height, chord) {
    r = segmentRadius(height, chord);
    echo(height, segmentHeight(r, chord));
    echo(chord, segmentChord(r, height));

    intersection() {
        translate([r,0]) circle(r);
        translate([0,-r]) square([height,2*r]);
    }
}
