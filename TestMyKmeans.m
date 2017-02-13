
function TestMyKmeans(filename,numRepeat, numIter)

    data = importdata(filename);
    Y = data(:,1)+1; X = data(:,2:end); clear data;
    K = max(Y); n = length(Y);

    for i= 1:n    
        X(i,:) = X(i,:) / norm(X(i,:), 2);
    end;
    
    SD1 = zeros(numRepeat,numIter);
    for i = 1:numRepeat
        i
        C0 = X(randsample(n,K),:);
        % SD1(i,:)
        tic;[idx1{i},C1,SD1(i,:),D1{i}]=MyKmeans(X,K,C0,numIter); T1(i) = toc;
        tic;[idx2{i},C2,sumd2,D2{i}]=kmeans(full(X),K,'Start',full(C0),'Maxiter',numIter);
        T2(i)=toc;
        SD2(i,:) = sum(sumd2);

        % Mat Lab K Means
        idx2_RowForm = idx2{i}(:,1);
        idx2_RowForm = idx2_RowForm';
        acc2(1,i) = evalClust_Error(idx2_RowForm,Y);
        
        % My Kmeans 
        for t = 1:numIter
           acc1(i,t) = evalClust_Error(idx1{i}(t,:),Y);
        end
      
        disp('');
        output = [acc1(1:i,end) acc2(1:i)' SD1(1:i,end) SD2(1:i) T1(1:i)' T2(1:i)'];
        
        
        feval('save',[filename '.summary.txt'],'output','-ascii');
 end
     
%----------------Plot SD 
figure;
plot(1:numIter,SD1,'linewidth',2);hold on; grid on;
set(gca,'FontSize',20);
xlabel('Iteration');ylabel('SD');
title(filename);

%----------------Plot Accuracies
figure;
plot(1:numIter,100*acc1,'linewidth',2);hold on; grid on;
set(gca,'FontSize',20);
xlabel('Iteration');ylabel('Accuracy (%)');
title(filename);

% average line
averages = zeros(1,numIter);
for i=1:numRepeat
    plot(numIter,100*acc1(i,numIter),'-o','linewidth',4); hold on;
end 
for i=1:numIter
    averages(1,i) = mean(acc1(:,i));
end

plot(1:numIter,100*averages,'k', 'linewidth',3, 'linestyle','--');hold on; grid on;
plot(numIter,100*averages(1,numIter),'r-p','linewidth',4);hold on;

% circles



%----------------Plot Times
figure;
ylabel('Maltab Kmeans Time');xlabel('My Kmeans Time');hold on;
title(filename);hold on;

% get max of each one 
max1 = T1(1); % X
max2 = T2(1); % Y

for i=1:numRepeat
    if T1(i)>max1
        max1 = T1(i);
    end
    if T2(i)>max2
        max2 = T2(i);
    end

end

axis([0,max1,0,max2 ]); hold on;
x = linspace(0,max1);hold on;
y = x;hold on;
plot(x,y,'r', 'linestyle','--');hold on;
hold on;

for i=1:numRepeat
    plot(T1(1,i),T2(1,i),'b--d','linewidth',4);
    hold on;

end
