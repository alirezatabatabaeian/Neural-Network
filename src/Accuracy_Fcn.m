function [Accuracy] = Accuracy_Fcn(W)
%% Inputs

Correct = 0 ;
Wrong   = 0 ;

N = 2 ; % all possible kinds of input model

I = [ 0 1 0
      0 1 0
      0 1 0 ] ; % I input

I_Num = 0 ; % Corresponding Output for input I

L = [ 1 0 0
      1 0 0
      1 1 1 ] ; % L input
  
L_Num = 1 ; % Corresponding Output for input L

[R , C] = size(I) ; % Size of Inputs

%% Testing Program

for i = 0 : N-1 % Test on two choose for inputs
    
    switch i
        case I_Num
            X = [reshape(I',1,R*C) , 1] ; % % Reshape Train Date into Vector(1*10)
        case L_Num
            X = [reshape(L',1,R*C) , 1] ; % % Reshape Train Date into Vector(1*10)
    end
    
    Y = X * W ; % Calculate the Output
    
    if Y >= 0 % Passing through Activation Function
       Y = 1 ;
    else
       Y = 0 ;
    end
    
    if Y == i % Decide if it is True or not
        Correct = Correct + 1 ;
    else
        Wrong   = Wrong   + 1 ;
    end
    
end

Accuracy = 100*(Correct)/(Correct + Wrong) ; % Accuracy on Test Data

end

