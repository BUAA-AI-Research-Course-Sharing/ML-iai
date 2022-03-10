R = [0,0,0,0,0,0;
 0,0,0,0,0,100;
 0,0,0,0,0,0;
 0,0,0,0,0,0;
 0,0,0,0,0,100;
 0,0,0,0,0,100];

 
adj = [0,0,0,0,1,0;
 0,0,0,1,0,1;
 0,0,0,1,0,0;
 0,1,1,0,1,0;
 1,0,0,1,0,1;
 0,1,0,0,1,1];

 
Q = zeros(6,6);

gamma = 0.8;

while true,
  Q_next = zeros(6,6);
  for i = 1:6,
    for j = 1:6,
      if adj(i,j),
        Q_next(i,j) = R(i,j) + gamma * max(Q(j,:));
      endif
    endfor
  endfor
  if min(min(Q_next == Q)),
    display(Q);
    break
  endif
  Q = Q_next;
endwhile