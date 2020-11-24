function [f]=v_enframe(x,win,hop,m,fs)

nx=length(x(:));
if nargin<2 || isempty(win)
    win=nx;
end
if nargin<4 || isempty(m)
    m='';
end
nwin=length(win);
if nwin == 1
    lw = win;
    w = ones(1,lw);
else
    lw = nwin;
    w = win(:).';
end
if (nargin < 3) || isempty(hop)
    hop = lw; % if no hop given, make non-overlapping
elseif hop<1
    hop=lw*hop;
end
if any(m=='a')
    w=w*sqrt(hop/sum(w.^2)); % scale to give unity gain for overlap-add
elseif any(m=='s')
    w=w/sqrt(w*w'*lw);
elseif any(m=='S')
    w=w/sqrt(w*w'*lw/hop);
end
if any(m=='d') % scale to give power/energy densities
    if nargin<5 || isempty(fs)
        w=w*sqrt(lw);
    else
        w=w*sqrt(lw/fs);
    end
end
nli=nx-lw+hop;
nf = max(fix(nli/hop),0);   % number of full frames
na=nli-hop*nf+(nf==0)*(lw-hop);       % number of samples left over
fx=nargin>3 && (any(m=='z') || any(m=='r')) && na>0; % need an extra row
f=zeros(nf+fx,lw);
indf= hop*(0:(nf-1)).';
inds = (1:lw);
if fx
    f(1:nf,:) = x(indf(:,ones(1,lw))+inds(ones(nf,1),:));
    if any(m=='r')
        ix=1+mod(nf*hop:nf*hop+lw-1,2*nx);
        f(nf+1,:)=x(ix+(ix>nx).*(2*nx+1-2*ix));
    else
        f(nf+1,1:nx-nf*hop)=x(1+nf*hop:nx);
    end
    nf=size(f,1);
else
    f(:) = x(indf(:,ones(1,lw))+inds(ones(nf,1),:));
end
if (nwin > 1)   % if we have a non-unity window
    f = f .* w(ones(nf,1),:);
end
if any(lower(m)=='p') % 'pP' = calculate the power spectrum
    f=fft(f,[],2);
    f=real(f.*conj(f));
    if any(m=='p')
        imx=fix((lw+1)/2); % highest replicated frequency
        f(:,2:imx)=f(:,2:imx)+f(:,lw:-1:lw-imx+2);
        f=f(:,1:fix(lw/2)+1);
    end
elseif any(lower(m)=='f') % 'fF' = take the DFT
    f=fft(f,[],2);
    if any(m=='f')
        f=f(:,1:fix(lw/2)+1);
    end
end
if nargout>1
    if any(m=='E')
        t0=sum((1:lw).*w.^2)/sum(w.^2);
    elseif any(m=='A')
        t0=sum((1:lw).*w)/sum(w);
    else
        t0=(1+lw)/2;
    end
    t=t0+hop*(0:(nf-1)).';
end


