function saveTablesExec( datasets, datasetsname, training_splits, ...
    splits, perfPath, classifPath, featsPath, ...
    descriptors_sets, descriptors_sets_names, prepro, featselector, selection, graylevel, ...
    classifier, postpro, aug )

    headings =  ['\\documentclass[12pt,italian]{article}\n',...
        '\\usepackage{graphicx}\n',...
        '\\usepackage{longtable}\n',...
        '\\parskip 0.1in\n',...
        '\\oddsidemargin -1in\n',...
        '\\evensidemargin -1in\n',...
        '\\topmargin -0.5in\n',...
        '\\textwidth 6.8in\n',...
        '\\textheight 9.9in\n',...
        '\\usepackage{fancyhdr}\n',...
        '\\usepackage{booktabs}\n',...
        '\\usepackage{multirow}\n',...
        '\\usepackage{amsmath}\n',...
        '\\begin{document}\n',...
        '\\begin{tiny}\n'];
    
    closing = '\\end{tiny} \n \\end{document}';
    %Collect and write results
    for dt = 1:numel(datasets)
        %Write results in a LaTeX table
        
        for sp = 1:numel(splits{dt})
            
            if strcmp(datasetsname{dt}, 'CNMC')
                string_split = '';
            elseif strcmp(training_splits{dt}{1}, '') 
                string_split = '';
            else
                string_split = strcat( splits{dt}{sp}, '___' );
            end
            
            destinationPerf = fullfile(perfPath,...
                strcat('Performance___',...
                datasetsname{dt}, '___',...
                string_split, '.tex'));
            
            pFile = fopen(destinationPerf, 'w');
            fprintf(pFile, headings);
            for fs = 1:numel(featselector)
                for sel = 1:numel(selection)
                    if selection(sel)<100 && size(DBTrain,2) > 10
                        selected = featureSelection(featselector{fs}, DBTrain, labels, selection(sel));
                        string_selection = [featselector{fs} '___' num2str(selection(sel)) '___'];
                    else
                        selected = [];
                        string_selection = '';
                    end
                    for gl = 1:numel(graylevel)
                        for pp = 1:numel(prepro)
                            for pop = 1:numel(postpro)
                                %Write table
                                fprintf(pFile, '\\begin{longtable}{ll');
                                %fprintf(pFile, '\\begin{tabular}{l');
                                n_metrics = 7;
                                for cla = 1:(numel(classifier)*n_metrics)
                                    fprintf(pFile, 'c');
                                end
                                fprintf(pFile, '}\n');
                                fprintf(pFile, '\\toprule\n');
                                %Heading
                                fprintf(pFile, '\\multicolumn{%d}{c}{Dataset=%s selection=%s\\%% prepro= %s postpro= %s, gl= %s} \\\\ \n', 2+numel(classifier)*n_metrics, datasetsname{dt}, string_selection, prepro{pp}, postpro{pop}, num2str(graylevel(gl)));
                                fprintf(pFile, '\\toprule\n');
                                fprintf(pFile, 'Descriptor & Size & \\multicolumn{%d}{c}{Classifier} \\\\ \n', numel(classifier)*n_metrics);
                                fprintf(pFile, '& ');
                                for cla = 1:numel(classifier)
                                    fprintf(pFile, ['& \\multicolumn{', num2str(n_metrics),'}{c}{%s} '], classifier{cla});
                                end
                                fprintf(pFile, '\\\\ \n');
                                fprintf(pFile, '& ');
                                for ni = 1:numel(classifier)
                                    fprintf(pFile, '& A & P & R & S & F1 & M & BA');
                                end
                                fprintf(pFile, '\\\\ \n');
                                fprintf(pFile, '\\midrule\n');
                                
                                %Data
                                sumA = zeros(numel(classifier),1);
                                sumP = zeros(numel(classifier),1);
                                sumR = zeros(numel(classifier),1);
                                sumS = zeros(numel(classifier),1);
                                sumF1 = zeros(numel(classifier),1);
                                sumMCC = zeros(numel(classifier),1);
                                sumBACC = zeros(numel(classifier),1);
                                for dsc_set = 1:numel(descriptors_sets)
                                    if contains( descriptors_sets{dsc_set}, '_' )
                                        desc_write = erase( descriptors_sets_names{dsc_set}, '_' );
                                    else
                                        desc_write = descriptors_sets_names{dsc_set};
                                    end
                                    
                                    descriptorSize = 0;
                                    % combinations handling
                                    if( contains(descriptors_sets{dsc_set}, '-') )
                                        descriptorsList = getUniqueDescriptorsList({descriptors_sets{dsc_set}});
                                    else
                                        descriptorsList = {descriptors_sets{dsc_set}};
                                    end
                                    for dl = 1:numel( descriptorsList )
                                        descriptorFile = fullfile( featsPath,...
                                            strcat(datasetsname{dt}, '___',...
                                            string_split, ... 
                                            descriptorsList{dl}, '___',...
                                            string_selection,...
                                            num2str(graylevel(gl)), '___',...
                                            prepro{pp}, '.mat') );
                                        load(descriptorFile, 'features');
                                        descriptorSize = descriptorSize + size(features,2);
                                    end
                                    
                                    fprintf(pFile, '%s & %d ', desc_write, descriptorSize);
                                    for cla = 1:numel(classifier)
                                        %load retrieval results
                                        destinationResult = fullfile( classifPath,...
                                            strcat(datasetsname{dt}, '___',...
                                            string_split, ... % ___ already inserted for compatibility
                                            descriptors_sets{dsc_set}, '___',...
                                            string_selection,...
                                            num2str(graylevel(gl)), '___',...
                                            prepro{pp}, '___',...
                                            postpro{pop}, '___',...
                                            classifier{cla}, '.mat') );
                                        if exist(destinationResult, 'file') ~= 0
                                            load(destinationResult, 'results');
                                            if( strcmp( aug, 'aug1' ) == 1 ) % cross-validation with augmentation: folds average + stddev
                                                load(destinationResult, 'results_stddev');
                                                fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.ACC), 100*zeroNaN(results_stddev.ACC) );
                                                fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.P), 100*zeroNaN(results_stddev.P) );
                                                fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.R), 100*zeroNaN(results_stddev.R) );
                                                fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.TNR), 100*zeroNaN(results_stddev.TNR) );
                                                fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.F1), 100*zeroNaN(results_stddev.F1) );
                                                fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.MCC), 100*zeroNaN(results_stddev.MCC) );
                                                fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.BACC), 100*zeroNaN(results_stddev.BACC) );
                                                sumA(cla) = sumA(cla)+zeroNaN(results.ACC);
                                                sumP(cla) = sumP(cla)+zeroNaN(results.P);
                                                sumR(cla) = sumR(cla)+zeroNaN(results.R);
                                                sumS(cla) = sumS(cla)+zeroNaN(results.TNR);
                                                sumF1(cla) = sumF1(cla)+zeroNaN(results.F1);
                                                sumMCC(cla) = sumMCC(cla)+zeroNaN(results.MCC);
                                                sumBACC(cla) = sumBACC(cla)+zeroNaN(results.BACC);
                                            else
                                                fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.ACC));
                                                fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.P));
                                                fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.R));
                                                fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.TNR));
                                                fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.F1));
                                                fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.MCC));
                                                fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.BACC));
                                                sumA(cla) = sumA(cla)+zeroNaN(results.ACC);
                                                sumP(cla) = sumP(cla)+zeroNaN(results.P);
                                                sumR(cla) = sumR(cla)+zeroNaN(results.R);
                                                sumS(cla) = sumS(cla)+zeroNaN(results.TNR);
                                                sumF1(cla) = sumF1(cla)+zeroNaN(results.F1);
                                                sumMCC(cla) = sumMCC(cla)+zeroNaN(results.MCC);
                                                sumBACC(cla) = sumBACC(cla)+zeroNaN(results.BACC);
                                            end
                                        end
                                    end
                                    fprintf(pFile, '\\\\ \n');
                                end
                                fprintf(pFile, '\\hline\n');
                                fprintf(pFile, 'AVG & - ');
                                for cla = 1:numel(classifier)
                                    fprintf(pFile, '& %4.1f ', 100*(sumA(cla)/numel(descriptors_sets)));
                                    fprintf(pFile, '& %4.1f ', 100*(sumP(cla)/numel(descriptors_sets)));
                                    fprintf(pFile, '& %4.1f ', 100*(sumR(cla)/numel(descriptors_sets)));
                                    fprintf(pFile, '& %4.1f ', 100*(sumS(cla)/numel(descriptors_sets)));
                                    fprintf(pFile, '& %4.1f ', 100*(sumF1(cla)/numel(descriptors_sets)));
                                end
                                fprintf(pFile, '\\\\ \n');
                                fprintf(pFile, '\\hline\n');
                                fprintf(pFile, '\\bottomrule\n');
                                fprintf(pFile, '\\end{longtable} \n');
                                fprintf(pFile, '\n \\pagebreak \n');
                            end
                        end
                    end
                end
            end

            for au = 1:numel(aug)
                cnnResults = dir( fullfile( classifPath, ...
                    strcat(datasetsname{dt}, '___', string_split,...
                    '*CNN.mat') ) );
                
                %Write table
                fprintf(pFile, '\\begin{longtable}{lccccccc');
                fprintf(pFile, '}\n');
                fprintf(pFile, '\\toprule\n');
                %Heading
                fprintf(pFile, '\\multicolumn{%d}{c}{Dataset=%s CNNs} \\\\ \n', 6, datasetsname{dt});
                fprintf(pFile, '\\toprule\n');
                fprintf(pFile, 'Network & A & P & R & S & F1 & M & BA\\\\ \n');
                fprintf(pFile, '\\midrule\n');
                
                sumAc = 0;
                sumPc = 0;
                sumRc = 0;
                sumSc = 0;
                sumF1c = 0;
                sumMCCc = 0;
                sumBACCc = 0;

                for cn = 1:numel(cnnResults)
                    cnnInfo = strsplit(cnnResults(cn).name, '_');
                    cnnName = cnnInfo{2};
                    cnnEpochs = cnnInfo{3};

                    destinationResult = fullfile( classifPath, cnnResults(cn).name );  
                    
                    fprintf(pFile, '%s-%s', cnnName, cnnEpochs );
                    
                    %load results
                    if exist(destinationResult) ~= 0
                        load(destinationResult, 'results');
                        if( strcmp( aug, 'aug1' ) == 1 ) % cross-validation with augmentation: folds average + stddev
                            load(destinationResult, 'results_stddev');
                            fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.ACC), 100*zeroNaN(results_stddev.ACC) );
                            fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.P), 100*zeroNaN(results_stddev.P) );
                            fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.R), 100*zeroNaN(results_stddev.R) );
                            fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.TNR), 100*zeroNaN(results_stddev.TNR) );
                            fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.F1), 100*zeroNaN(results_stddev.F1) );
                            fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.MCC), 100*zeroNaN(results_stddev.MCC) );
                            fprintf(pFile, '& $ %4.1f \\pm %4.1f $ ', 100*zeroNaN(results.BACC), 100*zeroNaN(results_stddev.BACC) );
                            sumAc = sumAc+zeroNaN(results.ACC);
                            sumPc = sumPc+zeroNaN(results.P);
                            sumRc = sumRc+zeroNaN(results.R);
                            sumSc = sumSc+zeroNaN(results.TNR);
                            sumF1c = sumF1c+zeroNaN(results.F1);
                            sumMCCc = sumF1c+zeroNaN(results.MCC);
                            sumBACCc = sumF1c+zeroNaN(results.BACC);
                        else
                            fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.ACC));
                            fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.P));
                            fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.R));
                            fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.TNR));
                            fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.F1));                            
                            fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.MCC));
                            fprintf(pFile, '& %4.1f ', 100*zeroNaN(results.BACC));
                            sumAc = sumAc+zeroNaN(results.ACC);
                            sumPc = sumPc+zeroNaN(results.P);
                            sumRc = sumRc+zeroNaN(results.R);
                            sumSc = sumSc+zeroNaN(results.TNR);
                            sumF1c = sumF1c+zeroNaN(results.F1);
                            sumMCCc = sumMCCc+zeroNaN(results.MCC);
                            sumBACCc = sumBACCc+zeroNaN(results.BACC);
                        end
                    end
                    fprintf(pFile, '\\\\ \n');
                end
                fprintf(pFile, '\\hline\n');
                fprintf(pFile, 'AVG ');
                fprintf(pFile, '& %4.1f ', 100*(sumAc/numel(cnnResults)));
                fprintf(pFile, '& %4.1f ', 100*(sumPc/numel(cnnResults)));
                fprintf(pFile, '& %4.1f ', 100*(sumRc/numel(cnnResults)));
                fprintf(pFile, '& %4.1f ', 100*(sumSc/numel(cnnResults)));
                fprintf(pFile, '& %4.1f ', 100*(sumF1c/numel(cnnResults)));
                fprintf(pFile, '& %4.1f ', 100*(sumMCCc/numel(cnnResults)));
                fprintf(pFile, '& %4.1f ', 100*(sumBACCc/numel(cnnResults)));
                fprintf(pFile, '\\\\ \n');
                fprintf(pFile, '\\hline\n');
                fprintf(pFile, '\\bottomrule\n');
                fprintf(pFile, '\\end{longtable} \n');
                fprintf(pFile, '\n \\pagebreak \n');
            end

            if pFile ~= -1
                fprintf(pFile, closing);
                fclose(pFile);
            end
        end
    end
end