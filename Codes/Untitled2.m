for n=3:12
    
       SOCEXP2{n, 1}=[SoC(:,n);SOCEXP{n, 1}];
        timestamps_modified5=[timestamps(1:length(SoC(:,n)));timestamps(length(SoC(:,n))+1:length(SOCEXP2{n, 1})-1)];
        
        if varname(len_chg)< 3.45
            starttime3=41330;
            
            res=1/(len_chg-starttime3);
            x=0:res:1;
            x2=1:res:3.3;
            
            name= ['InstCell',num2str(n)];
            varname = eval(name);
            var2=varname(starttime3:len_chg);
            fitmodel=polyfit(x',var2,3 );
            exterp=polyval(fitmodel,x2);
            %     figure
            %     plot(x2, varname(starttime2:starttime2+length(x2)-1));
            %     hold on
            %     plot(x2,exterp)
            
            
            plot(timestamps_modified5, varname(1:length(SOCEXP2{n, 1})-1) );
            hold on
            %     plot(x2,exterp)
            index=find( exterp>3.45,1);
            
            timestamps_modified4=[timestamps(length(SoC(:,n))+1 : length(SOCEXP2{n, 1})-1 )];
            plot(timestamps_modified4,exterp(1:index-1))
            
        else
            
            plot(timestamps_modified5, varname(1:length(SOCEXP2{n, 1})-1) );
            
        end
   
end