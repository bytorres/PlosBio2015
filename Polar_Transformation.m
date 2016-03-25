%%% Converting phase plane data to polar coordinates and finding the
%%% optimal shift.
% Data.txt is available in the github repository

% Step 1. Import Data into a Table 
% 4 columns: x axis, y axis, Status (Categorical),Status(numeric)

A=readtable('Data.txt','Delimiter','\t','Format','%f%s%u%f%f%s%u','ReadVariableNames',true);
% Center Around Loop (i.e. ignore arcs)
A=sortrows(A,'Status','ascend');
A.Status=categorical(A.Status);
A2=A(A.Status=='Live',:);

x=log(A2.x); % Log transform all data
y=log(A2.y);

% Step 2. Verify Proper Import 

figure(1)
plot(x,y,'k','Markersize',30); 

[ANGLE, RADIUS] = cart2pol(x,y);



% Step 3. Manipulate the Data to be centered and normalized

R1=min(x);
R2=max(x);
R3=min(y);
R4=max(y);

erval = R1:.2:R2;
er2val = R3:.2:R4;
k = (R4-R3)/(R2-R1); %% normalization multiplier


% Step 3.2. Find the optimal x,y shift that minimizes variance of radius

varianceER = zeros(length(erval),length(er2val),1);



for i = 1:length(erval) %% x shift
    for j = 1:length(er2val) %% y shift
        
        %Center on only live data
        xdata =log(A2.x);
        ydata =log(A2.y);
        
        % Store all of the TH, RH data for each combo
        [AH,RH]=cart2pol((xdata-erval(i))*k,ydata-er2val(j));
        
        A2.angle = AH;
        A2.radius = RH;
        
        % Calculate the variances of the radius set
        varyALL = var(A2.radius);
        % Store the variance data in the matrix
        varianceER(i,j,:) = varyALL;
        
        
    end
end

% Find the x,y coordinate that minimizes variance in radius
    
[maxval, maxloc] = min(varianceER(:));
    uhoh = varianceER(maxloc);
    [maxloc_row ,maxloc_col] = ind2sub(size(varianceER), maxloc);
    xvalpos = (maxloc_row);
    yvalpos = (maxloc_col);
    xval = erval(xvalpos);
    yval = er2val(yvalpos);
    
%Apply to all data
    x=log(A.x);
    y=log(A.y);
    
% Plot shifted points by optional treatment specification
    [AHa,RHa]=cart2pol((x-xval)*k,(y-yval)); % apply shift to all the data
   
    figure(2);
    p = polar(AHa,RHa,'k');
    set(p,'Markersize',12, 'MarkerFaceColor','r');

%Step 4. Write shifted/normalized angle,radius data to file
      A.angle = AHa *57.2957795; % convert to degrees
      A.radius = RHa;
      writetable(A, 'Polar2.txt','Delimiter','\t');
      
