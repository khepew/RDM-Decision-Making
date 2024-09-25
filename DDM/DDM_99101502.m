%% DDM - Ali KhosraviPour - 99101502
%%

phase1_data = [];
phase2_data = [];
phase3_data = [];

subjects = {'Sub1', 'Sub2'};
blocks = 1:8;

for s = 1:length(subjects)
    for b = blocks

        fileName = strcat(subjects{s}, '_block_', num2str(b), '.mat');
        data = load(fileName);
        result_data = data.data.result(:, [5, 6]);
        
        if b == 1 || b == 2
            phase1_data = [phase1_data; result_data];
        elseif b >= 3 && b <= 6
            phase2_data = [phase2_data; result_data];
        elseif b == 7 || b == 8
            phase3_data = [phase3_data; result_data];
        end
    end
end

% pooled data as .mat
save('Pooled_Phase1_Data.mat', 'phase1_data');
save('Pooled_Phase2_Data.mat', 'phase2_data');
save('Pooled_Phase3_Data.mat', 'phase3_data');

% pooled data as .txt
writematrix(phase1_data, 'Pooled_Ph1.txt', 'Delimiter', ' ');
writematrix(phase2_data, 'Pooled_Ph2.txt', 'Delimiter', ' ');
writematrix(phase3_data, 'Pooled_Ph3.txt', 'Delimiter', ' ');

%% Plotting

Drift_Rates = [0.7307, 0.6149, 0.7363];
Decision_Bounds = [1.0859, 1.1878, 1.1711];
Non_Dec_Times = [0.4091, 0.4084, 0.3839];

% Phases
phases = {'Phase 1', 'Phase 2', 'Phase 3'};

% Plotting the data
figure;

% Drift Rates
subplot(1, 3, 1);
plot(1:3, Drift_Rates, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
title('Drift Rates Across Phases');
set(gca, 'XTick', 1:3, 'XTickLabel', phases);
xlabel('Phases');
ylabel('Drift Rate');
grid on;

% Decision Boundaries
subplot(1, 3, 2);
plot(1:3, Decision_Bounds, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
title('Decision Boundaries Across Phases');
set(gca, 'XTick', 1:3, 'XTickLabel', phases);
xlabel('Phases');
ylabel('Decision Boundary');
grid on;

% Non-Decision Times
subplot(1, 3, 3);
plot(1:3, Non_Dec_Times, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
title('Non-Decision Times Across Phases');
set(gca, 'XTick', 1:3, 'XTickLabel', phases);
xlabel('Phases');
ylabel('Non-Decision Time');
grid on;

% Adjust layout
set(gcf, 'Position', [100, 100, 1200, 400]);  % Adjust the size of the figure








