%% Start

close all ; clear ; clc ; % Clear Everything

%% Initial Patameters

Etha = 0.001 ; % Learning Rate

%% Inputs

N = 2 ; % all possible choose of inputs

I = [ 0 1 0
      0 1 0
      0 1 0 ] ; % I input

I_Num = 0 ; % Corresponding Output for input I

L = [ 1 0 0
      1 0 0
      1 1 1 ] ; % L input

L_Num = 1 ; % Corresponding Output for input L

[R , C] = size(I) ; % Size of Inputs

%% Initial Weights Generation

W = 0.001*2*(rand( R*C + 1 , 1 )-0.5) ; % Random weights Vector(10*1) 

%% Learning Program

Accuracy_On_Train_Data = Accuracy_Fcn(W) ; % Accuracy on Random Weights

while Accuracy_On_Train_Data ~= 100 % Because the Activation Function is Hard, there is No need
                      % to define epochs and can make an auto-repeater
                      % until Zero Error
                      
    for i = 0 : N-1 % Two kinds of Inputs
        
        switch i
            case I_Num % I input
                X = [reshape(I',1,R*C) , 1] ; % Reshape Train Date into Vector(1*10)
            case L_Num % L input
                X = [reshape(L',1,R*C) , 1] ; % Reshape Train Date into Vector(1*10)
        end
        
        Y = X * W ; % Calculate the Output
    
        if Y >= 0 % Passing through Activation Function
           Y = 1 ;
        else
           Y = 0 ;
        end

        D = i ; % Desired Output
        E = D - Y ; % Error Calculation
        W = W + ( Etha .* X' * E ) ; % Weights Correction
        
    end
    
    Accuracy_On_Train_Data = Accuracy_Fcn(W) ; % Accuracy Calculation
    
end

%% Test on Noisy Data with One noisy input

Correct = 0 ;
Wrong = 0 ;

for i = 1 : 1000 % Test on 2*1000 Noisy Data
    
    % Make Noise For I

    random_index = randi([1,9],1,1) ; % Random Position to change
    X = [reshape(I',1,R*C) , 1] ; % Reshape Noisy Date into Vector(1*10)
    X(1,random_index) = not(X(1,random_index)) ; % Change a position into its not

    Y = X * W ; % Calculate the Output
    if Y >= 0   % Passing through Activation Function
       Y = 1 ;
    else
       Y = 0 ;
    end

    if Y == 0 % Decide if it is True or Wrong
       Correct = Correct + 1 ;
    else
       Wrong   = Wrong   + 1 ;
    end

    % Make Noise For L

    random_index = randi([1,9],1,1) ; % Random Position to change
    X = [reshape(L',1,R*C) , 1] ; % Reshape Noisy Date into Vector(1*10)
    X(1,random_index) = not(X(1,random_index)) ; % Change a position into its not

    Y = X * W ; % Calculate the Output
    if Y >= 0   % Passing through Activation Function
       Y = 1 ;
    else
       Y = 0 ;
    end

    if Y == 1 % Decide if it is True or not
       Correct = Correct + 1 ;
    else
       Wrong   = Wrong   + 1 ;
    end

end

Accuracy_on_Noisy_data = 100*(Correct)/(Correct + Wrong) ; % Accuracy on Noisy Data

%% Finish

clear C Correct D E Etha i I I_Num L L_Num N R random_index Wrong X Y   
