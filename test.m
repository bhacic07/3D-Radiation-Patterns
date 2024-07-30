data = readtable('Dipole_915MHz.csv');

% Extract phi, theta, and dB(DirTotal)
phi = data{:, 1};
theta = data{:, 2};
dB = data{:, 3};

% Convert dB to linear scale for plotting
DirTotal = 10.^(dB/10);

% Create 3D radiation pattern
figure;
patternCustom(DirTotal, theta, phi);
title('3D Radiation Pattern');

% Create 2D radiation pattern
figure;
polarplot(deg2rad(phi), DirTotal);
title('2D Radiation Pattern');

% Convert spherical coordinates to Cartesian coordinates(3D plot)
r = DirTotal;
[phi_rad_3d, theta_rad_3d] = meshgrid(deg2rad(phi), deg2rad(theta));
x_3d = r .* sin(theta_rad_3d) .* cos(phi_rad_3d);
y_3d = r .* sin(theta_rad_3d) .* sin(phi_rad_3d);
z_3d = r .* cos(theta_rad_3d);

% Convert polar coordinates to Cartesian coordinates(2D plot)
phi_rad_2d = deg2rad(phi);
x_2d = r .* cos(phi_rad_2d);
y_2d = r .* sin(phi_rad_2d);
z_2d = zeros(size(x_2d));  

% Create table for 3D X, Y, Z coordinates
xyz_data_3d = table(x_3d(:), y_3d(:), z_3d(:), 'VariableNames', {'X', 'Y', 'Z'});

% Create table for 2D X, Y, Z coordinates( Z will be zero for the 2d data)
xyz_data_2d = table(x_2d(:), y_2d(:), z_2d(:), 'VariableNames', {'X', 'Y', 'Z'});

% Save 3D X, Y, Z coordinates to a Excel file
writetable(xyz_data_3d, 'xyz_coordinates_3d.csv');

% Save 2D X, Y, Z coordinates to a Excel file
writetable(xyz_data_2d, 'xyz_coordinates_2d.csv');

disp('3D and 2D radiation patterns have been plotted.');
disp('3D X, Y, Z coordinates saved to xyz_coordinates_3d.csv.');
disp('2D X, Y, Z coordinates saved to xyz_coordinates_2d.csv.');
