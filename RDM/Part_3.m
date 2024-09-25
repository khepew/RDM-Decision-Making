%% Ali KhosraviPour - 99101502
%%
subjects = {'Sub1', 'Sub2'};  
num_blocks = 8;
coherence_levels = [0.032, 0.064, 0.128, 0.256];
num_coherence_levels = length(coherence_levels);

for s = 1:length(subjects)
    subject = subjects{s};
    accuracy_data = zeros(num_blocks, num_coherence_levels);
    reaction_time_data = zeros(num_blocks, num_coherence_levels);
    
    for b = 1:num_blocks
        fileName = sprintf('%s_block_%d.mat', subject, b);
        load(fileName, 'data');
        result = data.result;
        
        % Looping over each coherence level
        for c = 1:num_coherence_levels
            coherence = coherence_levels(c);
            coherence_index = (result(:, 2) == coherence & result(:, 7) == 1);  % Completed trials only

            % Accuracy and RT for each coherence level
            accuracy = sum(result(coherence_index, 5)) / sum(coherence_index);
            mean_RT = mean(result(coherence_index, 6));
            accuracy_data(b, c) = accuracy;
            reaction_time_data(b, c) = mean_RT;
        end
    end
    
    % Compute the average accuracy and reaction time across blocks for each coherence level
    avg_accuracy = mean(accuracy_data, 1);
    avg_reaction_time = mean(reaction_time_data, 1);
    
    % accuracy vs. coherence
    figure;
    plot(coherence_levels, avg_accuracy, '-o');
    title(sprintf('Accuracy vs. Coherence for %s', subject));
    ylim([0, 1]);  
    xticks(coherence_levels);
    xticklabels(coherence_levels);
    grid on;
    
    % Fitting Weibull
    weibull_acc = fit(coherence_levels', avg_accuracy', 'weibull');
    hold on;
    plot(weibull_acc, coherence_levels, avg_accuracy);
    xlabel('Coherence Level');
    ylabel('Accuracy');
    hold off;

    % rt vs. coherence
    figure;
    plot(coherence_levels, avg_reaction_time, '-o');
    title(sprintf('Reaction Time vs. Coherence for %s', subject));

    xticks(coherence_levels);
    xticklabels(coherence_levels);
    grid on;
    
    % Fitting Weibull
    weibull_rt = fit(coherence_levels', avg_reaction_time', 'weibull');
    hold on;
    plot(weibull_rt, coherence_levels, avg_reaction_time);
    xlabel('Coherence Level');
    ylabel('Reaction Time (s)');
    hold off;
end
