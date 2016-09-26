% Calculates the Area of Each Gene Comparison
% Import Data from GSE61191 and average expression between mice (make sure probes are labeled with gene names) 
% Alternatively use Area.mat 
% Data contains the average expression (n=3,live mice) for 25,697 genes
% CSymbol contains the list of 25,697 genes and Cluster is the respected k-means cluster
% CSybol list obtained from talbe (S1 Table) of Plos Bio paper also 

%Vectors
Data_norm=zscore(Data,[],1);
Area_List=zeros(length(Data_norm),length(Data_norm));
Final_List=cell(length(Data_norm)*2,1);

%Generate the Area for Each Combination
k=1;
l=1;

for i=1:length(Data_norm)
    for j=i+1:length(Data_norm) 
        
        Area_List(i,j)=polyarea(Data_norm(:,i),Data_norm(:,j)); 
        
       
       
        if Area_List(i,j)>11
            
            C1=Cluster(find(strcmp(GeneSymbol(i),CSymbol)));
            C2=Cluster(find(strcmp(GeneSymbol(j),CSymbol)));
            
            Final_List{k}=[GeneSymbol(i),GeneSymbol(j),C1,C2,i,j,Area_List(i,j)'];
            k=k+1;
            
            if mod(i,100)==0
                i
            end
        end
        %
        %
    end
    %
end