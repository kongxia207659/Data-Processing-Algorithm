clear;
clc;
load('dataset.mat');%读入数据集
data=dataset4classification;%data为数据集副本
Data=data(:,5);%Data提取data第5列
max_=max(size(data));
averageAccuracyTrain=0;
averageAccuracyTest=0;
 for i=1:max_ %将第5列到第7列作为类标式列
   switch Data(i)
      case 1
      data(i,5:7)=[0,0,1];
      case 2
      data(i,5:7)=[0,1,0];
      case 3 
      data(i,5:7)=[1,0,0];
   end
 end
[P_data,train_ps] = mapstd(data);%对数据集副本data第1到4列规范化
P_data(:,5:7)=data(:,5:7);%将数据集副本data的第5列到第7列链到P_data中，此时P_data为规范化后的数据集
[M,N]=size(P_data);
indices=crossvalind('Kfold',P_data(1:M,N),5);%110 5折交叉验证
for k=1:5
    countTrain=0;
    countTest=0;
    test = (indices == k);
    train_ = ~test; 
    train_data=P_data(train_,:);
    test_data=P_data(test,:);
    train_t=train_data(:,5:7);%训练目标集
    train_p=train_data(:,1:4);%训练数据集
    test_t=test_data(:,5:7);%测试目标集
    test_p=test_data(:,1:4);%测试数据集
    train_t=train_t';%转置矩阵
    train_p= train_p';
    test_t=test_t';
    test_p=test_p';
    NP1=10;%第1个隐层神经元个数
    NP2=8;%第2个隐层神经元个数
    TypeNum=3;%输出层神经元个数
    net=newff(minmax(train_p),[NP1,NP2,TypeNum],{'logsig','tansig','tansig'},'traingdx');%变学习率动量梯度下降算法traingdx
    net.trainparam.epochs=3000;%训练次数
    net.trainparam.goal=0.01;%目标误差
    net.trainparam.show=50;
    net.trainParam.lr = 0.02;
    net.trainparam.lr_dec = 0.7;%学习率下降比率
    net.trainParam.lr_inc = 1.05;%学习率提高比率
    net=train(net,train_p,train_t);
   [normTrainOutput] = sim(net,train_p);%网络模拟
   normTrainOutput = round(normTrainOutput);%对normTrainOutput四舍五入将数据规整为0和1
   ValidateTrain=normTrainOutput-train_t;%ValidateTrain为规整数据与训练数据差值
   ValidateTrain=sum(abs(ValidateTrain));%对ValidateTrain取绝对值再相加
   n=max(size(ValidateTrain));%n为ValidateTrain矩阵的长度
for i=1:n %遍历ValidateTrain若有0值则正确训练数加1
    if ValidateTrain(i)==0
        countTrain=countTrain+1;
    end
end
accuracyTrain=countTrain/n;
disp('训练总数：');
disp(n);
disp('训练样本中正确的总数:');
display(countTrain);
disp('正确率:');
display(accuracyTrain);
averageAccuracyTrain=accuracyTrain+averageAccuracyTrain;
[normTestOutput] = sim(net,test_p);
normTestOutput=round(normTestOutput);
ValidateTest=normTestOutput-test_t;
ValidateTest=sum(abs(ValidateTest));
n=max(size(ValidateTest));
for i=1:n
    if ValidateTest(i)==0
        countTest=countTest+1;
    end
end
accuracyTest=countTest/n;
disp('测试总数：');
disp(n);
disp('测试样本中正确的总数:');
display(countTest);
disp('正确率:');
display(accuracyTest);
averageAccuracyTest=accuracyTest+averageAccuracyTest;
end
disp('训练样本平均准确率')
averageAccuracyTrain=averageAccuracyTrain/5;
display(averageAccuracyTrain);
disp('测试样本平均准确率');
averageAccuracyTest=averageAccuracyTest/5;
display(averageAccuracyTest);
save model net



%n为输入层神经元，m为输出层神经元，h为隐层神经元,a=1~10个数
% h=sqrt(n+m)+a
% h=1.5*n
% h=sqrt(n*m)

%自适应学习速率通过保证稳定训练的前提下，达到了合理的高速率，可以减少训练时间。