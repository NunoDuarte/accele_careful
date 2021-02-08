function [Classification, trainClass] = fun_belief_norm(Data, Priors, Mu, Sigma, minVel, epsi)
    %% Belief System for 2 DS
    
    for k = 1:length(Data)
        % pick one trajectory
        testX = Data{k}; 

        % remove nonzeros
        testXn(:,1) = nonzeros(testX(:,2));
        testXn(:,2) = nonzeros(testX(:,3));
        testXn(:,3) = nonzeros(testX(:,4));
        test3{1}(1,:) = testXn(:,1)';
        test3{1}(2,:) = testXn(:,2)';
        test3{1}(3,:) = testXn(:,3)'; 

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

        [~ , ~, dataProcess, index] = preprocess_demos(Emp3Dnorm, 0.02, 0.0001); 

        % flip Data to start at (0,0);
        dataProcess = flip(dataProcess')';
%         %% Center the Data in the Origin
% 
%         testXn = test3{1};
%         testXn = testXn - testXn(:,end);
%         testXn = round(testXn,4);
% 
%         %% do the norm of all dimensions
% 
%         for n = 1:length(testXn)   
%             testXnnorm(n) = norm(testXn(:,n));    
%         end
%         testXnnorm = round(testXnnorm,3);
% 
%         %% Real Velocity of testX
% 
%         dt = 0.02; % frequency 
%         for i=2:length(testXn(1,:))
%             testX_d(1,i-1) = (testXnnorm(1,i) - testXnnorm(1,i-1))/dt;
%         end
        %% Load Eigen Vectors

        [Ve,De] = eig(Sigma{1});
        Ee1=Ve(:,1); 
        Ee2=Ve(:,2);
        Ed = sqrt(diag(De));

        [Vf,Df] = eig(Sigma{2});
        Fe1=Vf(:,1); 
        Fe2=Vf(:,2);
        Fd = sqrt(diag(Df));

        e2{1} = Ve(:,2);
        e2{2} = Vf(:,2);
        %% Run each DS to get the desired velocity?
        opt_sim.dt = 0.02;
        opt_sim.i_max = 1;
        opt_sim.tol = 0.001;
        opt_sim.plot = 0;

        b1 = 0.5;
        b2 = 0.5;
        b = [b1, b2];
        b1_d = 0;
        b2_d = 0;
        b_d = [b1_d, b2_d];
        epsilon = epsi; % adaptation rate

        d = 1; %dimension of data
        xT = 0;
        Xd = zeros(length(dataProcess),2);

        B = [];
        B = [B; b];
        Er = [];

        K = 0; % out many values to average
        for j = 1:length(dataProcess)-K-1   
            ee = [0 0];
            if abs(dataProcess(2,j)) > minVel
                for i = 1:2

                    outD(j) = abs((dataProcess(2,j+1)-dataProcess(2,j))/(dataProcess(1,j+1)-dataProcess(1,j)));

                    % rate of change for careful/not careful
                    xd = abs((e2{i}(2)/e2{i}(1)));

                    % error (real velocity - desired velocity)
                    ed = -1*abs(outD(j) - xd(:,1));
                    ee(i) = ed;   

                    %Xd(j,i) = xd(:,1)';
                    %Xd = [Xd, xd(:,1)'];
                    b_d(i) = epsilon * (ed' + (b(i) - 0.5)*norm(xd(:,1), 2)); 

                end
                Er = [Er;ee];

                B_d = winnertakeall(b, b_d);
                for i = 1:2
                    b(i) = b(i) + B_d(i)*0.1;
                    b(i) = max(0., min(1., b(i)));
                end
                b(2) = 1. - b(1);
                B = [B; b];   
            end
        end

        % save to variable
        trainClass(:,k) = b';
        
        % clear variables
        clear testXn
        clear test3
        
    end

    clc
    sumtrainClass = sum(trainClass,2);
    Classification = [sumtrainClass(1)/length(Data); sumtrainClass(2)/length(Data)];
    
end
