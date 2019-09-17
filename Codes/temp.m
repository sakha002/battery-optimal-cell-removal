
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
for n=1:11 ,
    cell_overall_cap(n)=SOCEXP_R{n}(end);

end
%%
varname=cell(11,1);
for n=1:11
    name1= ['InstCell',num2str(n)];
    varname{n} = eval(name1);
    name2= ['InstCell',num2str(n),'a'];
    varname2 = eval(name2);
    varname{n} =[varname2;varname{n}];
    
    
end
% Time=[Timea;Time];
