%导入各个企业影响信贷风险的因素量化判断表
data=xlsread('D:\pycharm_code\CUMCM\AHP_form2.xlsx','A2:F303');
[hang,lie]=size(data); 

%构造判断矩阵第一层
A=[1 2 0.5 1/3 1/6 ;
    0.5 1 1/3 0.25 1/7;
    2 3 1 0.5 0.2 ;
    3 4 2 1 0.25 ;
    5 7 5 4 1];
%%%%%%%%%%%%%%%%%%%%
hang = 302;lie = 5;
%%%%%%%%%%%%%%%%%%%%
%建立元胞数组，存放七个判断矩阵的内容
C1=eye(hang);
C2=C1;
C3=C1;
C4=C1;
C5=C1;
C6=C1;
C7=C1;
c=cell(1,8);

%对总利润进行数据处理,生成判断矩阵
data_1=[];
for j=1:hang
    if data(j,1)>10000000
        data_1(j,1)=6;
    elseif data(j,1)>1000000
        data_1(j,1)=5;
    elseif data(j,1)>100000
        data_1(j,1)=4;
    elseif data(j,1)>0
        data_1(j,1)=3;
    elseif data(j,1)>-100000
        data_1(j,1)=2;
    else
        data_1(j,1)=1;   
    end
end
for j=1:hang
    for i=1:hang-j
        if data_1(j+i,1)-data_1(j,1)>0
            C1(j+i,j)=data_1(j+i,1)+1-data_1(j,1);
            C1(j,j+i)=1/(data_1(j+i,1)+1-data_1(j,1));
        elseif data_1(j+i,1)-data_1(j,1)==0
            C1(j,j+i)=1;
            C1(j+i,j)=1;
         elseif data_1(j+i,1)-data_1(j,1)<0
            C1(j+i,j)=1/(abs(data_1(j+i,1)-data_1(j,1))+1);
            C1(j,j+i)=abs(data_1(j+i,1)-data_1(j,1))+1;
        end
    end
end

%对销售总金额进行数据处理，生成判断矩阵
data_2=[];
for j=1:hang
    if data(j,2)>100000000
        data_2(j,1)=5;
    elseif data(j,2)>10000000
        data_2(j,1)=4;
    elseif data(j,2)>1000000
        data_2(j,1)=3;
    elseif data(j,2)>100000
        data_2(j,1)=2;
    elseif data(j,2)>10000
        data_2(j,1)=1;
    end
end
for j=1:hang
    for i=1:hang-j
        if data_2(j+i,1)-data_2(j,1)>0
            C2(j+i,j)=data_2(j+i,1)+1-data_2(j,1);
            C2(j,j+i)=1/(data_2(j+i,1)+1-data_2(j,1));
        elseif data_2(j+i,1)-data_2(j,1)==0
            C2(j,j+i)=1;
            C2(j+i,j)=1;
         elseif data_2(j+i,1)-data_2(j,1)<0
            C2(j+i,j)=1/(abs(data_2(j+i,1)-data_2(j,1))+1);
            C2(j,j+i)=abs(data_2(j+i,1)-data_2(j,1))+1;
        end
    end
end

%发票作废率数据处理与判断矩阵
data_3=[];
for j=1:hang
    if data(j,3)>0.5
        data_3(j,1)=1;
    elseif data(j,3)>0.4
        data_3(j,1)=2;
    elseif data(j,3)>0.3
        data_3(j,1)=3;
    elseif data(j,3)>0.2
        data_3(j,1)=4;
    elseif data(j,3)>0.1
        data_3(j,1)=5;
    elseif data(j,3)>0.05
        data_3(j,1)=6;
    else
        data_3(j,1)=7;
    end
end
for j=1:hang
    for i=1:hang-j
        if data_3(j+i,1)-data_3(j,1)>0
            C3(j+i,j)=data_3(j+i,1)+1-data_3(j,1);
            C3(j,j+i)=1/(data_3(j+i,1)+1-data_3(j,1));
        elseif data_3(j+i,1)-data_3(j,1)==0
            C3(j,j+i)=1;
            C3(j+i,j)=1;
         elseif data_3(j+i,1)-data_3(j,1)<0
            C3(j+i,j)=1/(abs(data_3(j+i,1)-data_3(j,1))+1);
            C3(j,j+i)=abs(data_3(j+i,1)-data_3(j,1))+1;
        end
    end
end

%利润率数据处理和判断矩阵
for j=1:hang
    if data(j,4)>0.8
        data_4(j,1)=8;
    elseif data(j,4)>0.6
        data_4(j,1)=7;
    elseif data(j,4)>0.4
        data_4(j,1)=6;
    elseif data(j,4)>0.2
        data_4(j,1)=5;
    elseif data(j,4)>0.1
        data_4(j,1)=4;
    elseif data(j,4)>0
        data_4(j,1)=3;
    elseif data(j,4)>-0.2
        data_4(j,1)=2;
    else
        data_4(j,1)=1;
    end
end
for j=1:hang
    for i=1:hang-j
        if data_4(j+i,1)-data_4(j,1)>0
            C4(j+i,j)=data_4(j+i,1)+1-data_4(j,1);
            C4(j,j+i)=1/(data_4(j+i,1)+1-data_4(j,1));
        elseif data_4(j+i,1)-data_4(j,1)==0
            C4(j,j+i)=1;
            C4(j+i,j)=1;
         elseif data_4(j+i,1)-data_4(j,1)<0
            C4(j+i,j)=1/(abs(data_4(j+i,1)-data_4(j,1))+1);
            C4(j,j+i)=abs(data_4(j+i,1)-data_4(j,1))+1;
        end
    end
end

%信用评级判断矩阵
data_5=data(:,5);
for j=1:hang
    for i=1:hang-j
        if data_5(j+i,1)-data_5(j,1)>0
            C5(j+i,j)=data_5(j+i,1)+1-data_5(j,1);
            C5(j,j+i)=1/(data_5(j+i,1)+1-data_5(j,1));
        elseif data_5(j+i,1)-data_5(j,1)==0
            C5(j,j+i)=1;
            C5(j+i,j)=1;
         elseif data_5(j+i,1)-data_5(j,1)<0
            C5(j+i,j)=1/(abs(data_5(j+i,1)-data_5(j,1))+1);
            C5(j,j+i)=abs(data_5(j+i,1)-data_5(j,1))+1;
        end
    end
end

% %三年平均利润增长率判断矩阵
% for j=1:hang
%     if data(j,6)>1
%         data_6(j,1)=7;
%     elseif data(j,6)>0.1
%         data_6(j,1)=6;
%     elseif data(j,6)>0.05
%         data_6(j,1)=5;
%     elseif data(j,6)>0
%         data_6(j,1)=4;
%     elseif data(j,6)>-0.05
%         data_6(j,1)=3;
%     elseif data(j,6)>-0.1
%         data_6(j,1)=2;
%     else
%         data_6(j,1)=1;
%     end
% end
% for j=1:hang
%     for i=1:hang-j
%         if data_6(j+i,1)-data_6(j,1)>0
%             C6(j+i,j)=data_6(j+i,1)+1-data_6(j,1);
%             C6(j,j+i)=1/(data_6(j+i,1)+1-data_6(j,1));
%         elseif data_6(j+i,1)-data_6(j,1)==0
%             C6(j,j+i)=1;
%             C6(j+i,j)=1;
%          elseif data_6(j+i,1)-data_6(j,1)<0
%             C6(j+i,j)=1/(abs(data_6(j+i,1)-data_6(j,1))+1);
%             C6(j,j+i)=abs(data_6(j+i,1)-data_6(j,1))+1;
%         end
%     end
% end
% 
% %违约情况判断矩阵
% data_7=data(:,7);
% data_7=~data_7;
% data_7=data_7*4+1;
% for j=1:hang
%     for i=1:hang-j
%         if data_7(j+i,1)-data_7(j,1)>0
%             C7(j+i,j)=data_7(j+i,1)+1-data_7(j,1);
%             C7(j,j+i)=1/(data_7(j+i,1)+1-data_7(j,1));
%         elseif data_7(j+i,1)-data_7(j,1)==0
%             C7(j,j+i)=1;
%             C7(j+i,j)=1;
%          elseif data_7(j+i,1)-data_7(j,1)<0
%             C7(j+i,j)=1/(abs(data_7(j+i,1)-data_7(j,1))+1);
%             C7(j,j+i)=abs(data_7(j+i,1)-data_7(j,1))+1;
%         end
%     end
% end



%矩阵列向量归一化
A1=A;
for i=1:5
    A1(:,i)=A(:,i)/norm(A(:,i));
end

%将向量按行求和sum_A为w0
sum_A=sum(A1,2);

%再进行列向量归一化
sum_A=sum_A(:,1)/norm(sum_A(:,1));
AW=A*sum_A;

u0max=0;
for i=1:lie
    u0max=AW(i,1)/sum_A(i,1)+u0max;
end
u0max=(1/lie)*u0max;

%一致性检验
CI=(u0max-5)/4;
CR=CI/1.32;



C11=C1;
for i=1:lie
    C11(:,i)=C1(:,i)/norm(C1(:,i));
end

%将向量按行求和sum_A为w0
sum_C1=sum(C11,2);

%再进行列向量归一化
sum_C1=sum_C1(:,1)/norm(sum_C1(:,1));
AW1=C1*sum_C1;

u0max1=0;
for i=1:lie
    u0max1=AW1(i,1)/sum_C1(i,1)+u0max1;
end
u0max1=(1/lie)*u0max1;

%一致性检验
CI1=(u0max1-hang)/(hang-1);
CR1=CI1/1.69;

C12=C2;
for i=1:lie
    C12(:,i)=C2(:,i)/norm(C2(:,i));
end

%将向量按行求和sum_A为w0
sum_C2=sum(C12,2);

%再进行列向量归一化
sum_C2=sum_C2(:,1)/norm(sum_C2(:,1));
AW2=C2*sum_C2;

u0max2=0;
for i=1:lie
    u0max2=AW2(i,1)/sum_C2(i,1)+u0max2;
end
u0max2=(1/lie)*u0max2;

%一致性检验
CI2=(u0max2-hang)/(hang-1);
CR2=CI2/1.69;

C13=C3;
for i=1:lie
    C13(:,i)=C3(:,i)/norm(C3(:,i));
end

%将向量按行求和sum_A为w0
sum_C3=sum(C13,2);

%再进行列向量归一化
sum_C3=sum_C3(:,1)/norm(sum_C3(:,1));
AW3=C3*sum_C3;

u0max3=0;
for i=1:lie
    u0max3=AW3(i,1)/sum_C3(i,1)+u0max3;
end
u0max3=(1/lie)*u0max3;

%一致性检验
CI3=(u0max3-hang)/(hang-1);
CR3=CI3/1.69;

C14=C4;
for i=1:lie
    C14(:,i)=C4(:,i)/norm(C4(:,i));
end

%将向量按行求和sum_A为w0
sum_C4=sum(C14,2);

%再进行列向量归一化
sum_C4=sum_C4(:,1)/norm(sum_C4(:,1));
AW4=C4*sum_C4;

u0max4=0;
for i=1:lie
    u0max4=AW4(i,1)/sum_C4(i,1)+u0max4;
end
u0max4=(1/lie)*u0max4;

%一致性检验
CI4=(u0max4-hang)/(hang-1);
CR4=CI4/1.69;

C15=C5;
for i=1:lie
    C15(:,i)=C5(:,i)/norm(C5(:,i));
end

%将向量按行求和sum_A为w0
sum_C5=sum(C15,2);

%再进行列向量归一化
sum_C5=sum_C5(:,1)/norm(sum_C5(:,1));
AW5=C5*sum_C5;

u0max5=0;
for i=1:lie
    u0max5=AW5(i,1)/sum_C5(i,1)+u0max5;
end
u0max5=(1/lie)*u0max5;

%一致性检验
CI5=(u0max5-hang)/(hang-1);
CR5=CI5/1.69;

% C16=C6;
% for i=1:lie
%     C16(:,i)=C6(:,i)/norm(C6(:,i));
% end
% 
% %将向量按行求和sum_A为w0
% sum_C6=sum(C16,2);
% 
% %再进行列向量归一化
% sum_C6=sum_C6(:,1)/norm(sum_C6(:,1));
% AW6=C6*sum_C6;
% 
% u0max6=0;
% for i=1:lie
%     u0max6=AW6(i,1)/sum_C6(i,1)+u0max6;
% end
% u0max6=(1/lie)*u0max6;
% 
% %一致性检验
% CI6=(u0max6-hang)/(hang-1);
% CR6=CI6/1.69;
% 
% C17=C7;
% for i=1:lie
%     C17(:,i)=C7(:,i)/norm(C7(:,i));
% end
% 
% %将向量按行求和sum_A为w0
% sum_C7=sum(C17,2);
% 
% %再进行列向量归一化
% sum_C7=sum_C7(:,1)/norm(sum_C7(:,1));
% AW7=C7*sum_C7;
% 
% u0max7=0;
% for i=1:lie
%     u0max7=AW7(i,1)/sum_C7(i,1)+u0max7;
% end
% u0max7=(1/lie)*u0max7;
% 
% %一致性检验
% CI7=(u0max7-hang)/(hang-1);
% CR7=CI7/1.69;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%将所有权重都归一化后，对每个方案计算它的最终权重
sum_A = sum_A./2.14;
sum_C1 = sum_C1./52.65;
sum_C2 = sum_C2./9.89;
sum_C3 = sum_C3./10.294;
sum_C4 = sum_C4./9.61;
sum_C5 = sum_C5./9.89;
%sum_C6 = sum_C5./9.11;

sum_C1 = sum_C1.*(1000*sum_A(1));
sum_C2 = sum_C2.*(1000*sum_A(2));
sum_C3 = sum_C3.*(1000*sum_A(3));
sum_C4 = sum_C4.*(1000*sum_A(4));
sum_C5 = sum_C5.*(1000*sum_A(5));
%sum_C6 = sum_C6.*(1000*sum_A(6));

sum_C = sum_C1 + sum_C2 + sum_C3 + sum_C4 + sum_C5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum_all=[sum_C1,sum_C2,sum_C3,sum_C4,sum_C5];
fan=sum_all*sum_A(1:5,1);

