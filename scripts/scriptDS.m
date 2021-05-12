function scriptDS(Etrain, Ftrain, train, test, Etest, Ftest, K, minVel, epsilon, plots, freq)

    %% Remove Non-Zeros - Empty
    ploty = [];
    plotx = [];
    plotz = [];
    for i=1:length(Etrain)

        En{i}(:,1) = nonzeros(Etrain{i}(:,2));
        En{i}(:,2) = nonzeros(Etrain{i}(:,3));
        En{i}(:,3) = nonzeros(Etrain{i}(:,4));
        E3{i}(1,:) = En{i}(:,1)';
        E3{i}(2,:) = En{i}(:,2)';
        E3{i}(3,:) = En{i}(:,3)';         
        plotx = [plotx, E3{i}(1,:)];
        ploty = [ploty, E3{i}(2,:)];
        plotz = [plotz, E3{i}(3,:)];
        E3{i} = round(E3{i},4);
    end
    % figure()
    % plot3(ploty, plotx, plotz, '.');


    %%
    plotting = 0;    % do you want to plot the 3D versions?
    [Emp3D, Emp2Do, Emp2D] = processData(E3, plotting);

    %% CHECK THE PARAMETERS 
    default = 0;    % No default
    samp_freq_train = freq.train;
    
    %% Generate a DS for Empty Cups
    for i=1:length(E3)
        xT = E3{i}(:,end);
        Norm1 = [];
        for j=1:length(E3{i})
            dis = xT - E3{i}(:,j);
            disN = norm(dis,2);
            Norm1 = [Norm1; disN];

            % normalized over distance
            Norm2 = Norm1/max(Norm1);

            % flip data to have the acceleration phase at the end
            Norm2 = flip(Norm2);
            Emp3Dnorm{i} = Norm2';
        end
    end

    K = genDS(Emp3Dnorm, default, [], K, [], samp_freq_train, 'E');
    
    %% Remove Non Zeros
    ploty = [];
    plotx = [];
    plotz = [];
    for i=1:length(Ftrain)
        Fn{i}(:,1) = nonzeros(Ftrain{i}(:,2));
        Fn{i}(:,2) = nonzeros(Ftrain{i}(:,3));
        Fn{i}(:,3) = nonzeros(Ftrain{i}(:,4));
        F3{i}(1,:) = Fn{i}(:,1)';
        F3{i}(2,:) = Fn{i}(:,2)';
        F3{i}(3,:) = Fn{i}(:,3)'; 

        F3{i} = round(F3{i},4);

        plotx = [plotx, F3{i}(1,:)];
        ploty = [ploty, F3{i}(2,:)];
        plotz = [plotz, F3{i}(3,:)];
    end
    % figure()
    % plot3(ploty, plotx, plotz, '.');


    %% 
    [Full3D, Full2Do, Full2D] = processData(F3, plotting);

    %% Generate a DS for Full Cups   

    for i=1:length(F3)
        xT = F3{i}(:,end);
        Norm1 = [];
        for j=1:length(F3{i})
            dis = xT - F3{i}(:,j);
            disN = norm(dis);
            Norm1 = [Norm1; disN];

            % normalized over distance
            Norm2 = Norm1/max(Norm1);

            % flip data to have the acceleration phase at the end
            Norm2 = flip(Norm2);
            Full3Dnorm{i} = Norm2';
        end
    end
    genDS(Full3Dnorm, default, [], K, [], samp_freq_train, 'F');

    %% save figures

    if plots
        f1 = figure(1);
        filename = ['/output/train/E-e1e2-K' num2str(K) '-' datestr(now,'mm-dd-yyyy-HH-MM-SS')];
        saveas(f1, [pwd, filename]);

        f2 = figure(2);
        filename = ['/output/train/F-e1e2-K' num2str(K) '-' datestr(now,'mm-dd-yyyy-HH-MM-SS')];
        saveas(f2, [pwd, filename]);
    end

    %% labels to know which object

    % EPFL + QMUL
    Train = [];
    for i = 1:length(train)
        Train = [Train; train{i}];
    end
    Train = [Train; {' ', ' '}];

    Test = [];
    for i = 1:length(test)
        Test = [Test; test{i}];
    end
    Test = [Test; {' ', ' '}];


    %% Classification

    [trainTruePos, trainFalsePos, trainTrueNeg, trainFalseNeg, ....
        testTruePos, testFalsePos, testTrueNeg, testFalseNeg, ....
        F1_train, F1_test] = ....
        scriptBelief(Etrain, Ftrain, Etest, Ftest, freq, minVel, epsilon);
    
    % Add if statement to filter results
    %if ((trainTruePos >= 0.5 && trainTrueNeg >= 0.7) && (testTruePos >= 0.5 && testTrueNeg >= 0.7))
    if (testTruePos >= 0.50 && testTrueNeg >= 0.70)

        ConfTrain = {'Confusion Matrix', 'Train'; trainTruePos, trainFalsePos; trainFalseNeg, trainTrueNeg};
        ConfTest = {'Confusion Matrix', 'Test'; testTruePos, testFalsePos; testFalseNeg, testTrueNeg};
        F0 = {'Epsilon ',  ' ' ; epsilon, []};
        F1 = {'F1 measure Train', 'F1 measure Test'; F1_train, F1_test};

        t = table([Train; Test; ConfTrain; ConfTest; F0; F1], 'VariableNames', {'Train_Test_dataset'});
        filename = ['output/train/dataset-K' num2str(K) '-minVel' num2str(minVel) '-epsi' num2str(epsilon) '-' datestr(now,'mm-dd-yyyy-HH-MM-SS')];
        writetable(t, [filename '.txt']);
    end

    %% 
end
