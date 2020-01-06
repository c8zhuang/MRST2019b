function [sdc, Geo] = computeSorensenDiceCoefficient(cdataA, cdataB)
% pass in two different plume outline data which was generated by
% drawContours.m (called by mapPlot.m), and compute the Sørensen Dice
% coefficient: sdc = 2*C/(A+B), where A and B are areas of the two plumes,
% and C is their intersection area.

% Note: function computeSorensenDiceCoefficient() requires:
% * Polygons_intersection
% https://se.mathworks.com/matlabcentral/fileexchange/18173-polygon_intersection?s_tid=prof_contriblnk
% * PolygonClipper
% https://se.mathworks.com/matlabcentral/fileexchange/8818-polygon-clipper?s_tid=prof_contriblnk
% (Polygons_intersection requires PolygonClipper)

% % for plume data A
cdata = cdataA;

sep_ind = find(cdata(1,:) == min(cdata(1,:)));
ind2start = 1;

if sep_ind(1) == 1
   ind2start = 2;
   sep_ind(1) = [];
end

P = [];
for i=1:numel(sep_ind)+1
    if i == numel(sep_ind)+1
        if numel(sep_ind) == 0
            ind2end = numel(cdata(1,:));
        elseif sep_ind(i-1) ~= numel(cdata(1,:))
            ind2end = numel(cdata(1,:));
        end
    else
        ind2end = sep_ind(i)-1;
    end
    P(i).x = cdata(1, ind2start : ind2end);
    P(i).y = cdata(2, ind2start : ind2end);
    assert(all(P(i).x > 4e5)); % approx limits of Utsira grid (llcorner).
    assert(all(P(i).y > 6.4e6));
    P(i).hole = 0; % will get updated in a following step
    ind2start = ind2end+2;
end
S(1).P = P; clear P ind2start ind2end;

S(1) = assessHoles(S(1));


% for plume data B
cdata = cdataB;

sep_ind = find(cdata(1,:) == min(cdata(1,:)));
ind2start = 1;

if sep_ind(1) == 1
   ind2start = 2;
   sep_ind(1) = [];
end

P = [];
for i=1:numel(sep_ind)+1
    if i == numel(sep_ind)+1
        if numel(sep_ind) == 0
            ind2end = numel(cdata(1,:));
        elseif sep_ind(i-1) ~= numel(cdata(1,:))
            ind2end = numel(cdata(1,:));
        end
    else
        ind2end = sep_ind(i)-1;
    end
    P(i).x = cdata(1, ind2start : ind2end);
    P(i).y = cdata(2, ind2start : ind2end);
    assert(all(P(i).x > 4e5)); % approx limits of Utsira grid (llcorner).
    assert(all(P(i).y > 6.4e6));
    P(i).hole = 0; % will get updated in a following step
    ind2start = ind2end+2;
end
S(2).P = P; clear P ind2start ind2end;

S(2) = assessHoles(S(2));


% Compute polygon intersection area with downloadable function:
Geo = Polygons_intersection(S,0,1e-6);

sdc = [];
assert(numel(Geo) == 1 || numel(Geo) == 2 || numel(Geo) == 3);

% Individual plume (polygon) areas A and B:
A = 0;
for i=1:size(S(1).P, 2)
    if S(1).P(i).hole == 0
        A = A + polyarea(S(1).P(i).x, S(1).P(i).y);
    elseif S(1).P(i).hole == 1
        A = A - polyarea(S(1).P(i).x, S(1).P(i).y);
    end
end
B = 0;
for i=1:size(S(2).P, 2)
    if S(2).P(i).hole == 0
        B = B + polyarea(S(2).P(i).x, S(2).P(i).y);
    elseif S(2).P(i).hole == 1
        B = B - polyarea(S(2).P(i).x, S(2).P(i).y); 
    end
end

% Intersecting polygon area C:
if numel(Geo) == 3
    assert(Geo(1).index == 1);
    assert(Geo(2).index == 2);
    assert(all(Geo(3).index == [1,2]));
    assert( (Geo(1).area + Geo(3).area - A)/A*100 < 1); % less than a percent difference
    assert( (Geo(2).area + Geo(3).area - B)/B*100 < 1); % less than a percent difference
    C = Geo(3).area;
end
if numel(Geo) == 2
    assert(all(Geo(2).index == [1,2]));
    C = Geo(2).area;
end
if numel(Geo) == 1
    assert(all(Geo.index == [1,2]));
    C = Geo.area;
end

sdc = 2*C / (A + B);

end

function S = assessHoles(S)
% S is a structure containing i polygons, P(i)
% P(i) contains fields x and y

    for i=1:numel(S.P)
        for j=1:numel(S.P)
            if i==j
                continue % no need to check whether polygon 1 is inside polygon 1, for example
            else
                % is polygon P(i) inside or on the edge of polygon P(j) ?
                in = inpolygon(S.P(i).x, S.P(i).y, S.P(j).x, S.P(j).y);
                if any(in)
                    % if any one point is inside, then all should be inside
                    if ~all(in)
                        %warning('Polygons unexpectedly cross over each other.')
                        % but we will continue anyways
                    else
                        S.P(i).hole = 1; % this polygon is a hole
                    end
                end
            end
        end
    end

end