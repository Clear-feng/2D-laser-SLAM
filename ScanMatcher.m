function [Xstate,Error] = ScanMatcher(DT, scan, Xstate, param)

%linearize the distance grid map
[XX, YY] = ndgrid(1:param.size(1), 1:param.size(2));
DTgrid = griddedInterpolant(XX, YY, DT, 'nearest');
CovMatrixInv = eye(length(scan(:,1)));

%linearize the corespoding gradient
[FY,FX] = gradient(DT, 1/param.resol, 1/param.resol);
GXgrid = griddedInterpolant(XX, YY, FX, 'nearest');
GYgrid = griddedInterpolant(XX, YY, FY, 'nearest');

[Error,xq, yq] = FuncDiff(scan, Xstate, DTgrid, param);
Sum_Error = Error.'*Error/size(scan,1);
Sum_Delta = Inf;

MaxIter = 35;
MinDelta = 1e-7;
MinError = 1e-5;
Iter = 0;

while Sum_Error>MinError && Sum_Delta>MinDelta && Iter<=MaxIter
    Iter = Iter+1;
    
    %Get correspoding cost and gradient matrix, dist = Z-F(X0)
    Gmatrix = [GXgrid(xq,yq),GYgrid(xq,yq)];
    JFX = FuncJacobian(scan, Xstate, Gmatrix);
    [Delta, Sum_Delta] = FuncDelta(JFX, Error, CovMatrixInv);
    Xstate = FuncUpdate(Xstate, Delta);
    
    [Error,xq, yq] = FuncDiff(scan, Xstate, DTgrid, param);
    Sum_Error = Error.'*Error/size(scan,1);
end

fprintf('Iterations %d Sum_Delta %e Sum_Error %e\n', Iter, Sum_Delta, Sum_Error);

end