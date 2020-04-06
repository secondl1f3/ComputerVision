function [C, S, wc] = discreteWavletTrans(I, J, lpfCoeff)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to compute discrete wavelet transform at level J of an image using provided
% low pass filter coefficients
%
% Input
% I           -       input image
% J           -       Number of levels
% lpfCoeff    -       Low Pass Filter Coefficients
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%size of image
[m,n] = size(I);

%calculate HPF coeff
hpfCoeff = lpfCoeff.*power(-1*ones(1,length(lpfCoeff)),(0:length(lpfCoeff)-1)); % make the even terms negative
hpfCoeff=hpfCoeff(length(hpfCoeff):-1:1); % flip the terms

C = [];
S = [m, n];

for level = 1:1:J
    
    if (level > 1)
        C = C(1, numel(I)+1:end);
    end
    
    %% FWT ON ROW
    %apply LPF
    ILpfRow = my_filter2d(I, lpfCoeff, 1);
    
    %apply downsampling
    IDsRowLpf = my_ds2d(ILpfRow, 1);
    
    %apply HPF
    IHpfRow = my_filter2d(I, hpfCoeff, 1);
    
    %apply downsampling
    IDsRowHpf = my_ds2d(IHpfRow, 1);
    
    IRow = [IDsRowLpf IDsRowHpf];
    
    %% FWT ON COLUMN
    %apply LPF
    ILpfCol = my_filter2d(IRow, lpfCoeff, 0);
    
    %apply downsampling
    IDsColLpf = my_ds2d(ILpfCol, 0);
    
    %apply HPF
    IHpfCol = my_filter2d(IRow, hpfCoeff, 0);
    
    %apply downsampling
    IDsColHpf = my_ds2d(IHpfCol, 0);
    
    %arrange them in matrix
    ICol = [IDsColLpf; IDsColHpf];
    
    %size matrix
    S = [[m,n]./2^level; S];
    
    %split to various apprximate and eatisl coeff
    Atemp = ICol(1:S(1,1), 1:S(1,1));
    Htemp = ICol(1:S(1,1), S(1,1)+1:S(2,1));
    Vtemp = ICol(S(1,1)+1:S(2,1), 1:S(1,1));
    Dtemp = ICol(S(1,1)+1:S(2,1), S(1,1)+1:S(2,1));
    
    %arrange them to from coefficents and size matrices
    C = [Atemp(:)' Htemp(:)' Vtemp(:)' Dtemp(:)' C];
    
    
    % use approximate coeff for next iterations
    I = Atemp;
    
    %arrange coeff in matrix for display purpose
    wc(1:S(1,1), 1:S(1,1)) = Atemp;
    wc(1:S(1,1), S(1,1)+1:S(2,1)) = Htemp;
    wc(S(1,1)+1:S(2,1), 1:S(1,1)) = Vtemp;
    wc(S(1,1)+1:S(2,1), S(1,1)+1:S(2,1)) = Dtemp;

end

