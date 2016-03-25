

%Upload data from Figure 3C.mat
%Distance Formula for Matrix (rows= samples, columns =genes)

Z1=zscore(HumanSigData,[],1);%Replace with your own dataset
Y=pdist(Z1);
V=squareform(Y);
Gene_Total=HSymbol;%replace with your symbol list

%Variables for Parasite Load and RBC
n=0;
b=[];
c=[];

%Identify the column for the gene of interest in CAPSLOCK

x=find(strcmp('C1QB',Gene_Total)); % If there are multiple genes with the same name it will save all,only call one
y=find(strcmp('TRIM10',Gene_Total));
z=find(strcmp('RBC',Gene_Total));

H=[HumanSigData(:,x(1,1)), HumanSigData(:,y(1,1)),HumanSigData(:,z(1,1))];

hold on 



            
for t=1:size(HumanSigData,1)
    
    
    % Control the Number of Neighbors
    
    [sortedValues,sortIndex]=sort(V(t,:),'ascend');
    minIndex=sortIndex(1:5);
    
    hold on
    
    %Connect & Plot the Neighboring Samples
    
    for i=1:size(minIndex,2)
        
   
         
         b=[H(minIndex(i),1),H(t,1)];
         c=[H(minIndex(i),2),H(t,2)];
         m=[H(minIndex(i),3),H(t,3)];
         
         
         if MalariaInfection{t}=='POSITIF'
             plot3(b,c,m,'k.','Marker','square','MarkerSize',5)
             plot3(b,c,m,'b-','LineWidth',.05);
             
         else
             plot3(b,c,m,'k.','Marker','square','MarkerSize',5)
             plot3(b,c,m,'r-','LineWidth',.05);
             
         end
   
         
        end
   
                
    
     xlabel(Gene_Total(x(1,1)));
     ylabel(Gene_Total(y(1,1)));
     zlabel(Gene_Total(z(1,1)));
    
     
     hold off
    
   
    
end

