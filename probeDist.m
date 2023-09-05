particles = readtable('1.csv');
mkdir '';
cd '';
x1 = particles.x(particles.vis_probe == 0);
y1 = particles.y(particles.vis_probe == 0);
x2 = particles.x(particles.vis_probe == 1);
y2 = particles.y(particles.vis_probe == 1);
x3 = particles.x(particles.vis_probe == 2);
y3 = particles.y(particles.vis_probe == 2);
%analysis round 1 probe3 to probe1
cent1 = [mean(x1),mean(y1)];
cent2 = [mean(x2),mean(y2)];
cent3 = [mean(x3),mean(y3)];
%%%%%comment out the comparisons you do not want to perform. note that
%%%%%they all write an 'r' variable and cannot be performed simultaneously
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

%%%%% uncomment this section to compare 2 to 1 %%%%%%
q2 = [x2*cos(-angle)-y2*sin(-angle),x2*sin(-angle)+y2*cos(-angle)];
q1 = [x1*cos(-angle)-y1*sin(-angle),x1*sin(-angle)+y1*cos(-angle)];
dist1 = q1(:,1)-mean(q1(:,1));
dist2 = q2(:,1)-mean(q2(:,1)); % distance along the centroid-centroid axis
if mean(dist2) < 0
   dist2 = -dist2;
end

%%%%% uncomment this section to compare 3 to 2 %%%%%% 
q3 = [x3*cos(-angle)-y3*sin(-angle),x3*sin(-angle)+y3*cos(-angle)];
q2 = [x2*cos(-angle)-y2*sin(-angle),x2*sin(-angle)+y2*cos(-angle)];
dist3 = q3(:,1)-mean(q3(:,1));
dist2 = q2(:,1)-mean(q2(:,1)); % distance along the centroid-centroid axis
if mean(dist3) < 0
   dist3 = -dist3;
end

%%%%save distances as CSV%%%%%
%writematrix (dist3,'3.csv');
%writematrix (dist3,'2.csv');
%writematrix (dist2,'1.csv');