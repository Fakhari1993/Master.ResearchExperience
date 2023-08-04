function Kf=Kfold(Data,Lable,K)
DataOne=Data(1:78,:);
DataNOne=Data(79:end,:);
TargetOne=Lable(1:78,:);
TargetNOne=Lable(79:end,:);
SizeData=size(Data,1);
Step=ceil(SizeData/(K*2));
TrivalInd=1:Step:SizeData;
TrivalInd=TrivalInd(1,1:K+1);
TrivalInd(1,end)=SizeData/2+1;
for i=1:K
    A(i).Ind=TrivalInd(i):TrivalInd(i+1)-1;
end
for i=1:K
    TestInd=[];
    TrainInd=[];
    for j=1:K
        if i==j
            TestInd=A(j).Ind;
        else
            TrainInd=[TrainInd, A(j).Ind];
        end
    end
    %% 
    trainX=DataOne(TrainInd,:);
    trainX=[trainX; DataNOne(TrainInd,:)];
    trainY=TargetOne(TrainInd,:);
    trainY=[trainY; TargetNOne(TrainInd,:)];
    Kf(i).trainX=trainX;
    Kf(i).trainY=trainY;
    %% Test
    testX=DataOne(TestInd,:);
    testX=[testX; DataNOne(TestInd,:)];
    testY=TargetOne(TestInd,:);
    testY=[testY; TargetNOne(TestInd,:)];
    Kf(i).testX=testX;
    Kf(i).testY=testY;
end