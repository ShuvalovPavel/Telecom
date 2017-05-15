r = [0 0 0 1 0 1 0 1 1 1 0 0 0 0 1 0]; 
m = [1 0 1]; 
tic();
x1 = xcorr(r, m);
toc()
subplot(2,1,1);
plot (x1)
x = fast_correl(r,m);
subplot(2,1,2);
plot (x)

for i=1:length(r)
  if (x(i)>1.5)
    r(i+3 : i+10)
    break;
  end
end