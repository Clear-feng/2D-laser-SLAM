
function [Delta,Sum_Delta] = FuncDelta(Jacobian,Error,CovMatrixInv)

Info = Jacobian'*CovMatrixInv*Jacobian;
E = -Jacobian'*CovMatrixInv*Error;

Delta = Info\E;
Sum_Delta = Delta'*Delta;
end
