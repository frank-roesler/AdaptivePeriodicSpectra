function L = build_lattice(z1, z2, horizontal_resolution)
%   Defines lattice L in the complex plane from corner points z1, z2
%   with horizontal_resolution grid points between re(z1) and re(z2)
    r1 = real(z1);
    r2 = real(z2);
    i1 = imag(z1);
    i2 = imag(z2);
    adjustment = (r2-r1)/(i2-i1);
    X = linspace(r1, r2, horizontal_resolution);
    Y = linspace(i1, i2, round(horizontal_resolution/adjustment));
    [XX,YY] = meshgrid(X,Y);
    L = XX+1i*YY;
end