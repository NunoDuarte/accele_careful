function [E, F] = read(name, object)
    % reading data of Salman
    if strcmp(name,'Salman')
        if strcmp(object,'red-mug')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{1}(1:50,:) = 0; 
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{2}(1:110,:) = 0; 
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{4}(1:250,:) = 0; 
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            E{5}(1:280,:) = 0; 
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:270,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{2}(1:285,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{3}(1:70,:) = 0;   
            F{4} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{4}(1:400,:) = 0;   
            F{5} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);
            F{5}(1:300,:) = 0;   
        end
        
    % reading data of David
    elseif strcmp(name,'David')
        if strcmp(object,'plastic-cup')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{1}(1:30,:) = 0; 
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{2}(1:10,:) = 0; 
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{3}(1:300,:) = 0; 
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{4}(150:end,:) = 0; 
            %%E{5} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            E{5}(1:100,:) = 0; 
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:80,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{3} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{3}(1:50,:) = 0;   
            F{4} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{4}(1:100,:) = 0;   
            F{5} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);
            F{6} = csvread(['data/zApproach/' name '/' object '/full/5_right.csv']);
            F{6}(1:100,:) = 0;   
            
        elseif strcmp(object, 'red-cup')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{1}(200:end,:) = 0; 
            E{1}(1:120,:) = 0; 
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{2}(1:250,:) = 0;             
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{3}(1:300,:) = 0;             
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{4}(1:100,:) = 0; 
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:80,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{2}(1:50,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            
        elseif strcmp(object, 'big-plastic-cup')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{1}(200:end,:) = 0;                         
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{2}(1:10,:) = 0;                         
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{3}(200:end,:) = 0;                         
            E{3}(1:50,:) = 0;                         
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{4}(1:10,:) = 0;                         
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{5}(1:170,:) = 0;                         
            E{5}(300:end,:) = 0;                         
            E{6} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:115,:) = 0;   
            F{1}(250:end,:) = 0;                         
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{2}(1:200,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{4} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);  
            F{5} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);  
            
        end
    % reading data of Kunpeng
    elseif strcmp(name,'Kunpeng')
        if strcmp(object,'plastic-cup')

            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{1}(200:end,:) = 0;                         
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{2}(200:end,:) = 0;                         
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{5}(200:end,:) = 0;                         
            E{6} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            E{6}(100:end,:) = 0;        
            
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:400,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/5_right.csv']);  
            F{2}(1:100,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/6_right.csv']);  
            
        elseif strcmp(object, 'red-cup')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{1}(1:100,:) = 0;                         
            E{1}(200:end,:) = 0;                         
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{2}(1:50,:) = 0;                         
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{4}(1:400,:) = 0;                         
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            E{5}(1:10,:) = 0;                         
            E{6} = csvread(['data/zApproach/' name '/' object '/empty/6_right.csv']);

            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{1}(1:150,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{2}(1:150,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{3}(1:150,:) = 0;   
            F{4} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);
            F{4}(1:150,:) = 0;   

        elseif strcmp(object,'wine-glass')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{2}(1:50,:) = 0;                         
            %E{3}(200:end,:) = 0;                         
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{3}(200:end,:) = 0;                         
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{4}(200:end,:) = 0;                         
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{6} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            E{7} = csvread(['data/zApproach/' name '/' object '/empty/6_right.csv']);
            E{7}(1:100,:) = 0;                         
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:10,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{3} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{3}(1:60,:) = 0;   
            F{4} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);
            F{4}(1:120,:) = 0;   
            F{5} = csvread(['data/zApproach/' name '/' object '/full/5_right.csv']);
        end    
        
    % reading data of Leo
    elseif strcmp(name,'Leo')        
        if strcmp(object,'plastic-cup')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:350,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{2}(1:100,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{3}(1:100,:) = 0;   
            F{4} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);

        elseif strcmp(object, 'red-cup')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{4}(1:230,:) = 0;                         
            %
            F{1} = csvread(['data/zApproach/' name '/red-cup' '/full/0_right.csv']);
            F{1}(300:end,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{2}(1:50,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{3}(1:70,:) = 0;   
            F{4} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);

        elseif strcmp(object, 'red-mug')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{1}(1:200,:) = 0;                         
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{2}(1:100,:) = 0;                         
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            %%E{5} = csvread(['data/zApproach/' name '/red-mug' '/empty/4_right.csv']);
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            E{6} = csvread(['data/zApproach/' name '/' object '/empty/6_right.csv']);            
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/half/1_right.csv']);
            F{2} = csvread(['data/zApproach/' name '/' object '/half/2_right.csv']);
            F{2}(1:50,:) = 0;   
            %%F{4} = csvread(['data/zApproach/' name '/red-mug' '/half/3_right.csv']);
            F{3} = csvread(['data/zApproach/' name '/' object '/half/4_right.csv']);
            F{4} = csvread(['data/zApproach/' name '/' object '/half/5_right.csv']);
            F{4}(1:50,:) = 0;   
        
        elseif strcmp(object, 'champagne')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            %E{4} = csvread(['data/zApproach/' name '/champagne' '/empty/3_right.csv']);
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:250,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{3} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{3}(1:200,:) = 0;   
            F{4} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{5} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);
            F{6} = csvread(['data/zApproach/' name '/' object '/full/5_right.csv']);      
            
        elseif strcmp(object, 'wine-glass')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{3}(1:50,:) = 0;                         
            E{4} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{5} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            E{5}(1:50,:) = 0;                         
            E{6} = csvread(['data/zApproach/' name '/' object '/empty/5_right.csv']);
            E{6}(1:200,:) = 0;                         
            E{7} = csvread(['data/zApproach/' name '/' object '/empty/6_right.csv']);
            E{7}(1:50,:) = 0;                         
            %
            %F{1} = csvread(['data/zApproach/' name '/wine-glass' '/full/0_right.csv']);
            F{1} = csvread(['data/zApproach/' name '/' object '/full/2_right.csv']);
            F{2} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{2}(1:50,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);
            F{3}(1:150,:) = 0;   
           
        end
           
    % reading data of Athanasios
    elseif strcmp(name,'Athanasios')
         if strcmp(object, 'champagne')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/1_right.csv']);
            E{1}(1:60,:) = 0;                         
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/2_right.csv']);
            E{2}(1:100,:) = 0;                         
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:350,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);
            F{2}(1:50,:) = 0;   
            F{3} = csvread(['data/zApproach/' name '/' object '/full/3_right.csv']);
            F{4} = csvread(['data/zApproach/' name '/' object '/full/4_right.csv']);
            
         elseif strcmp(object, 'red-cup')
            E{1} = csvread(['data/zApproach/' name '/' object '/empty/0_right.csv']);
            E{2} = csvread(['data/zApproach/' name '/' object '/empty/3_right.csv']);
            E{3} = csvread(['data/zApproach/' name '/' object '/empty/4_right.csv']);                       
            E{3}(200:end,:) = 0;                         
            %
            F{1} = csvread(['data/zApproach/' name '/' object '/full/0_right.csv']);
            F{1}(1:100,:) = 0;   
            F{2} = csvread(['data/zApproach/' name '/' object '/full/1_right.csv']);   
            
         end

    elseif strcmp(name,'All')
            E{1} = csvread(['data/' 'Leo' '/' 'red-cup' '/empty/1_right.csv']);             
            E{1}(750:end,:) = 0;       
            E{2} = csvread(['data/' 'Bernardo' '/' 'bowl' '/empty/0_right.csv']);
            E{3} = csvread(['data/' 'Bernardo' '/' 'bowl' '/empty/1_right.csv']);
            E{3}(750:end,:) = 0;            
            E{4} = csvread(['data/' 'Bernardo' '/' 'bowl' '/full/1_right.csv']);
            E{5} = csvread(['data/' 'Bernardo' '/' 'bowl' '/full/2_right.csv']);     
            E{6} = csvread(['data/' 'Bernardo' '/' 'bowl' '/empty/2_right.csv']);
            E{7} = csvread(['data/' 'Bernardo' '/' 'bowl' '/full/0_right.csv']);
            E{7}(1000:end,:) = 0;
            E{8} = csvread(['data/' 'Bernardo' '/' 'bowl' '/full/3_right.csv']);

            %
            F{1} = csvread(['data/' 'Leo' '/' 'red-cup' '/full/2_right.csv']);
            F{2} = csvread(['data/' 'Salman' '/' 'red-mug' '/full/0_right.csv']);
            F{3} = csvread(['data/' 'Salman' '/' 'red-mug' '/full/1_right.csv']);
            F{4} = csvread(['data/' 'Salman' '/' 'red-mug' '/full/2_right.csv']);
            F{5} = csvread(['data/' 'Salman' '/' 'red-mug' '/full/3_right.csv']);
            F{6} = csvread(['data/' 'Salman' '/' 'red-mug' '/empty/0_right.csv']);
            F{7} = csvread(['data/' 'Salman' '/' 'red-mug' '/empty/1_right.csv']);
            F{8} = csvread(['data/' 'Salman' '/' 'red-mug' '/empty/3_right.csv']);
            F{9} = csvread(['data/' 'Leo' '/' 'red-cup' '/full/1_right.csv']);
            F{9}(1300:end,:) = 0;
            F{10} = csvread(['data/' 'Leo' '/' 'red-cup' '/full/3_right.csv']);
            F{10}(2500:end,:) = 0;   
            
    elseif strcmp(name,'All-left')
            E{1} = csvread(['data/' 'Kunpeng' '/' 'red-cup' '/empty/0_right.csv']);
            E{1}(35:end,:) = 0;
            
            F{1} = csvread(['data/' 'Salman' '/' 'red-mug' '/empty/1_right.csv']);
            F{2} = csvread(['data/' 'Salman' '/' 'red-mug' '/empty/3_right.csv']);
    else
        error('Name not Recognized!');
    end
    
end