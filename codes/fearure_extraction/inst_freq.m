clear, clc, close all
%[x, Fs] = audioread('common_voice_or_21862901.mp3');
%t = 1/Fs;
file = dir('*.mp3');
M = length (file);
for k = 1:M  
    [x,Fs]= audioread(fullfile(file(k).name)); 

% performing the HILBERT TRANSFORM
   hx = hilbert(x);
% calculating the INSTANTANEOUS AMPLITUDE (ENVELOPE)
   inst_amp = abs(hx);
% calculating the INSTANTANEOUS FREQUENCY
   instt_freq = diff(unwrap(angle(hx)))/((1/Fs)*2*pi);
   %figure;
   %subplot(3,1,1), plot(x), title('Modulated signal')
   %subplot(3,1,2), plot(inst_amp), title('Instantaneous amplitude')

   %disp(inst_amp)
   
   filename = sprintf('ia_kannada_%d.txt',k);
   %fprintf('instant amp \n');
   fprintf('loop:%i',k);
   %n = size(instt_freq);
   %for ii = 1:n
   %fid = fopen(sprintf('if_oriya_%d.txt',k),'w');
   %fprintf(fid,'%6.4f\n',instt_freq);
   %filename = sprintf('pitches_%d.txt',k);
   fid = fopen(filename,'wt');
   fprintf(fid,'%.8f\n', inst_amp);
   fclose(fid);

   %end
   %disp(inst_amp)
   %filename = sprintf('%s_%d','ia_oriya_',k);
   %writematrix(inst_amp,filename);
   %fprintf('%i\n',instt_freq);
   
   %subplot(3,1,3), plot(instt_freq),title('Instantaneous frequency')
end