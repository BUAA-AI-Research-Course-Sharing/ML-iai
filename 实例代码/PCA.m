D = [-5,-5;
     -5,-4;
     -4,-5;
     -5,-6;
     -6,-5;
     5,5;
     5,4;
     4,5;
     5,6;
     6,5];

m = mean(D);
D = D - m;
cov_matrix = cov(D);
[vector,eigen] = eig(cov_matrix);
display(diag(eigen));
display(vector);
