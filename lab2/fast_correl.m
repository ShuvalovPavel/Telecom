function [cr]=fast_correl(seq, sync)
  tic();
  fseq=fft(seq, 16);
  fsync=fft(sync, 16);
  csync=conj(fsync);
  fast_corr=ifft(fseq.*csync);
  cr=fast_corr;
  toc()
  plot(fast_corr);
  
  