% 
% 
% Time2=cellfun(@(x) [x(1:end -8),x(end-3:end)],Time, 'UniformOutput', false);
% timestamps=datetime(Time2, 'InputFormat', 'eee MMM d HH:mm:ss yyyy');
% 
% R_values=[0.0481,0.091-0.02,0.0442,0.0914-0.020,0.0933,0.0733,0.0828-0.02,0.0971-0.02,0.0781-0.160,0.0490,0.056,0.0571]+0.475;
% R_values2=zeros(11,1);
% % len_chg=8993;
% % len_chg=52020;
% len_chg=74260;
% 
% SoC=zeros(len_chg,11);
% SoC_R=zeros(len_chg,11);
% Isquare=zeros(len_chg,1);
% I=1;
% SOCEXP=cell(11,1);
% exterp_ch=cell(11,1);
% for n=1:11
%       name= ['InstCell',num2str(n)];
%     for t=2:len_chg
%       
%         duration=timestamps(t)-timestamps(t-1);
%         SoC(t,n)=SoC(t-1,n)+varname{n}(t)*hours(duration)*I;
%       % SoC_R(t,n)=SoC_R(t-1,n)+varname{n}(t)*hours(duration)*I-R_values(n)*hours(duration)*I^2;
%         
%     end
%     
%     if varname{n}(t)< 3.45
% %         starttime3=41330;
%            starttime3=60900;
% 
%         res=1/(len_chg-starttime3);
%         x=0:res:1;
%         x2=1:res:5.9;
%         exterp_ch{n}=0;
%         order=3;
%       while  exterp_ch{n}(end) < 3.45
% %         if isequal(n,3)
% %             order=2;
% %         end
%         var2=varname{n}(starttime3:len_chg);
%         fitmodel=polyfit(x',var2,order );
%         exterp_ch{n}=polyval(fitmodel,x2);
%         order=order-1;
%         x2=1:res:4.5;
% %             figure
% %             plot(x3, varname{n}(starttime3:starttime3+length(x3)-1));
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
%  starttime=83390;
% % starttime=52020;
% % endtime=13820;
% 
% % endtime=85210;
% % endtime=42100;
% endtime=125400;
% 
% len_dchg= endtime- starttime+2;
% 
% SoCD=zeros(len_dchg,11);
% SoCD(1,:)=SoC(end,:);
% % SoCD_R=zeros(len_dchg,11);
% % SoCD_R(1,:)=SoC_R(end,:);
% 
% SODEXP=cell(11,1);
% SODEXP_R=cell(11,1);
% exterp_dch=cell(11,1);
% save ('midresults_11cells.mat')

  load ('midresults_11cells.mat')
 starttime=83310;

for n=1:11
    name= ['InstCell',num2str(n)];
    for t=starttime:endtime       
        duration=timestamps(t)-timestamps(t-1);
        SoCD(t-starttime+2,n)=SoCD(t-starttime+1,n)- varname{n}(t)*hours(duration)*I;
      %  SoCD_R(t-starttime+2,n)=SoCD_R(t-starttime+1,n)- varname{n}(t)*hours(duration)*I-R_values(n)*hours(duration)*I^2;
    end

    
    if (varname{n}(t) > 3.01)
        %     starttime2=35070;
       % starttime2=76120;
        starttime2=118700;

        res=1/(endtime-starttime2);
        x=0:res:1;
        x2=1:res:3.1;
        
        
        name= ['InstCell',num2str(n)];
        var2=varname{n}(starttime2:endtime);
        fitmodel=polyfit(x',var2,3 );
        exterp_dch{n}=polyval(fitmodel,x2);
        %     plot(x2, varname{n}(starttime:starttime+length(x2)-1));
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
    
    while SODEXP_R{n}(end) > 0
        SODEXP_R{n}(end)
        
        count=count+1
        
        for t=2: length(SoC(:,n))
            duration=timestamps(t)-timestamps(t-1);
            SODEXP_R{n}(t)=SODEXP_R{n}(t-1)+ varname{n}(t)*hours(duration)*I-R_values2(n)*hours(duration)*I^2;
            
        end
        
        for t=starttime:endtime
            
            duration=timestamps(t)-timestamps(t-1);
            SODEXP_R{n}(t-starttime+length(SoC(:,n))+1)=SODEXP_R{n}(t-starttime+length(SoC(:,n)))- varname{n}(t)*hours(duration)*I-R_values2(n)*hours(duration)*I^2;
        end
        
        if  (varname{n}(endtime)> 3.01)
            
            
            for t=endtime+1:endtime+index
                duration=timestamps(t)-timestamps(t-1);
                SODEXP_R{n}(t-endtime+length(SoC(:,n))+length(SoCD(:,n))-2 )=SODEXP_R{n}(t-endtime+length(SoC(:,n))+length(SoCD(:,n))-3)- exterp_dch{n}(t-endtime)*hours(duration)*I -R_values2(n)*hours(duration)*I^2;
            end
            
        end
        R_values2(n)=R_values2(n)+0.025;
    end
        
    ck=1    
end
ck=1

%%

SOCEXP_comb=cell(11,1);
SOCEXP_R=cell(11,1);

for n=1:11
    SOCEXP_comb{n}=[SoC(:,n); SOCEXP{n}];
    SOCEXP_R{n}=ones(length(SOCEXP_comb{n}),1);
    SOCEXP_R{n}(1)=SOCEXP_comb{n}(1);
    name= ['InstCell',num2str(n)];
         for t=2:length(SOCEXP_comb{n})
    
           duration=timestamps(t)-timestamps(t-1);
           %SoC(t,n)=SoC(t-1,n)+varname{n}{n}(t)*hours(duration)*I;
           SOCEXP_R{n}(t)=SOCEXP_R{n}(t-1)+varname{n}(t)*hours(duration)*I-R_values2(n)*hours(duration)*I^2;
    
        end
    
    
end

%%



SOCEXP_comb=cell(11,1);
SOCEXP_R=cell(11,1);
SOCEXP_RD=cell(11,1);

for n=1:11
    SOCEXP_comb{n}=[SoC(:,n); SOCEXP{n}];
    SOCEXP_R{n}=ones(length(SOCEXP_comb{n}),1);
    SOCEXP_R{n}(1)=SOCEXP_comb{n}(1);
    name= ['InstCell',num2str(n)];
         for t=2:length(SOCEXP_comb{n})
    
           duration=timestamps(t)-timestamps(t-1);
           %SoC(t,n)=SoC(t-1,n)+varname{n}{n}(t)*hours(duration)*I;
           SOCEXP_R{n}(t)=SOCEXP_R{n}(t-1)+varname{n}(t)*hours(duration)*I-R_values2(n)*hours(duration)*I^2;
    
        end
    
    
end










%%
cell_overall_cap=zeros(11,1);
for n=1:11 ,
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
% %     varname{n} = eval(name);
% %     var2=varname{n}(starttime:endtime);
% %     fitmodel=polyfit(x',var2,3 );
% 
% 
%     
%     
%     
% end
