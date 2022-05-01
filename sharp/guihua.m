load bit.mat
load gold.mat
bit = table2array(bit);
gold = table2array(gold);
money = 1000;
goldNum = 0;
bitcoinNum = 0;
i = 1; j = 1;
n = size(gold);
m = size(bit);
moneyList=[1000];
k = 0;index=1;
cnt = 0;

while i < n(1) && j < m(1)
    if gold(i,1) == bit(j,1)
            c = [-str2num(gold(i,2))/str2num(gold(i+1,3)), -str2num(bit(j,2))/str2num(bit(j+1,3))];
            A = [str2num(gold(i,2)), str2num(bit(j,2));
                -1, 0;
                0, -1];
            b = [money;goldNum;bitcoinNum];
            lb = zeros(2,1);
            [x,fval]=linprog(c,A,b,[],[],lb);
            if (x(1))*str2num(gold(i,2)) - (x(2))*str2num(bit(j,2)) > money
                cnt=cnt+1;
            end
            money = money - (x(1))*str2num(gold(i,2)) - (x(2))*str2num(bit(j,2));
            goldNum = goldNum+x(1);
            bitcoinNum = bitcoinNum+x(2);
        i=i+1;j=j+1;
    else
            c = [str2num(bit(j,2))/str2num(bit(j+1,3))];
            A = [str2num(bit(j,2)); -1];
            b = [money;bitcoinNum];
            lb = zeros(1,1);
            [x,fval]=linprog(c,A,b,[],[],lb);
            if (x(1))*str2num(bit(j,2)) > money
                cnt=cnt+1;
            end
            money = money - (x(1))*str2num(bit(j,2));
            bitcoinNum = bitcoinNum-x(1);
        j=j+1;
    end
    if mod(k,100) == 0
        moneyList(index) = money;
        index = index+1;
    end
    k=k+1;
end

money = money - (-goldNum)*str2num(gold(i-1,2)) - (-bitcoinNum)*str2num(bit(j-1,2));
moneyList(index) = money;
disp(money);