function temp_viewlog(log_filenm, varargin)


DATA = logfile(log_filenm, 'read');

Di = DATA(:,4);
Fi = DATA(:,5);
di = DATA(:,6);
fi = DATA(:,7);
dit = DATA(:,8);
fit = DATA(:,9);
stages = DATA(:,1);
LEARNER = DATA(:,10);


figure; hold on;



plot(Di, 'b-', 'LineWidth',2);
plot(Fi, 'r-', 'LineWidth',2);
plot(di, 'b-');
plot(fi, 'r-');
plot(dit, 'c-');
plot(fit, 'm-');

for l=1:max(LEARNER)
    str = learnerstr(l);
    plot(find(LEARNER==l), Di(LEARNER==l), str);
    plot(find(LEARNER==l), Fi(LEARNER==l), str);
end

legend('Overall Detection Rate D_i', 'Overall False Positive Rate F_i', 'Stage Detection Rate d_i', 'Stage False Positive Rate f_i', 'Training Data d_i', 'Training Data f_i');
xlabel('# of Weak Learners');
ylabel('Detection Rate / False Positive Rate');
title('Cascade Learning Progress');
grid on;
ylim([-.1 1]);
xlim([1 size(DATA,1)]);

stagelist = unique(stages);
for i = stagelist'
    first = find(stages == i, 1, 'first');
    last = find(stages ==i, 1, 'last');
    fill([first last last first],[-.1 -.1 0 0], 2*[.3 .2 .5]);
    text(first+1, -.05,['stage ' num2str(i)]);
end




%% ================ SUPPORTING FUNCTIONS ================== 

function str = learnerstr(l)

switch l
    case 1
            str = 'ko';
    case 2
            str = 'k*';
    case 3
            str = 'k.';
    case 4
            str = 'k+';
    case 5
            str = 'ks';
    case 6
            str = 'kd';
    case 7
            str = 'k^';
    case 8
            str = 'kx';
    case 9
            str = 'kp';
    otherwise
            str = 'kh';
end





