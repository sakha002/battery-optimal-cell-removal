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