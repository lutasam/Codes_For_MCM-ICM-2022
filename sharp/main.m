% gold = table2array(gold);
% bit = table2array(bit);
n = size(bit);
m = size(gold);
money = [];
for i = 1 : n(1)
    money(i) = 1;
end

i = 1;j = 1;
init_m = 1000;
sharpe=[];
shouyilv=[];
maxWeight = [1, 0, 0];
while i < m(1)-1 && j < n(1)-1
    beforeWeight = maxWeight;
    if bit(j,1) == gold(i,1)
        w = [0.33, 0.33, 0.34];
        tt = 0;
        for k = 1 : 100
            shouyilv(j) = w(2)*str2num(gold(i,3))+w(3)*str2num(bit(j,3));
            sr = (mean(shouyilv))/std(shouyilv);
            if tt < sr
                tt = sr;
                maxWeight = w;
            else
                temp = rand(1,3);
                w = temp/sum(temp);
            end
        end
        sharpe(j) = tt;
        i=i+1;j=j+1;
    else
        w = [0.33, 0.33, 0.33];
        tt = 0;
        for k = 1 : 100
            shouyilv(j) = w(3)*str2num(bit(j,3));
            sr = (mean(shouyilv))/std(shouyilv);
            if tt < sr
                tt = sr;
                maxWeight = w;
            else
                temp = rand(1,3);
                w = temp/sum(temp);
            end
        end
        sharpe(j) = tt;
        j=j+1;
    end
    init_m = maxWeight(1)*init_m + (maxWeight(2)-beforeWeight(2))*str2num(gold(i,2)) + (maxWeight(3)-beforeWeight(3))*str2num(bit(j,2));
end

disp(init_m);