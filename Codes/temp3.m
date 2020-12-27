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

