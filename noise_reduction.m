function [A] = noise_reduction(A)
    [r,c] = size(A);
    min_points_h = 90;
    max_gap_h = 110;
    min_points_v = 5;
    max_gap_v = 25;
    for i = 1:r
        indices = find(A(i,:)==1);
        if length(indices) > 1
            differences = diff(indices);
            %Finding where the gaps are and filtering them in big and small
            big_gap_ind = find(differences > max_gap_h);
            differences(differences==1) = (max_gap_h + 1);
            small_gap_ind = find(differences < (max_gap_h + 1));
            %filling the small gaps
            for j = 1:length(small_gap_ind)
                for k = 1:differences(small_gap_ind(j))-1
                    A(i,indices(small_gap_ind(j))+k)=1;
                end
            end

            %deleting lines separated by a big gap
            for j = 1:(length(big_gap_ind)+1)
                if length(big_gap_ind) < 1
                    start_line = indices(1);
                    end_line = indices(end);

                elseif j == (length(big_gap_ind)+1)
                    start_line = indices(big_gap_ind(j-1) + 1);
                    end_line = indices(end);

                elseif j == 1
                    start_line = indices(j);
                    end_line = indices(big_gap_ind(j));

                else
                    start_line = indices(big_gap_ind(j-1)+1);
                    end_line = indices(big_gap_ind(j));  
                end

                if (end_line - start_line) >= min_points_h
                    for k = start_line:end_line
                        A(i,k) = 0;
                    end
                end
            end
        end
    end
    for i = 1:c
        indices = find(A(:,i)==1);
        if length(indices) > 1
            differences = diff(indices);
            %Finding where the gaps are and filtering them in big and small
            big_gap_ind = find(differences > max_gap_v);
            differences(differences==1) = (max_gap_v + 1);
            small_gap_ind = find(differences < (max_gap_v + 1));
            %filling the small gaps
            for j = 1:length(small_gap_ind)
                for k = 1:differences(small_gap_ind(j))-1
                    A(indices(small_gap_ind(j))+k,i)=1;
                end
            end

            %deleting lines separated by a big gap
            for j = 1:(length(big_gap_ind)+1)
                if length(big_gap_ind) < 1
                    start_line = indices(1);
                    end_line = indices(end);

                elseif j == (length(big_gap_ind)+1)
                    start_line = indices(big_gap_ind(j-1) + 1);
                    end_line = indices(end);

                elseif j == 1
                    start_line = indices(j);
                    end_line = indices(big_gap_ind(j));

                else
                    start_line = indices(big_gap_ind(j-1)+1);
                    end_line = indices(big_gap_ind(j));  
                end

                if (end_line - start_line) >= min_points_v
                    for k = start_line:end_line
                        A(k,i) = 0;
                    end
                end
           end
        end
    end

end

