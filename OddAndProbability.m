function output = OddAndProbability(input,operation)
if operation == 1 %prob to odds
    output = input./(1.-input);
else %odds to prob
    output = input./(1.+input);
end
end