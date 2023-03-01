% plot B data
clear V;
% pick the data
data = {'all_BEgan'; 'all_BEneu'}; 

% do you want to plot only the true positive cases?
true_positives = 1;
% do you want to plot the careful (1) or not careful (0)
careful = 0;

%% read all the files and plot it
size_of_traj = [];
reaction_time = [];
for k=1:2
    V = eval(string(data(k)));
    for n=1:size(V,1)
        for m=1:size(V,2)
            if ~isempty(V{n,m})
                if true_positives
                    if any(V{n,m} == careful)
                        hold on;
                        size_of_traj = [size_of_traj, length(V{n,m})];
                        plot(V{n,m}, 'b-.');
                        segment = V{n,m};
                        reaction_time = [reaction_time; segment(1:198)'];
                    end
                else
                    hold on;
                    size_of_traj = [size_of_traj, length(V{n,m})];
                    plot(V{n,m}, 'b-.');
                    segment = V{n,m};
                    reaction_time = [reaction_time; segment(1:198)'];
                end
            end
        end
    end
end

%% get min, avg, and max duration of handover
[Min, ~] = min(size_of_traj);
Avg = mean(size_of_traj);
[Max, ~] = max(size_of_traj);

%% plot the mean and std of classifications
size_reaction_time = size(reaction_time);
% 103 you can assume it is a normal distribution [0, 1]
Avg_reaction_time = mean(reaction_time);

% 84% confidence interval
% confidence interval for binomial distribution
std_reaction_time = sqrt((Avg_reaction_time.*(1-Avg_reaction_time))/size_reaction_time(1));

curve1 = Avg_reaction_time + std_reaction_time;
curve2 = Avg_reaction_time - std_reaction_time;

x = 1:numel(reaction_time(1,:));
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g','FaceAlpha',0.5);
hold on;
plot(x, Avg_reaction_time, 'r', 'LineWidth', 2);

xlim([0, 250]);

%% count the number of 1s in array

complete_classf = reaction_time;
complete_classf(complete_classf~=1)= 0;

complete_classf_inv = reaction_time;
complete_classf_inv(complete_classf_inv > 0) = -1;
complete_classf_inv(complete_classf_inv == 0) = 1;
complete_classf_inv(complete_classf_inv==-1) = 0;

complete_classf_all = sum(complete_classf)/size_reaction_time(1) + sum(complete_classf_inv)/size_reaction_time(1);


