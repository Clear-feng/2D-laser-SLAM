
function [Xstate] = FuncUpdate(Xstate,Delta)
Xstate = Xstate + Delta;
Xstate = [Xstate(1); Xstate(2); wrapToPi(Xstate(3))];
