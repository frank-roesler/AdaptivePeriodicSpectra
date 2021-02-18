function y = box(Lattice, Subset, r)
%     Computes r-neighbourhood of Subset
    y = zeros(size(Lattice));
    for z = Subset
        y = y | abs(Lattice - z)<r;
    end
end