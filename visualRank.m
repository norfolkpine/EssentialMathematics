%Define Function
function [sortIndex, imgs, highest, lowest] = visualRank(filenames,offset,A)

    
    A(A < 0) = 0;   % replace negative values with zero
    [rows, columns] = size(A);  %count rows and columns in matrix

    for i = 1:1:rows        %Count through matrix setting diagonals to zero
        A(i,i) = 0;
        
    end

    % Visualise result
    figure('Name', 'A - Remove negative elements and diagonals')
    im2 = imagesc(A);
    title('A - Remove negative elements and diagonals')
    colorbar        % add color bar to visualisation

    H = normalize(A,2,'norm',1);
       
    J(1:rows,1:columns) = 1/rows;
    d = 0.85;
    Htilde = d*H + (1-d)*J;

    V0 = zeros(1,columns);
    V0(1) = 1;
    V = V0 * Htilde;     %V(1:rows)

    for n = 1:1:49  % produce a matrix 50x1400        
        V(n+1,:) = V(n,:) * Htilde;

    end
    r = V(50,:);
    %Display r vector
    disp(strcat("r Vector: "))
    r
    
   

    [Value1,I] = max(r);  % highest rank [Value, Index]
    [Value2,J] = min(r);  % lowest rank [Value, Index]
    [Value3,sortIndex] = sort(r,'descend');
    
    imgs = "" + fullfile('MPEG7',filenames(sortIndex))

    filenames(I+offset);    % highest ranked filename
    filenames(J+offset);    % lowest ranked filename
    imghigh = "" + fullfile('MPEG7',filenames(I+offset));
    imglow = "" + fullfile('MPEG7',filenames(J+offset));
    
    figure('Name','Highest Ranked Image');
    imshow(imghigh)
    title('Highest Ranked Image')
    highest = imshow(imghigh);
        
    figure('Name','Lowest Ranked Image');
    imshow(imglow)
    title('Lowest Ranked Image') 
    lowest =  imshow(imglow);
    
    %Display highest ranked image filename
    disp(strcat("Highest ranked image: ", imghigh))
    
    %Display lowest ranked image filename
    disp(strcat("Lowest ranked image: ", imglow))
    
end