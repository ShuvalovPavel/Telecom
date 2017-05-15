function [ times, signals ] = posledovatelnost( t, s, times,signals )
   if size(t,1)<2
       t = t';
   end
   if size(s,1)<2
       s = s';
   end
   times = [times ; t(1:1000)];
   signals = [signals ; s(1:1000)];
end