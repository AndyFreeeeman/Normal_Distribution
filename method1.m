close all

% 考生樣本數量
sample_number = 10000 ;

% 調整後標準差
o_ = sqrt(200) ;

% 調整後總平均值
u = 50 ;

original_sample_index = linspace(1,sample_number,sample_number) ;
after_process = zeros(1 , sample_number) ;
result_score = zeros(1 , sample_number) ;
x = linspace(1,100,sample_number);
normal_distribution = (1 / o_ * sqrt(2*pi)) * exp( -( (x - u).^2 / (2 * (o_).^2) ) ) ;



% summon random score
original_sample = randi([1 100],1,sample_number) ;



% bubble sort score
num = numel(original_sample);


for j = 0 : num-1
    for i = 1: num-j-1
        if original_sample(i) > original_sample(i+1)

            temp = original_sample(i);
            original_sample(i) = original_sample(i+1);
            original_sample(i+1) = temp;

            index_temp = original_sample_index(i);
            original_sample_index(i) = original_sample_index(i+1);
            original_sample_index(i+1) = index_temp;
        end
    end
end


% ----------- process 1 --------------
% 隨機生成符合考生數量的常態分布數，依照分數高低直接替換。

example = o_ .* randn(1,sample_number) + u ; % 標準常態
% stats = [mean(example) std(example) var(example)] ;
% disp(stats)

num1 = numel(example);

for j = 0 : num1-1
    for i = 1: num1-j-1
        if example(i) > example(i+1)

            temp = example(i);
            example(i) = example(i+1);
            example(i+1) = temp;

        end
    end
end

draw_temp = example ;

after_process1 = int8(example) ;

for i = 1:sample_number
    result_score(original_sample_index(i)) = after_process1(i) ;
end

% ----------- process 1 --------------


% calculate amount

% process 1
sample_counter1 = zeros(1 , 100) ;

for i = 1:100
    for j = 1:sample_number
        if i == after_process1(j)
            sample_counter1(i) = sample_counter1(i) + 1 ;
        end
    end
end




% draw

figure('position', [200, 100, 1000, 600])

subplot(2,2,1);

sample_counter = zeros(1 , 100) ;

for i = 1:100
    for j = 1:sample_number
        if i == original_sample(j)
            sample_counter(i) = sample_counter(i) + 1 ;
        end
    end
end

bar(sample_counter,'b') ;

title('原樣本分數分布長條圖',['考生數量: ' num2str(sample_number)]);
xlabel('原樣本分數');	
ylabel('數量');	
ytickformat('%.0f');
ylim([0 sample_number/14])



subplot(2,2,2);

hold on

yyaxis left
bar(sample_counter1) ;
title(['調整後樣本分數分布長條圖   (方法一)   \sigma^{2} = ' num2str((o_).^2)],['考生數量: ' num2str(sample_number)]);
xlabel('調整後樣本分數');	
ylabel('數量');	
ylim([0 max(sample_counter1)])



yyaxis right
plot(x , normal_distribution,'r--','LineWidth',2);
ylabel('Normal Distribution');	
ylim([0 max(normal_distribution)])
legend('調整後數量' , '常態分佈線','Location','northeast')


hold off



subplot(2,2,3);

draw_x = linspace(1,sample_number,sample_number) ;
plot(draw_x,original_sample,'b*');

title('原考生成績分布圖');
xlabel('考生');	
ylabel('分數');
grid on ;



subplot(2,2,4);

plot(draw_x,after_process1,'r*');

title('調整後考生成績分布圖')
xlabel('考生');	
ylabel('分數');
grid on ;

