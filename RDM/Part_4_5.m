%% Ali KhosraviPour - 99101502
%%
clear; close all;

subjects = {'Sub1', 'Sub2'};
num_blocks = 8;
phases = {'Phase 1 (Before Learning)', 'Phase 2 (During Learning)', 'Phase 3 (After Learning)'};


accuracy_data = cell(length(subjects), 1);
rt_data = cell(length(subjects), 1);

%
all_accuracy_sub1 = zeros(1, num_blocks);
all_accuracy_sub2 = zeros(1, num_blocks);

all_rt_sub1 = zeros(length(phases), num_blocks);
all_rt_sub2 = zeros(length(phases), num_blocks);



% Loop through subjects
for s = 1:length(subjects)
    subject = subjects{s};
    
    % Initialize phase data
    accuracy_phases = zeros(3, 1);
    rt_phases = zeros(3, 1);
    
    % Loop through blocks and load data
    for b = 1:num_blocks
        % Load data for current block
        fileName = sprintf('%s_block_%d.mat', subject, b);
        load(fileName, 'data');
        result = data.result;
        accuracy = data.accuracy;
        mean_RT = data.mean_RT;
        
        % Determine phase
        if b <= 2
            % Phase 1 (Before learning)
            phase_idx = 1;
        elseif b >= 7
            % Phase 3 (After learning)
            phase_idx = 3;
        else
            % Phase 2 (During learning)
            phase_idx = 2;
        end
        
        % Accumulate data for the phase
        accuracy_phases(phase_idx) = accuracy_phases(phase_idx) + accuracy;
        rt_phases(phase_idx) = rt_phases(phase_idx) + mean_RT;
        
        %%%
        if s==1 
            all_accuracy_sub1(b) = accuracy;
            all_rt_sub1(b) = mean_RT;
        else
            all_accuracy_sub2(b) = accuracy;
            all_rt_sub2(b) = mean_RT;
        end
    end
    
    % Average across blocks within each phase
    accuracy_phases(1) = accuracy_phases(1) / 2 ;
    accuracy_phases(3) = accuracy_phases(3) / 2 ;
    accuracy_phases(2) = accuracy_phases(2) ;

    rt_phases(1) = rt_phases(1) / 2;
    rt_phases(3) = rt_phases(3) / 2;
    rt_phases(2) = rt_phases(2) / 4;
    

    accuracy_data{s} = accuracy_phases;
    rt_data{s} = rt_phases;
end

% Plotting bar plots
for s = 1:length(subjects)
    % Plot for accuracy
    figure;
    bar(1:3, accuracy_data{s});
    title(sprintf('Accuracy across Phases for %s', subjects{s}));
    xlabel('Phases');
    ylabel('Accuracy');
    set(gca, 'XTickLabel', phases);
    ylim([0, 1]);
    grid on;
    
    % Plot for reaction time
    figure;
    bar(1:3, rt_data{s});
    title(sprintf('Reaction Time across Phases for %s', subjects{s}));
    xlabel('Phases');
    ylabel('Reaction Time (s)');
    set(gca, 'XTickLabel', phases);
    ylim([0, max(cellfun(@max, rt_data)) + 0.5]); % Adjust ylim based on maximum reaction time across all subjects
    grid on;
end

%% TTEST

%%% Sub 1
% ACC
[~, p_acc_phase1_phase2] = ttest2(all_accuracy_sub1(1:2), all_accuracy_sub1(3:6));
[~, p_acc_phase2_phase3] = ttest2(all_accuracy_sub1(3:6), all_accuracy_sub1(7:8));
[~, p_acc_phase1_phase3] = ttest2(all_accuracy_sub1(1:2), all_accuracy_sub1(7:8));

% Perform t-test for reaction time
[~, p_rt_phase1_phase2] = ttest2(all_rt_sub1(1:2), all_rt_sub1(3:6));
[~, p_rt_phase2_phase3] = ttest2(all_rt_sub1(3:6), all_rt_sub1(7:8));
[~, p_rt_phase1_phase3] = ttest2(all_rt_sub1(1:2), all_rt_sub1(7:8));

% Display results
fprintf('T-test for Subject 1: ');
fprintf('\n');
fprintf('Accuracy: Phase 1 vs. Phase 2 p-value = %.4f\n', p_acc_phase1_phase2);
fprintf('Accuracy: Phase 2 vs. Phase 3 p-value = %.4f\n', p_acc_phase2_phase3);
fprintf('Accuracy: Phase 1 vs. Phase 3 p-value = %.4f\n', p_acc_phase1_phase3);
fprintf('Reaction Time: Phase 1 vs. Phase 2 p-value = %.4f\n', p_rt_phase1_phase2);
fprintf('Reaction Time: Phase 2 vs. Phase 3 p-value = %.4f\n', p_rt_phase2_phase3);
fprintf('Reaction Time: Phase 1 vs. Phase 3 p-value = %.4f\n', p_rt_phase1_phase3);
fprintf('\n');

%%%% Sub 2
% ACC
[~, p_acc_phase1_phase2] = ttest2(all_accuracy_sub2(1:2), all_accuracy_sub2(3:6));
[~, p_acc_phase2_phase3] = ttest2(all_accuracy_sub2(3:6), all_accuracy_sub2(7:8));
[~, p_acc_phase1_phase3] = ttest2(all_accuracy_sub2(1:2), all_accuracy_sub2(7:8));

% Perform t-test for reaction time
[~, p_rt_phase1_phase2] = ttest2(all_rt_sub2(1:2), all_rt_sub2(3:6));
[~, p_rt_phase2_phase3] = ttest2(all_rt_sub2(3:6), all_rt_sub2(7:8));
[~, p_rt_phase1_phase3] = ttest2(all_rt_sub2(1:2), all_rt_sub2(7:8));

% Display results
fprintf('\n');
fprintf('T-test for Subject 2: ');
fprintf('\n');
fprintf('Accuracy: Phase 1 vs. Phase 2 p-value = %.4f\n', p_acc_phase1_phase2);
fprintf('Accuracy: Phase 2 vs. Phase 3 p-value = %.4f\n', p_acc_phase2_phase3);
fprintf('Accuracy: Phase 1 vs. Phase 3 p-value = %.4f\n', p_acc_phase1_phase3);
fprintf('Reaction Time: Phase 1 vs. Phase 2 p-value = %.4f\n', p_rt_phase1_phase2);
fprintf('Reaction Time: Phase 2 vs. Phase 3 p-value = %.4f\n', p_rt_phase2_phase3);
fprintf('Reaction Time: Phase 1 vs. Phase 3 p-value = %.4f\n', p_rt_phase1_phase3);
fprintf('\n');

