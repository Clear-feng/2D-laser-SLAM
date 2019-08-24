function caseIdx = WhichCase(idx, nscan)
%Check case condition
%case 1 initialize submap1
%case 2 initialize submap2
%case 3 update both submaps
%case 4 only update submap1

if idx <= nscan/2
    caseIdx = 4;
else
    cases = mod(idx,nscan);
    switch cases
        case 1
            caseIdx = 1;
        case (nscan/2+1)
            caseIdx = 2;
        otherwise
            caseIdx = 3;
    end
end
end