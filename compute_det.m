function Determinant = compute_det(window, k, theta, z0, Id, sqrt_H0_inv, V, N)
%     Computes det(Id - K) in search window

    Determinant = zeros(size(window));
%     Constant term |θ|^2-z0:
    qm = (theta^2 - z0) * Id;
%     First part of potential term:  H_0^(-1/2)(|θ|^2−1+V):
    A = sqrt_H0_inv * (qm+V);
    parfor n=1:length(window(:))
        z = window(n);
        diag_grad = 2*(theta*k)./(z - z0 - k.^2);                       %Gradient term-2iθ∇:
        grad = spdiags(diag_grad.', 0, 2*N+1, 2*N+1);
        diag_resolvent = sqrt(z0 + k.^2)./(z - z0 - k.^2);
        sqrt_H0_resolvent = spdiags(diag_resolvent.', 0, 2*N+1, 2*N+1); % Resolvent:
        K = grad + A * sqrt_H0_resolvent;                               % Compact operator K(z,θ):
        Determinant(n) = det(Id - K);
    end
end