function [mu,mask]=KMeans_Clustering(I,k)
%% check image (inizializzazioni del centro cluster)
ima=double(I);
copy=ima;         % fare una copia
ima=ima(:);       % vettorializzare image
mi=min(ima);      % deal con negativo
ima=ima-mi+1;     % e zero valori

s=length(ima);

%% create image histogram

m=max(ima)+1;

h=zeros(1,m);
hc=zeros(1,m);

for i=1:s
  if(ima(i)>0) h(ima(i))=h(ima(i))+1;
  end;
end
ind=find(h);
hl=length(ind);

%% initiate centroids

mu=(1:k)*m/(k+1);
fprintf('Initiated centroid value = %f\n',mu);

%% start process

while(true)
  
  oldmu=mu;
  % current classification  
 
  for i=1:hl
      c=abs(ind(i)-mu);
      cc=find(c==min(c));
      hc(ind(i))=cc(1);
  end
  
  %recalculation of means  
  
  for i=1:k, 
      a=find(hc==i);
      mu(i)=sum(a.*h(a))/sum(h(a));
  end
  
  if(mu==oldmu) 
      break;
  end;
  
end

%% calculate mask
s=size(copy);
mask=zeros(s);

for i=1:s(1),
for j=1:s(2),
  c=abs(copy(i,j)-mu);
  a=find(c==min(c));  
  mask(i,j)=a(1);
end
end

mu=mu+mi-1;   % recover real range
