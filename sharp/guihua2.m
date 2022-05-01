global bit gold i j R
load bit.mat;
load gold.mat;
bit = table2array(bit);
gold = table2array(gold);
money = 10000;
i = 3; j = 3;
n = size(gold);
m = size(bit);
moneyList=[1000];
k = 0;index=1;
R = [];
preW = [1,0,0];
currW = [1,0,0;0,0,0];
moneys=[1];
golds=[0];
bitcoins=[0];
interest=money;
cnt = 0;
while i < n(1) && j < m(1)
    if gold(i,1) == bit(j,1)
        Aeq = [1,1,1];
        beq = [1];
        lb = zeros(3,1);
        [w,fval]=ga(@obj,3,[],[],Aeq,beq,lb,[]);
        currW = w;
        money = (currW(1)-preW(1))*money + (currW(2)-preW(2))*str2num(gold(i,2))*0.99 + (currW(3)-preW(3))*str2num(bit(j,2))*0.98;
        if interest < money/w(1)
            cnt = cnt+1;
        end
        interest = abs(money/w(1)/1000);
        R(j) = w(1)*0.02/365 + w(2)*(str2num(gold(i+1,2))-str2num(gold(i,2)))/str2num(gold(i,2)) + w(3)*(str2num(bit(j+1,2))-str2num(bit(j,2)))/str2num(bit(j,2));
        preW = currW;
        i=i+1;j=j+1;
    else
%         c = [str2num(bit(j,2))/str2num(bit(j+1,3))];
%         Aeq = [1,1];
%         beq = [1-currW(2)];
%         lb = zeros(2,1);
%         [w,fval]=linprog(c,A,b,[],[],lb);
%         money = (currW(1)-preW(1))*money + (currW(2)-preW(2))*str2num(gold(i,2)) - (currW(3)-preW(3))*str2num(bit(j,2));
%         preW = currW;
        j=j+1;
    end
    if mod(k,100) == 0
        moneyList(index) = interest;
        index = index+1;
        moneys(index)=currW(1);
        golds(index)=currW(2);
        bitcoins(index)=currW(3);
    end
    k=k+1;
end
if interest < money/w(1)
     cnt = cnt+1;
end
interest = abs(money/w(1)/1000);
moneyList(index) = interest;
disp(money);

function y = obj(w)
    global bit gold i j R
    R(j) = w(1)*0.02/365 + w(2)*(str2num(gold(i+1,3))-str2num(gold(i,2)))/str2num(gold(i,2)) + w(3)*(str2num(bit(j+1,3))-str2num(bit(j,2)))/str2num(bit(j,2));
    y = -(mean(R)-0.095)/std(R);
end