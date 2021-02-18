function V = compute_potential_matrix(a,N)
%     Computes the matrix V from the potential's Fourier coefficients
    V = zeros(2*N+1);
    for j=-N:N
        for m=-N:N
            V(N+1+j,N+1+m) = a(2*N+2+j-m);
        end
    end
    V(abs(V)<1e-6) = 0; % Band limit to make V sparse. Remove this for higher accuracy.
    V = sparse(V);

    