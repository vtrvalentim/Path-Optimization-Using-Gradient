clc; clear; close all;

initial_loc = [1,1];
cur_loc = initial_loc;
final_loc = [100,100];
mu = [25, 35; 85, 70];
sigma = [50, 0; 0, 50];

% Set up vector potential field
syms u v; % define symbolic variables to denote the coordintes on the potential field

% Symbolic equation that represents the potential field at any point (u, v)
z_sym(u, v) = (((final_loc(1,1)-u).^2 + (final_loc(1,2)-v).^2)/20000) + ...,
    1e4*(1/(det(sigma)*2*pi))*exp(-(1/2) .* [(u-mu(1,1)); (v-mu(1,2))]'*pinv(sigma)*[(u-mu(1,1)); (v-mu(1,2))]) + ...,
    1e4*(1/(det(sigma)*2*pi))*exp(-(1/2) .* [(u-mu(2,1)); (v-mu(2,2))]'*pinv(sigma)*[(u-mu(2,1)); (v-mu(2,2))]);

% Calculate symbolic derivatives of the field with respect to the coordinates u and v
dzdu_sym = diff(z_sym, u);
dzdv_sym = diff(z_sym, v);

% Convert symbolic functions into MATLAB functions for ease of use
z = matlabFunction(z_sym);
dx = matlabFunction(dzdu_sym);
dy = matlabFunction(dzdv_sym);
[x, y] = meshgrid(0:4:100);

%% Part 1
figure(1);
%subplot(2,1,1)
mesh(x, y, z(x,y)); hold on;
plot3(initial_loc(1,1),initial_loc(1,2),z(initial_loc(1,1),initial_loc(1,2)),'c*');hold on;
plot3(100,100,z(100,100),'r*'); hold on;
xlabel('x');
ylabel('y');
zlabel('z');
title('mesh');

%subplot(2,1,2)
%contour(x,y,z(x,y));hold on;
%quiver(x,y,-dx(x,y),-dy(x,y)); hold on;
%plot(1,1,'c*');hold on;
%plot(100,100,'r*'); hold on;
%xlabel('x');
%ylabel('y');
%title('contour');

%initial_loc = [1,1];
%cur_loc = initial_loc;
%final_loc = [100,100];



%% Part 2

%Press any key to begin the animation
pause;


for i=1:200
    
    
    noise = randn(1,2)/1e20;
    A = abs(1/sqrt((dx(cur_loc(1,1), cur_loc(1,2))).^2 + (dy(cur_loc(1,1), cur_loc(1,2))).^2));
    cur_loc = cur_loc + A.*([-dx(cur_loc(1,1),cur_loc(1,2)),-dy(cur_loc(1,1),cur_loc(1,2))]+noise);
    
    
    %Plot the bots current location on the mesh.
    %plot3(cur_loc(1,1), cur_loc(1,2), z(cur_loc(1,1), cur_loc(1,2)), '*b');
    %subplot(2,1,1)
    figure(1);
    plot3(cur_loc(1,1),cur_loc(1,2),z(cur_loc(1,1),cur_loc(1,2)),'b*');
    pause(.01);
    
end


hold off;


