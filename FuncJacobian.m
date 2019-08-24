function JFX = FuncJacobian(scan, Xstate, Gmatrix)
nRow = length(scan(:,1));
JFX = zeros(nRow,length(Xstate));
for i = 1 : nRow 
%         JFX(i,:) = Gmatrix(i,:)* ...
%                [1, 0;
%                 0, 1];
    JFX(i,:) = Gmatrix(i,:)* ...
               [1, 0, -scan(i, 1)*sin(Xstate(3)) - scan(i, 2)*cos(Xstate(3));
                0, 1,  scan(i, 1)*cos(Xstate(3)) - scan(i, 2)*sin(Xstate(3))];
end
end