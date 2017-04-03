function [indexes] = houghparallel(thetha,threshold)

indexes = [;];
for i=1:length(thetha)
    for p=(i+1):length(thetha)
      if (thetha(p) < (thetha(i)+threshold) && thetha(p) > (thetha(i)-threshold)) && p~=i
          indexes = [indexes; i p];
      end
    end
end

end