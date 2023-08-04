clc
 clear all
 close all
 %% 
 load DataSet
 Target=DataSet(:,end);
 MainData=DataSet(:,1:end-1);
 
 Temp=find(1==Target);
 TrianID=Temp(1:ceil(0.7*length(Temp)));
 TestID=Temp(ceil(0.7*length(Temp))+1:end);
 TrainData=MainData(TrianID,:);
 TrainLabel=Target(TrianID);
 TestData=MainData(TestID,:);
 TestLabel=Target(TestID);
 
 Temp=find(-1==Target);
 TrianID=Temp(1:ceil(0.7*length(Temp)));
 TestID=Temp(ceil(0.7*length(Temp))+1:end);
 TrainData=[ TrainData;MainData(TrianID,:)];
 TrainLabel=[TrainLabel;Target(TrianID)];
 TestData=[TestData;MainData(TestID,:)];
 TestLabel=[TestLabel;Target(TestID)];
 clear Temp TrianID TestID MainData  Target
%%  


     NaiveModel=NaiveBayes.fit(TrainData,TrainLabel);
     %% 
     PredictelLabel=NaiveModel.predict(TestData);
     NaiveAccuracy=100-nnz(PredictelLabel-TestLabel)/length(TestLabel)*100;
