
% 
% Time2=cellfun(@(x) [x(1:end -8),x(end-3:end)],Time, 'UniformOutput', false);
% timestamps=datetime(Time2, 'InputFormat', 'eee MMM d HH:mm:ss yyyy');
% 
% R_values=[0.0481,0.091-0.02,0.0442,0.0914-0.020,0.0933,0.0733,0.0828-0.02,0.0971-0.02,0.0781-0.160,0.0490,0.056,0.0571]+0.475;
% R_values2=zeros(12,1);
% % len_chg=8993;
% len_chg=52080;
% % len_chg=74140;
% 
% SoC=zeros(len_chg,12);
% SoC_R=zeros(len_chg,12);
% Isquare=zeros(len_chg,1);
% I=1;
% SOCEXP=cell(12,1);
% exterp_ch=cell(12,1);
% for n=1:12
%       name= ['InstCell',num2str(n)];
%       varname = eval(name);
%     for t=2:len_chg
%       
%         duration=timestamps(t)-timestamps(t-1);
%         SoC(t,n)=SoC(t-1,n)+varname(t)*hours(duration)*I;
%       % SoC_R(t,n)=SoC_R(t-1,n)+varname(t)*hours(duration)*I-R_values(n)*hours(duration)*I^2;
%         
%     end
%     
%     if varname(t)< 3.45
%         starttime3=41330;
%         
%         res=1/(len_chg-starttime3);
%         x=0:res:1;
%         x2=1:res:5.3;
%         exterp_ch{n}=0;
%         order=3;
%       while  exterp_ch{n}(end) < 3.45
%         if varname(t)< 3.4
%             order=2;
%         end
%         var2=varname(starttime3:len_chg);
%         fitmodel=polyfit(x',var2,order );
%         exterp_ch{n}=polyval(fitmodel,x2);
%         order=order-1;
%         x2=1:res:4.3;
% %             figure
% %             plot(x3, varname(starttime3:starttime3+length(x2)-1));
% %             hold on
% %             plot(x2,exterp)
%       end
%         index=find( exterp_ch{n}>3.45,1);
%         SOCEXP{n}=zeros(index,1);
%         SOCEXP{n}(1)=SoC(end,n);
%         
%         for t=len_chg+2:len_chg+index
%             duration=timestamps(t)-timestamps(t-1);
%             SOCEXP{n}(t-len_chg)=SOCEXP{n}(t-len_chg-1)+ exterp_ch{n}(t-len_chg-1)*hours(duration)*I;
% %             SODEXP_R{n}(t-endtime)=SODEXP_R{n}(t-endtime-1)- exterp(t-endtime)*hours(duration)*I -R_values(n)*hours(duration)*I^2;
%         end
%         SOCEXP{n}(1)=[];
%     end
%     
%      
%   ck=1;
%   
% end
% 
% duration=timestamps(len_chg)-timestamps(1);
% Isquaresum=hours(duration)*I^2;
% 
% % starttime=2;
% starttime=52090;
% % endtime=13820;
% 
% endtime=85220;
% % endtime=42100;
% 
% len_dchg= endtime- starttime+2;
% 
% SoCD=zeros(len_dchg,12);
% SoCD(1,:)=SoC(end,:);
% % SoCD_R=zeros(len_dchg,12);
% % SoCD_R(1,:)=SoC_R(end,:);
% 
% SODEXP=cell(12,1);
% SODEXP_R=cell(12,1);
% exterp_dch=cell(12,1);
% save ('midresults12cell_a.mat')

  load ('midresults12cell_a.mat')

for n=1:12
    name= ['InstCell',num2str(n)];
    varname = eval(name);
    for t=starttime:endtime       
        duration=timestamps(t)-timestamps(t-1);
        SoCD(t-starttime+2,n)=SoCD(t-starttime+1,n)- varname(t)*hours(duration)*I;
      %  SoCD_R(t-starttime+2,n)=SoCD_R(t-starttime+1,n)- varname(t)*hours(duration)*I-R_values(n)*hours(duration)*I^2;
    end

    
    if (varname(t) > 3.01)
        %     starttime2=35070;
        starttime2=76120;
        order=3;
        if varname(t) > 3.06
            order=2;
        end
        res=1/(endtime-starttime2);
        x=0:res:1;
        x2=1:res:4.1;
        
        
        name= ['InstCell',num2str(n)];
        varname = eval(name);
        var2=varname(starttime2:endtime);
        fitmodel=polyfit(x',var2,order );
        exterp_dch{n}=polyval(fitmodel,x2);
        %     plot(x2, varname(starttime:starttime+length(x2)-1));
        %     hold on
        %     plot(x2,exterp)
        index=find( exterp_dch{n}<3,1);
        SODEXP{n}=zeros(index,1);
        SODEXP{n}(1)=SoCD(end,n);
        %SODEXP_R{n}=zeros(index,1);
        %SODEXP_R{n}(1)=SoCD_R(end,n);
        for t=endtime+2:endtime+index
            duration=timestamps(t)-timestamps(t-1);
            SODEXP{n}(t-endtime)=SODEXP{n}(t-endtime-1)- exterp_dch{n}(t-endtime-1)*hours(duration)*I;
            %   SODEXP_R{n}(t-endtime)=SODEXP_R{n}(t-endtime-1)- exterp(t-endtime)*hours(duration)*I -R_values(n)*hours(duration)*I^2;
        end
        
        duration2=timestamps(t)-timestamps(starttime);
        
        Isquaresum2=0;
        Isquaresum2=hours(duration2)*I^2;
        
        SODEXP{n}=[SoC(1:end-1,n);SoCD(1 :end-1,n);SODEXP{n}];
    else
        duration2=timestamps(t)-timestamps(starttime);
        Isquaresum2=hours(duration2)*I^2;
        SODEXP{n}=[SoC(1:end-1,n);SoCD(1 :end,n)];
        
        
        
    end
    
    
    SODEXP_R{n}=ones(length(SODEXP{n}),1);
    SODEXP_R{n}(1)=SODEXP{n}(1);
    count=0;
    R_values2(n)= (SODEXP{n}(end))/ (Isquaresum+Isquaresum2);
    epsilon=0.001;
    while SODEXP_R{n}(end) > epsilon
        SODEXP_R{n}(end)
        
        count=count+1
        
        for t=2: length(SoC(:,n))
            duration=timestamps(t)-timestamps(t-1);
            SODEXP_R{n}(t)=SODEXP_R{n}(t-1)+ varname(t)*hours(duration)*I-R_values2(n)*hours(duration)*I^2;
            
        end
        
        for t=starttime:endtime
            
            duration=timestamps(t)-timestamps(t-1);
            SODEXP_R{n}(t-starttime+length(SoC(:,n))+1)=SODEXP_R{n}(t-starttime+length(SoC(:,n)))- varname(t)*hours(duration)*I-R_values2(n)*hours(duration)*I^2;
        end
        
        if  (varname(endtime)> 3.01)
            
            
            for t=endtime+1:endtime+index
                duration=timestamps(t)-timestamps(t-1);
                SODEXP_R{n}(t-endtime+length(SoC(:,n))+length(SoCD(:,n))-2 )=SODEXP_R{n}(t-endtime+length(SoC(:,n))+length(SoCD(:,n))-3)- exterp_dch{n}(t-endtime)*hours(duration)*I -R_values2(n)*hours(duration)*I^2;
            end
            
        end
        R_values2(n)=R_values2(n)+0.02;
    end
        
    ck=1    
end
ck=1

%%

SOCEXP_comb=cell(12,1);
SOCEXP_R=cell(12,1);

for n=1:12
    SOCEXP_comb{n}=[SoC(:,n); SOCEXP{n}];
    SOCEXP_R{n}=ones(length(SOCEXP_comb{n}),1);
    SOCEXP_R{n}(1)=SOCEXP_comb{n}(1);
    name= ['InstCell',num2str(n)];
    varname = eval(name);
         for t=2:length(SOCEXP_comb{n})
    
           duration=timestamps(t)-timestamps(t-1);
           %SoC(t,n)=SoC(t-1,n)+varname(t)*hours(duration)*I;
           SOCEXP_R{n}(t)=SOCEXP_R{n}(t-1)+varname(t)*hours(duration)*I-R_values2(n)*hours(duration)*I^2;
    
        end
    
    
end

%%

cell_overall_cap=zeros(12,1);
for n=1:12 ,
    cell_overall_cap(n)=SOCEXP_R{n}(end);

end


%%
% starttime=35070;
% I=1
%starttime=38070;
% endtime=42100;
% res=1/(endtime-starttime);
% x=0:res:1;
% x2=1:res:2.1;

% 
% for n=3:3
%     
% %     name= ['InstCell',num2str(n)];
% %     varname = eval(name);
% %     var2=varname(starttime:endtime);
% %     fitmodel=polyfit(x',var2,3 );
% 
% 
%     
%     
%     
% end
