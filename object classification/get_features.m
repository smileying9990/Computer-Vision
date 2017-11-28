function [features] = get_features(image, x, y, feature_width)
num_points = size(x,1);
features = zeros(num_points, 128);

gaussian = fspecial('Gaussian');
% filter the image first
im = imfilter(image,gaussian);
% get magnitude and direction
[mags, dirs] = imgradient(image);
mags = imfilter(mags, gaussian);
dirs = imfilter(dirs, gaussian);

[m,n] = size(image);
% constants definition
c_size = feature_width/4;
num_bins = 8;
N = c_size * ones(1,c_size);
% threshold for extracting features
threshold = 0.6;
% iterate through each interest point
for ii = 1:num_points
    tmp = zeros(c_size, c_size, num_bins);
    % beginning and ending of row
    s_row = y(ii,1) - 2*c_size;
    e_row = y(ii,1) + 2*c_size - 1;
    % beginning and ending of column
    s_col = x(ii,1) - 2*c_size;
    e_col = x(ii,1) + 2*c_size - 1;
    
    if (s_row >= 1 && e_row <= m && s_col >= 1 && e_col <= n)
        % divide 16*16 window into 4*4 quadrant
        dir_cells=mat2cell(dirs(s_row:e_row,s_col:e_col),N,N);
        mag_cells=mat2cell(mags(s_row:e_row,s_col:e_col),N,N);
        for k=1:c_size
            for l=1:c_size
                for r_id=1:c_size
                    for c_id=1:c_size
                        % calculate for 8 bins respectively
                        if (dir_cells{k,l}(r_id,c_id) >= 0)
                            tmp_id = 1 + floor(dir_cells{k,l}(r_id,c_id)/45);
                        else
                            tmp_id = 4 - floor(dir_cells{k,l}(r_id,c_id)/45);
                        end
                        tmp(k,l,tmp_id)=tmp(k,l,tmp_id)+mag_cells{k,l}(r_id,c_id);
                    end
                end
            end
        end
    end
    feature = reshape(tmp,[1,128]);
    % normalize
    feature = feature ./norm(feature);
    feature = feature .* (feature <= threshold);
    feature = feature ./norm(feature);
    % suggested in literature which can improve performance
    feature = feature.^0.5;
    features(ii,:) = feature;
end
    










