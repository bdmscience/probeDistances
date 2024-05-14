particles = readtable('1.csv'); %read in your particle file
mkdir ''; %create output directory
cd ''; %go to output directory
x1 = particles.x(particles.vis_probe == 0); %load in x position of probe 1
y1 = particles.y(particles.vis_probe == 0); %load in y position of probe 1
x2 = particles.x(particles.vis_probe == 1); %load in x position of probe 2
y2 = particles.y(particles.vis_probe == 1); %load in y position of probe 2
x3 = particles.x(particles.vis_probe == 2); %load in x position of probe 3
y3 = particles.y(particles.vis_probe == 2); %load in y position of probe 3

%analysis round 1: probe3 to probe1
cent1 = [mean(x1),mean(y1)]; %find the center of probe 1
cent2 = [mean(x2),mean(y2)]; %find the center of probe 2
cent3 = [mean(x3),mean(y3)]; %find the center of probe 3

%%%%%comment out the comparisons you do not want to perform. note that
%%%%%they write the 'r' variable and cannot be performed simultaneously

% Compare probe 3 to probe 1
r = cent3-cent1;
% Compare probe 2 to probe 1
%r = cent2-cent1;
% Compare probe 3 to probe 2
%r = cent3-cent2;

rmag = norm(r);
angle = atan(r(2)/r(1)); %angle of the distance vector in radians
% rotation matrix is [x cos, -y sin; x sin, y cos]

%%%%% uncomment this section to compare 3 to 1 %%%%%%
q3 = [x3*cos(-angle)-y3*sin(-angle),x3*sin(-angle)+y3*cos(-angle)];
q1 = [x1*cos(-angle)-y1*sin(-angle),x1*sin(-angle)+y1*cos(-angle)];
dist1 = q1(:,1)-mean(q1(:,1));
dist3 = q3(:,1)-mean(q1(:,1)); % distance along the centroid-centroid axis
if mean(dist3) < 0
    dist3 = -dist3;
end

% %%%%% uncomment this section to compare 2 to 1 %%%%%%
% q2 = [x2*cos(-angle)-y2*sin(-angle),x2*sin(-angle)+y2*cos(-angle)];
% q1 = [x1*cos(-angle)-y1*sin(-angle),x1*sin(-angle)+y1*cos(-angle)];
% dist1 = q1(:,1)-mean(q1(:,1));
% dist2 = q2(:,1)-mean(q2(:,1)); % distance along the centroid-centroid axis
% if mean(dist2) < 0
%    dist2 = -dist2;
% end
% 
% %%%%% uncomment this section to compare 3 to 2 %%%%%% 
% q3 = [x3*cos(-angle)-y3*sin(-angle),x3*sin(-angle)+y3*cos(-angle)];
% q2 = [x2*cos(-angle)-y2*sin(-angle),x2*sin(-angle)+y2*cos(-angle)];
% dist3 = q3(:,1)-mean(q3(:,1));
% dist2 = q2(:,1)-mean(q2(:,1)); % distance along the centroid-centroid axis
% if mean(dist3) < 0
%    dist3 = -dist3;
% end

% % %%%%% uncomment this section to compare m to n %%%%%% 
% use this section to compare any probe to any other probe change m and n
% to the appropriate probe number
% qm = [xm*cos(-angle)-ym*sin(-angle),xm*sin(-angle)+ym*cos(-angle)];
% q2 = [x2*cos(-angle)-y2*sin(-angle),x2*sin(-angle)+y2*cos(-angle)];
% distm = qm(:,1)-mean(qm(:,1));
% distn = qn(:,1)-mean(qm(:,1)); % distance along the centroid-centroid axis
% if mean(dist3) < 0
%    dist3 = -dist3;
% end

%%%%save distances as CSV%%%%%
writematrix (dist3,'3.csv'); %save probe 3 distances
%writematrix (dist2,'2.csv'); %save probe 2 distances
writematrix (dist1,'1.csv'); %save probe 1 distances
