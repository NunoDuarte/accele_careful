function [Data] = data_norm_preprocessing(testX, samp_freq)
                    clear testXn;
                    clear test3;

                    %% preprocess data
                    testXn = testX(any(testX,2),2:4);          % remove only full rows of 0s
                    testXn = testXn(all(~isnan(testXn),2),:);  % remove rows of NANs  
                    test3{1}(1,:) = testXn(:,1)';
                    test3{1}(2,:) = testXn(:,2)';
                    test3{1}(3,:) = testXn(:,3)'; 

                    %% Center the Data in the Origin

                    for i=1:length(test3)
                        xT = test3{i}(:,end);
                        Norm1 = [];
                        for j=1:length(test3{i})
                            dis = xT - test3{i}(:,j);
                            disN = norm(dis,2);
                            Norm1 = [Norm1; disN];

                            % normalized over distance
                            Norm2 = Norm1/max(Norm1);

                            % flip data to have the acceleration phase at the end
                            Norm2 = flip(Norm2);
                            Emp3Dnorm{i} = Norm2';
                        end
                    end

                    [~ , ~, Data, index] = preprocess_demos(Emp3Dnorm, samp_freq, 0.0001);

                    % flip Data to start at (0,0); 
                    Data = flip(Data')';
                    
end