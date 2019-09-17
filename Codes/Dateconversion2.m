

Time2=cellfun(@(x) [x(1:end -8),x(end-3:end)],Time, 'UniformOutput', false);
timestamps=datetime(Time2, 'InputFormat', 'eee MMM d HH:mm:ss yyyy');

R_values=[0.0481,0.091-0.02,0.0442,0.0914-0.020,0.0933,0.0733,0.0828-0.02,0.0971-0.02,0.0781-0.160,0.0490,0.056,0.0571]+0.475;
%len_chg=8993;
len_chg=52020;

SoC2=zeros(len_chg,1);
SoC_R2=zeros(len_chg,1);

I=1;
% for n=1:12
n=1;
      name= InstCell2;
      %varname = eval(name);
    for t=2:len_chg
      
        duration=timestamps(t)-timestamps(t-1);
        SoC2(t,n)=SoC2(t-1,n)+name(t)*hours(duration)*I;
        SoC_R2(t,n)=SoC_R2(t-1,n)+name(t)*hours(duration)*I-R_values(n)*hours(duration)*I^2;
   
    end
% end
 
starttime=len_chg;
%endtime=13820;

endtime=85130;
len_dchg= endtime- starttime+2;

SoCD2=zeros(len_dchg,1);
SoCD2(1,:)=SoC2(end,:);
SoCD_R2=zeros(len_dchg,1);
SoCD_R2(1,:)=SoC_R2(end,:);

% for n=1:12
    name= InstCell2; %,num2str(n)];
    %varname = eval(name);
    for t=starttime:endtime
        
        
        duration=timestamps(t)-timestamps(t-1);
        SoCD2(t-starttime+2,n)=SoCD2(t-starttime+1,n)- name(t)*hours(duration)*I;
        SoCD_R2(t-starttime+2,n)=SoCD_R2(t-starttime+1,n)- name(t)*hours(duration)*I-R_values(n)*hours(duration)*I^2;
    end
% end


