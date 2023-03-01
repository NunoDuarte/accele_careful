% plot B data
clear E;
E = all_BFgan;

size_of_traj = [];
reaction_time = [];

len = size(E);
for n=1:len(1)
    for m=1:len(2)
        if length(E{n,m}) ~= 0
%             if any(E{n,m} == 1)
                hold on;
                size_of_traj = [size_of_traj, length(E{n,m})];
                plot(E{n,m}, 'b-.');
                segment = E{n,m};
                reaction_time = [reaction_time; segment(1:198)'];
%             end
        end
    end
    
end

E = all_BFneu;
len = size(E);
for n=1:len(1)
    for m=1:len(2)
        if length(E{n,m}) ~= 0
%             if any(E{n,m} == 1)
                hold on;
                size_of_traj = [size_of_traj, length(E{n,m})];
                plot(E{n,m}, 'b-.');
                segment = E{n,m};
                reaction_time = [reaction_time; segment(1:198)'];    
%             end
        end
    end
    
end

[Min, ind] = min(size_of_traj)
Avg = mean(size_of_traj)
[Max, ind] = max(size_of_traj)

Avg_reaction_time = mean(reaction_time);
std_reaction_time = std(reaction_time);

x = 1:numel(reaction_time(1,:));

% 103 you can assume it is a normal distribution [0, 1]
% 84% confidence interval

std_reaction_time = sqrt((Avg_reaction_time.*(1-Avg_reaction_time))/size_reaction_time(1));

size_reaction_time = size(reaction_time);
curve1 = Avg_reaction_time + sqrt((Avg_reaction_time.*(1-Avg_reaction_time))/size_reaction_time(1));
curve2 = Avg_reaction_time - sqrt((Avg_reaction_time.*(1-Avg_reaction_time))/size_reaction_time(1));
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
% complete_classf_inv(complete_classf==-1) = 0;

complete_classf_all = sum(complete_classf)/size_reaction_time(1) + sum(complete_classf_inv)/size_reaction_time(1);


