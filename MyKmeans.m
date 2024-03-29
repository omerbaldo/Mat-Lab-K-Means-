function [idx,C,SD,D] = MyKmeans(X,K,C0,numIter)
      SD = zeros(1,numIter);   % sum of sumD at each iteration 
      rows = size(X,1);        % number of rows 
      cols = size(X,2);        % number of columns
      C = C0;                  % k x p matrix which has cluster centers
      sumD = zeros(K,1);       % k x 1 column vector sum of how far all points in a group are to the center 
      idx = zeros(rows,1);     % n x 1 column vector containing row indexes for center 
      D = zeros(rows,K);       % n x k matrix containing distances for each point to every center 
      idxPerIteration = zeros(numIter,rows);

      for i=1:numIter
          ixxxx = i;
          for p= 1:rows                        
            min_distance_index = 1;          
            min_distance = sum((C(1,:)-X(p,:)).^2);    
            for center= 1:K                   
              distance = sum((C(center,:)-X(p,:)).^2);                    
              D(p,center) = distance;          
              if distance < min_distance
                  min_distance_index = center; 
                  min_distance = distance;
              end
            end
            idx(p,1) = min_distance_index; 
          end
          
          C = zeros(K,cols);
          member_amount = zeros(K,1);
          % Recompute centers 
          for point_index=1:rows
              
              %add all center points 
              center_index_for_point_p = idx(point_index,1);
              member_amount(center_index_for_point_p,1) = member_amount(center_index_for_point_p,1) + 1; 
              
              C(center_index_for_point_p,:) = C(center_index_for_point_p,:) + X(point_index,:);
             
          end
                    
          % Average all points coordinates
          for elem = 1: K
              C(elem,:) = C(elem,:)/ member_amount(elem,1);
          end
          
          
         for i=1:rows      % computer SUMD 
           sumD(idx(i,1), 1) = sumD(idx(i,1), 1) + D(i,idx(i,1));
         end
         
         ss = 0;
         for i=1:K
           ss = ss + sumD(i,1);
         end 
         SD(1,ixxxx) = ss;
         
         idxPerIteration(ixxxx,:) = idx';
          
      end % End Loop

           
     
      for p= 1:rows             % Recompute Distances                        
            min_distance = sum((C(1,:)-X(p,:)).^2);    
            for center= 1:K                   
              distance = sum((C(center,:)-X(p,:)).^2);                    
              D(p,center) = distance;          
              if distance < min_distance
                  min_distance = distance;
              end
            end
      end
      
      
      for i=1:rows      % computer SUMD 
           sumD(idx(i,1), 1) = sumD(idx(i,1), 1) + D(i,idx(i,1));
      end 
      
      ss = 0;
      for i=1:K
          ss = ss + sumD(i,1);
      end 
      SD(1,numIter) = ss;

      
      % idx flipped
      
      idx = idxPerIteration;
      
      
      
end % end function