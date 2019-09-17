figure
hold on
SOCCD=[SoC;SoCD];

for n=1:12
timestamps_modified2=[timestamps(1:length(SoC(:,n)));timestamps(starttime:endtime);timestamps(endtime+1:length(SODEXP{n, 1})-1)];
timestamps_modified=[timestamps(1:length(SoC(:,n)));timestamps(starttime:endtime+1)];
timestamps_modified3=[timestamps(starttime:endtime);timestamps(endtime+1:length(SODEXP{n, 1})-1)];


plot(timestamps_modified2,SODEXP_R{n})



end
%%

figure
hold on

for n=1:12
    timestamps_modified2=[timestamps(1:length(SoC(:,n)));timestamps(starttime:endtime);timestamps(endtime+1:length(SODEXP{n, 1})-1)];
    timestamps_modified3=[timestamps(starttime:endtime);timestamps(endtime+1:length(SODEXP{n, 1})-1)];
    
   
    
    name= ['InstCell',num2str(n)];
    varname = eval(name);
    
   if varname(endtime)> 3.01 
        starttime2=76120;

        res=1/(endtime-starttime2);
        x=0:res:1;
        x2=1:res:2.1;
        

        name= ['InstCell',num2str(n)];
        varname = eval(name);
        var2=varname(starttime2:endtime);
        fitmodel=polyfit(x',var2,3 );
        exterp=polyval(fitmodel,x2);
        index=find( exterp<3,1);

   
         plot(timestamps_modified3, varname(starttime:endtime+index-1));
    %     hold on
    %     plot(x2,exterp)
    
    timestamps_modified4=[timestamps(endtime+1:length(SODEXP{n, 1})-1)];
    plot(timestamps_modified4,exterp(1:index-1))
    else
            plot(timestamps_modified3, varname(starttime:endtime));
    
    end
    
    
end

%%

figure
hold on

for n=1:11
    timestamps_modified2=[timestamps(1:length(SoC(:,n)));timestamps(starttime:endtime);timestamps(endtime+1:length(SODEXP{n, 1})-1)];
    timestamps_modified3=[timestamps(starttime:endtime);timestamps(endtime+1:length(SODEXP{n, 1})-1)];
    
    timestamps_modified2=[timestamps(1:length(SoC(:,n)));timestamps(starttime:endtime);timestamps(endtime+1:endtime+ length(SODEXP{n, 1}) - length(SoC(:,n))-  length(SoCD(:,n))+1)];

    
%     name= ['InstCell',num2str(n)];
%     varname = eval(name);
%     
%    if varname(endtime)> 3.01 
%         starttime2=76120;
% 
%         res=1/(endtime-starttime2);
%         x=0:res:1;
%         x2=1:res:2.1;
%         
% 
%         name= ['InstCell',num2str(n)];
%         varname = eval(name);
%         var2=varname(starttime2:endtime);
%         fitmodel=polyfit(x',var2,3 );
%         exterp=polyval(fitmodel,x2);
%         index=find( exterp<3,1);
% 
%    
%          plot(timestamps_modified3, varname(starttime:endtime+index-1));
%     %     hold on
%     %     plot(x2,exterp)
%     
%     timestamps_modified4=[timestamps(endtime+1:length(SODEXP{n, 1})-1)];
%     plot(timestamps_modified4,exterp(1:index-1))
%     else
%             plot(timestamps_modified3, varname(starttime:endtime));
%     
%     end
figure(3)
hold on
%    subplot(2,1,1)
    plot(timestamps_modified2,SODEXP_R{n, 1} )
%figure(1)
%hold on
%subplot(2,1,2)
% plot(timestamps_modified2,SODEXP_R{n, 1} )
 
    
end

%%
for n=1:12
      name= ['InstCell',num2str(n)];
     varname = eval(name);
    
%        SOCEXP{n, 1}=[SoC(:,n);SOCEXP{n, 1}];
        timestamps_modified5=[timestamps(1:length(SoC(:,n)));timestamps(length(SoC(:,n))+1:length(SoC(:,n))+length(SOCEXP{n, 1}))];
        
            starttime3=41330;
            
            res=1/(len_chg-starttime3);
            x=0:res:1;
            x2=1:res:3.3;
            
    
            %     figure
            %     plot(x2, varname(starttime2:starttime2+length(x2)-1));
            %     hold on
            %     plot(x2,exterp)
            
            
            plot(timestamps_modified5, varname(1:length(SoC(:,n))+length(SOCEXP{n, 1})) );
            hold on
            %     plot(x2,exterp)
            index=find( exterp_ch{n}>3.45,1);
            
            
            timestamps_modified4=[timestamps(length(SoC(:,n))+1 :length(SoC(:,n))+ length(SOCEXP{n, 1}) )];
            plot(timestamps_modified4,exterp_ch{n}(1:index-1))
            
        
            
%             plot(timestamps_modified5, varname(1:length(SOCEXP{n, 1})-1) );
            
        
   
end



%%

hold on
for n=1:11
    timestamps_modified2=timestamps(1:length(SODEXP{n, 1})+10000);
    timestamps_modified3=timestamps_modified2- days(2.528);
    plot(timestamps_modified3,varname{n, 1}(1:length(SODEXP{n, 1})+10000  ) )

    
    
end


%%
Cell_new_cap=Cell_capacity_raw;
Pack_cap=zeros(12,1);
for n=1:12
    
   [min_cap,index]= min(Cell_new_cap);
   Pack_cap(n)=(12-n+1)*min_cap;
   
   Cell_new_cap(index)=[];
   
    
end

% plot(Pack_cap)

%%

% figure
for n=1:11
    
timestamps_modified1=timestamps(1:74260);
timestamps_modified2 = timestamps(83304:125400 +5000);
timestamps_modified3=timestamps_modified2 -minutes(31);
timestamp_modified4=[timestamps_modified1;timestamps_modified3];
timestamp_modified5=timestamp_modified4-days(2.528);
tempvar=varname{n};
tempvar2=tempvar(1:74260);
tempvar3=tempvar(83304:125400+5000);
tempvar4=[tempvar2;tempvar3];
plot(timestamp_modified5, tempvar4);
hold on

    
end



%% plot the resistance values and cell capacities in order
temp=R_values2;
R_val_ordered=zeros(12,1);
Cell_Index=zeros(12,1);
Cell_capacity_raw=zeros(12,1);
cell_capacity_order=zeros(12,1);
cell_capacity_order_index=zeros(12,1);
for n=1:12
    Cell_capacity_raw(n)=SOCEXP_R{n}(end);
   [ R_val_ordered(n),Cell_Index(n)]=max(temp);
%    if ~isempty(temp)
   temp(Cell_Index(n))=0;  
%    end
end
temp2=Cell_capacity_raw;
R_order=zeros(12,1);
for n=1:12

[ cell_capacity_order(n),cell_capacity_order_index(n)]=min(temp2);
   temp2(cell_capacity_order_index(n))=100; 
   R_order(n)=R_values2(cell_capacity_order_index(n));
end

R3=R_order+3.17;

cell_AVEN_order=(cell_capacity_order ./R3)*3.17;






