clear, clc, close all

file = dir('*.mp3');
M = length (file);
for k = 1:M    
    [speech,fs]= audioread(fullfile(file(k).name));


    rho = 0.4;
    gamma = 0.9;
    num_coeff = 12;

    frame_length = 0.025; %msec
    frame_shift  = 0.010; %msec

    NFFT         = 512;
    pre_emph     = true;

    %%% Pre-emphasis + framing 
    if (pre_emph)
        speech = filter([1 -0.97], 1, speech);
    end
    frame_length = round((frame_length)*fs);
    frame_shift = round((frame_shift)*fs);
    [frames] = v_enframe(speech, hamming(frame_length), frame_shift);
    %ts = (ts-1)/fs;

    frame_num    = size(frames, 1);
    frame_length = size(frames, 2);
    delay_vector = (1:1:frame_length);
    delay_matrix = repmat(delay_vector, frame_num, 1);

    delay_frames = frames .* delay_matrix;

    x_spec = fft(frames', NFFT);
    y_spec = fft(delay_frames', NFFT);
    x_spec = x_spec(1:NFFT/2+1, :);
    y_spec = y_spec(1:NFFT/2+1, :);

    temp_x_spec = abs(x_spec);

    dct_spec = dct(medfilt1(log(temp_x_spec), 5));
    smooth_spec = idct(dct_spec(1:30,:), NFFT/2+1);

    grp_phase1 = (real(x_spec).*real(y_spec) + imag(y_spec) .* imag(x_spec)) ./(exp(smooth_spec).^ (2*rho));
    grp_phase = (grp_phase1 ./ abs(grp_phase1)) .* (abs(grp_phase1).^ gamma);
    grp_phase = grp_phase ./ (max(max(abs(grp_phase))));

    grp_phase(isnan(grp_phase)) = 0.0;
    %figure;
    %plot(grp_phase);
    cep = dct(grp_phase);
    cep = cep(2:num_coeff+1, :)';
    %figure(1);
    %plot(grp_phase)
    
    %figure;
    %plot(cep);
   
    disp(cep)
    filename = sprintf('gp_oriya_%d.txt',k);     
    fprintf('loop: %i\n',k);
    fid = fopen(filename,'wt');
    fprintf(fid,'%.8f\n', cep);
    fclose(fid);
    %filename = sprintf('%s_%d','wtfstartswithvi_',k);
    %writematrix('%8.f',cep,filename);
    %sprintf('%16.f', cep);

    
    %writematrix(cep, 'cepstrum_features_pa-IN_21722988_features.txt');
    %writematrix(ceps, '~/Documents/ssp_project/Punjabipitch_features08.csv');
   % fprintf(cep);

    %end
end    
%plot(grp_phase);