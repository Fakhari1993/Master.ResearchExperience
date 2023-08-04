 clc
 clear all
 close all
 %% 
 load DataSet
 Target=DataSet(:,end);
 MainData=DataSet(:,1:end-1);
 K=10;
 PrePareData=Kfold(MainData,Target,K);
 
 for k=1:K
     TrainData=PrePareData(k).trainX;
     TrainLabel=PrePareData(k).trainY;
     MLP_Sa_out=[TrainLabel, -1*TrainLabel]';

       si=[40 30];  
       TF1 = 'logsig';
       TF2 = 'logsig';
       BTF = 'traincgp';
       BLF = 'learngd';
       PF = 'mse';
      net = newff(TrainData',MLP_Sa_out,si,{TF1 TF2},BTF,BLF,PF);
      
      net.trainparam.epochs =50;
      net.trainparam.goal = 0.0;
      net.trainparam.Max_perf_inc = 1.04;
      net.trainparam.Lr = 0.2;
      net.trainparam.Lr_dec = 0.7;
      net.trainparam.Lr_inc = 1.05;
      
      
      net=init(net); %initialising the weight and bias wectors
      net=train(net,TrainData',MLP_Sa_out); %training the network
      
      %% test MLP
     TestData=PrePareData(k).testX;
     TestLabel=PrePareData(k).testY;
     TestLabel=[TestLabel, -1*TestLabel]';
     
     Class=sim(net,TestData'); %simulation the network
 % bigesst
       MCTe=[];
       MCReal=[];
       for i=1:length(Class)
       MCTe(i)=find(Class(:,i)==max(Class(:,i)));
       MCReal(i)=find(TestLabel(:,i)==max(TestLabel(:,i)));
       end
       MLP_Accuracy_Test(k)=100-nnz(MCTe-MCReal)/length(TestLabel)*100;
      
 end
 FinalAccuracyMLP=mean(MLP_Accuracy_Test);
 