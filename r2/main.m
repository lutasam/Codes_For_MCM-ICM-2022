data = table2array(bit);
true_y = data(:,1);
predict_y = data(:,2);
tempdata=(true_y-predict_y).^2;
tempdata2=(true_y-mean(true_y)).^2;
r2=1 - ( sum(tempdata)/sum(tempdata2) );
rmse = sqrt(mean((predict_y-true_y).^2));