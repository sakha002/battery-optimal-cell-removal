close all
rv=[0.025110419
0.054469977
0.022657374
0.052259393
0.05138687
0.04187172
0.050652106
0.061906724
0.047293095
0.026953723
0.031934545
0.033273381
];
rv=[0.048095238
0.091428571
0.044285714
0.091428571
0.093333333
0.073333333
0.082857143
0.097142857
0.078095238
0.049047619
0.056190476
0.057142857
]*1
ms=[];
startt=8;
mv=ones(12,1)*0.001;
v_min=3.0;
v_max=3.45;
maxc=[];
bestf=[];
for cellnum=1:12
    load('C:\Users\zataylor\Dropbox\cellremoval2.mat')
    time = t_total(startt:1:5.2*10^4)/60/60; %time in seconds
    i_meas= -i_total(startt:1:5.2*10^4);
    v_meas = v_total(startt:1:5.2*10^4,cellnum); %measured voltage in volts
          
    
    bestm=0.001;
    mini=inf;
    for m=0.0001:0.0001:.04
        v_oc=zeros(1,length(v_meas));
        p_in=zeros(1,length(v_meas));
        soc=zeros(1,length(v_meas));

        for t=1:length(v_meas)
            
            v_oc(t) = v_meas(t) - i_meas(t)*rv(cellnum);
            if (v_oc(t) <= v_min)
                v_oc(t) = v_min;
            elseif (v_oc(t) >= v_max)
                v_oc(t) = v_max;
            end
            
            if (v_meas(t) <= v_min)
                v_meas(t) = v_min;
            elseif (v_meas(t) >= v_max)
                v_meas(t) = v_max;
            end

        end

        for t=1:length(v_meas)
            p_in(t) = i_meas(t)*v_oc(t);
        end

        for t=2:length(v_meas)      
            if (v_oc(t)<v_min)
                soc(t)=0;
            else
                soc(t) = soc(t-1)+p_in(t-1)*(time(t)-time(t-1));
            end
        end    

        fitLine=[];
        for i=1:length(soc)
            fitLine(i)=v_min+m*soc(i);
        end  

        r=sqrt(mean((v_oc-fitLine).^2));
        if (r<mini)
            mini=r;
            bestm=m;
            bestf=fitLine;
        end
    end
    ms=[ms bestm];
    mv(cellnum)=bestm
    
    figure
    subplot(2,1,1)
    plot(soc,v_oc,'x')
    hold on
    ty=3:0.01:3.45;
    plot((ty-v_min)/bestm,ty)
    subplot(2,1,2)
    plot(soc,v_oc,'x')
    hold on
        plot(soc,bestf,'o')
%    plot(fitLine)
 %   hold on
  %  plot(v_oc)
    maxc=[maxc (3.45-3.00)/bestm]
   max(bestf)
end  
sum(maxc)
12*min(maxc)
% *
% v_meas = v_total(startt:1:length(i_total),:); 
% 
% C1=zeros(1,length(time));
% C2=zeros(1,length(time));
% C3=zeros(1,length(time));
% C1_calibrations=[];
% C2_calibrations=[];
% C3_calibrations=[];
% calibration_points=[];
% 
% for t=2:length(time)
%     C1(t) = sum(SoC_est1(:,t));
%     %C2(t) = sum(SoC_est2(:,t));
%     temp=SoC_est2(:,t);
% %    C2(t) = 12*min(temp(temp>0));
%      C2(t) = 12*min(temp);
%     if (min(v_meas(t,:))<v_min)
%         if C3(t-1)>0.01
%             bms_c=[bms_c C3(t-1)];
%         end
%         C3(t)=0;
%         
%     elseif (max(v_meas(t,:))>v_max)
%         C3(t)=bms_full;
%     else
%         C3(t)=C3(t-1)+i_meas(t-1)*sum(v_meas(t-1,:))*(time(t)-time(t-1));
%     end
%     if ((min(v_meas(t,:))<=3) && (min(v_meas(t-1,:))>3)) 
%         calibration_points=[calibration_points time(t)];    
%         C1_calibrations=[C1_calibrations C1(t)];        
%         C2_calibrations=[C2_calibrations abs(C2(t))];        
%     end
% end