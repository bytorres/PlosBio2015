%NEW
%Upload data from Figure 3B.mat


%Data
Data=NNST5_C1qb; % Can use your own data
Symbol=NNST5Symbol; % replace with your list of symbols

% Apply the Distance Formula to the Matrix (rows= samples, columns =genes)
Y=pdist(NNST5_C1qb);
V=squareform(Y); 

%Variables for Parameters of Interest
n=0;
b=[];
c=[];
m=[];


%Identify the column for the gene of interest

x=find(strcmp('Trim10',Symbol));
y=find(strcmp('C1qb',Symbol));
z=find(strcmp('RBC',Symbol));

H=[Data(:,x(1,3)), Data(:,y(1,1)),Data(:,z(1,1))];

 
for t=1:size(Data,1) 
     % Nearest Neigbor and Number of Connections
     [sortedValues,sortIndex]=sort(V(t,:),'ascend');
     
     minIndex=sortIndex(1:6); % change number of connections here
     
     hold on
     
     % Connect & Plot the Neighboring Samples
     
     for i=1:size(minIndex,2) 
         b=[H(minIndex(i),1),H(t,1)];
         c=[H(minIndex(i),2),H(t,2)];
         m=[H(minIndex(i),3),H(t,3)];
         
         plot3(b,c,m,'b.');
         plot3(b,c,m,'b-','LineWidth',2);
         
     end
     
     % Label axis
     xlabel(Symbol(x(1,1)));
     ylabel(Symbol(y(1,1)));
     zlabel(Symbol(z(1,1)));
     
     
end


       


