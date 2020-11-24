clear, clc, close all
%[x, Fs] = audioread('common_voice_or_21862901.mp3');
%t = 1/Fs;
file = dir('*.mp3');
M = length (file);
for k = 1:M  
    [x,Fs]= audioread(fullfile(file(k).name)); 

% hilbert transform
   hx = hilbert(x);
% Instantaneous amplitude
   inst_amp = abs(hx);
% Instantaneous frequency
   instt_freq = diff(unwrap(angle(hx)))/((1/Fs)*2*pi);

   
   filename = sprintf('ia_kannada_%d.txt',k); %use the name of the language file it's being used for
   %fprintf('instant amp \n');
   fprintf('loop:%i',k);
   fid = fopen(filename,'wt');
   fprintf(fid,'%.8f\n', inst_amp);  % 8 floating points to avoid getting outputs in scientific notation
   fclose(fid);

   
   filename2 = sprintf('if_kannada_%d.txt',k);
   %fprintf('instant amp \n');
   fprintf('loop:%i',k);
   fid2 = fopen(filename2,'wt');
   fprintf(fid2,'%.8f\n', instt_freq); % 8 floating points to avoid getting outputs in scientific notation
   fclose(fid2);

   figure;
   plot(x), title('Modulated signal')
   figure;
   plot(inst_amp), title('Instantaneous amplitude')
   figure;
   plot(instt_freq),title('Instantaneous frequency')
end
