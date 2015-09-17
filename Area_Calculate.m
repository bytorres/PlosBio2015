% Calculates the Area of Each Gene Comparison
% Import Data,Gene Name and Cluster Number from Supplementary Table 1.

%Variables, Insert Variable Name
ClusterA=Data; 
ClusterA=zscore(ClusterA,[],1);


ClusterB=Data;
ClusterB=zscore(ClusterB,[],1);

GeneA_List=GeneSymbol;
GeneB_List=GeneSymbol;

X=[];
X_Gene={};

Y=[];
Y_Gene={};

Area_List=[];
Selected_Area=[];
Cluster_GeneA=[];
Cluster_GeneB=[];

Final_List=[];

%Generate the Area for Each Combination
for i=1:length(ClusterA)
 for j=i+1:length(ClusterB) % Make sure it doesn't look at the previous comparison
        Area_List(i,j)=polyarea(ClusterA(:,i),ClusterB(:,j)); % creating the Area Matrix by row % a problem when the data is not a complete square 
        
  end
end 

%Skips the last comparison, add a row of zeros
%A(A==0)=[];
Area_List(length(Area_List),:)=zeros;


% Examine each Row and Column
 for k=1:length(ClusterA)
     for l=1:length(ClusterB)

%         Area Greater than 10 Store
          if Area_List(k,l)>11
                        
%             Stores the Index of X
              X(length(X)+1)=k;
%             Stores the Gene_Name of X
              X_Gene(length(X_Gene)+1)=GeneA_List(k);
              
%             Stores the Index of X
              Y(length(Y)+1)=l;
%             Stores the Gene_Name of Y
              Y_Gene(length(Y_Gene)+1)=GeneB_List(l);
              
%             Stores the Area of the pair
              Selected_Area(length(Selected_Area)+1)=Area_List(k,l);
              
%             Stores the Clusters of the pair
              Cluster_GeneA(length(Cluster_GeneA)+1)=Cluster_Info(k);
              Cluster_GeneB(length(Cluster_GeneB)+1)=Cluster_Info(l);
       
         end
%         
%         
    end
%     
 end
 xy_gene=horzcat(X_Gene', Y_Gene');
 Final_List=[X',Y',Selected_Area',Cluster_GeneA',Cluster_GeneB'];

