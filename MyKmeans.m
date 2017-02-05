  
function [idx,C,sumD,D] = MyKmeans(X,K,C0,numIter)
    rows = size(X,1);        % number of rows
    cols = size(X,2);        % number of columns
    C = zeros(K,cols);       % k x p matrix which has cluster centers
    sumD = zeros(K,1);       % k x 1 column vector sum of how far all points in a group are to the center 
    idx = zeros(rows,1);     % n x 1 column vector containing row indexes for center 
    D = zeros(rows,K);       % n x k matrix containing distances for each point to every center 

   
    for i=1:numIter
        
        % DISTANCES FROM POINT P TO CENTER CENTER
        cluster_amount = zeros(K,1);

        for p= 1:rows     % --- Step 1) Find disances between point and centers (idx & D)

            min_distance_index = 1; % initial center 
            min_distance = sqrt(sum((C0(1,:)-X(p,:)).^2));
            
            for center= 1:K %---- fe center find distance between point and it 
              
              distance = sqrt(sum((C0(center,:)-X(p,:)).^2));
                            
              D(p,center) = distance;       % distance from point to center
              
              if distance < min_distance
                  min_distance_index = center; 
                  min_distance = distance;
              end
              
            end
            cluster_amount(min_distance_index, 1) = cluster_amount(min_distance_index, 1)+1; %how much people are in the group
            idx(p,1) = min_distance_index; % closest center index 
        end
        %--------------------------------
        
       % --- Step 2) Compute centeroid of group and new center. (C0/C)

           % Sum up all point coordinates
           C = zeros(K,cols);
           for row_num=1:rows
               C(idx(row_num,1), :) =  C(idx(row_num,1), :) + X(row_num,:); % add up stuff
           end
           
           % Average all points coordinates
           for elem = 1: K
                C(elem,:) = C(elem,:)/ cluster_amount(elem,1);
           end
           
           % Compute Closest and reset C0
           min_distances = zeros(K,1); % hold smallest distance to cluster ki
  
           for elem = 1:rows 
                 clust_num = idx(elem,1);               
                 distance = sqrt(sum((X(elem,:)-C(clust_num,:)).^2)); % distance between point elem and center 
    
                 if distance < min_distances(clust_num,1)        % if distance is smallest one 
                     
               
                        C0(clust_num,:) = X(elem,:);
                        min_distances(clust_num,1) = distance;
                 end             
           end
        
          C = C0;
        
        
    end

    % Compute
        % d is distance 
        % sumD the sum of the columns of D 
        
   
       % square ec distances 
    for i=1:rows
        D(i,:)= D(i,:).^2;
    end
    
        % compute sumD by going through idx to find cluster group
        
   for i =1:rows
       sumD(idx(i,1), 1) = sumD(idx(i,1), 1) + D(i,idx(i,1));
   end
    
 end



    

