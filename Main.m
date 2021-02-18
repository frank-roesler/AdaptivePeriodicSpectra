%% Setup:
clear;
tic
resolution = 70;
N   = 40;                     % Size of matrix K
C   = 0.005;                  % threshold for determinant
n_t = round(2*pi*resolution); % number of theta points
z0  = -1;                     % Spectral shift

r = 200/n_t; % search radius for new zeros
n_sample = 10;           % for counting clusters in window

t = linspace(0,2*pi,n_t); % theta array
Id = speye(2*N+1);

% Define lattice in C:
z1 = 0-6i;
z2 = 35+6i;
M = abs(real(z2-z1))*resolution;
L = build_lattice(z1, z2, M);
h_L = 1/resolution;

%  Define potential matrix:
n_plot = 1e+6;
a = fourier_coefficient((-2*N-1):(2*N+1), n_plot);
V = compute_potential_matrix(a, N);

%  Define the vector of k's containing integer multiples of 2π:
k = -N:N;
k = 2*pi*k;

% Inverse square root of H0:
sqrt_H0_inv = spdiags(1./sqrt(z0 + k.^2).', 0, 2*N+1, 2*N+1);

%% Compute initial set of zeros:
disp('Computing strarting points...')
Spectrum = [];
ctr=1;
while isempty(Spectrum)
    theta = t(ctr);
    Determinant = compute_det(L, k, theta, z0, Id, sqrt_H0_inv, V, N);
    Spectrum = unique([Spectrum, L(abs(Determinant)<C).']);
end
Spectrum_temp = Spectrum;
Spectrum_temp_old = Spectrum_temp;
window        = L(box(L, Spectrum_temp, r));
window_old    = window;
clusters_old = n_clusters(window, n_sample);
disp('Done!')

%% Main loop:
disp('Now in main loop...')
figure('Position',[100 500 1000 300])

disp('Computing...')
for m=ctr:ceil(length(t))
    theta=t(m);
%     Plot results (disable for performance):
    plot_results(L, Spectrum, Spectrum_temp, window);
    
    Determinant = compute_det(window, k, theta, z0, Id, sqrt_H0_inv, V, N);
    Spectrum_temp = window(abs(Determinant)<C).' ;
    [window, clusters_old] = update_window(window_old, clusters_old, Spectrum_temp, Spectrum_temp_old, L, h_L, n_sample, r);
    window_old = window;
    Spectrum_temp_old = Spectrum_temp;
    Spectrum = unique([Spectrum,Spectrum_temp]);
end
disp('Done!')
disp([num2str(toc/60),' ',' minutes'])

%% Plot results:

figure('Position',[100 500 1000 700])

subplot(2,1,1)
x = linspace(0,1,1000);
plot(x, [real(potential(x)); imag(potential(x))]);

subplot(2,1,2)
plot_results(L, Spectrum, [], []);
