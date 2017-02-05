    %data = importdata('text.mat');

%load fisheriris
%X = meas(:,3:4);
X = [0 2;1 1; 1 2; 5 4; 5 5; 6 5;];   % notebook example
%X = [1.0 1.0;1.5 2.0; 3.0 4.0;5.0 7.0; 3.5 5.0;4.5 5.0;3.5 4.5;] %internet
%example http://mnemstudio.org/clustering-k-means-example-1.htm

%for i= 1:size(X,1)            % normalization
%       X(i,:) = X(i,:) / norm(X(i,:), 2);
%end;

data = importdata('text.mat');
X = data(:,2:end);

C0 = zeros(2,size(X,2));
C0(1,:) = X(1,:);
C0(2,:) = X(2,:);

[idx,C,sumd, D] = kmeans(full(X),2);
[idx2,C2,sumd2, D2] = MyKmeans(X,2,C,10);

  
    %data = [0 2;1 1; 1 2; 5 4; 5 5; 6 5;];
    %data = sparse(data);
%{
    Y = data(:,1)+1; X = data(:,2:end); clear data;
    
    K = max(Y); n = length(Y);C0 = X(randsample(n,K),:);rows = size(X,1);
    
    for i= 1:rows    
        X(i,:) = X(i,:) / norm(X(i,:), 2);
    end;
    
    [idx{i},C,sumD,D{i}]=kmeans(full(X),K,'Start',full(C0),'Maxiter',3)

%}