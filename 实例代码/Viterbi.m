init_p = [0.2;0.4;0.4];
trans_p = [0.5,0.2,0.3;
           0.3,0.5,0.2;
           0.2,0.3,0.5];
out_p = [0.5,0.5;0.4,0.6;0.7,0.3];

V = zeros(3,3);
Ptr = zeros(3,3);

x = zeros(3,1);
y = [1;2;1];

V(1,:) = (out_p(:,y(1)).*init_p)';

for t=2:3,
  for k=1:3,
    max_id = 0;
    max_v = 0;
    for j=1:3,
      v = trans_p(j,k)*V(t-1,j);
      if v > max_v,
        max_v = v;
        max_id = j;
      endif
    endfor
    Ptr(t,k) = max_id;
    V(t,k) = max_v * out_p(k,y(t));
  endfor
endfor
max_id = 0;
max_v = 0;
for k=1:3,
  if V(3,k) > max_v,
    max_id = k;
    max_v = V(3,k);
  endif
endfor

x(3) = max_id;
for t=1:2,
  x(3-t) = Ptr(4-t,x(4-t));
endfor

display(x);
display(V);
display(Ptr);