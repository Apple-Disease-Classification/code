function  X1_image = Local_Binary_Pattern(Image)

% Restituisce un invariante di rotazione Local Binary Pattern (uniform patterns)  per l'immagine X


% la dimensione dell'immagine X deve essere di almeno 3x3 pixel

q1 = (1/sqrt(2))^2;
q2 = (1-1/sqrt(2))*(1/sqrt(2));

[siy six] = size(Image);

X_im = zeros(siy+2,six+2);
X_im(2:siy+1,2:six+1) = Image;

Xi2_im = zeros(siy+2,six+2);
Xi4_im= zeros(siy+2,six+2);
Xi6_im = zeros(siy+2,six+2);
Xi8_im = zeros(siy+2,six+2);
p_1 = zeros(siy+2,six+2);
p_2 = zeros(siy+2,six+2);
p_3 = zeros(siy+2,six+2);
p_4 = zeros(siy+2,six+2);
p_5 = zeros(siy+2,six+2);
p_6 = zeros(siy+2,six+2);
p_7 = zeros(siy+2,six+2);
p_8 = zeros(siy+2,six+2);
p_9 = zeros(siy+2,six+2);

p_1(3:siy+2,3:six+2) = Image;
p_2(3:siy+2,2:six+1) = q2*double(Image);
p_3(3:siy+2,1:six) = Image;

p_4(2:siy+1,3:six+2) = q2*double(Image);
p_5(2:siy+1,2:six+1) = (1-1/sqrt(2))^2*double(Image);
p_6(2:siy+1,1:six) = q2*double(Image);

p_7(1:siy,3:six+2) = Image;
p_8(1:siy,2:six+1) = q2*double(Image);
p_9(1:siy,1:six) = Image;

Xi1_im = q1*p_1+ p_2+p_4 + p_5 + 0.000001; %Xi1_im to the right and down from X
Xi2_im(3:siy+2,2:six+1) = Image;
Xi3_im = q1*p_3 + p_2 + p_6 + p_5 + 0.000001;
Xi4_im(2:siy+1,1:six) = Image;
Xi5_im = q1*p_9 + p_8 + p_6 + p_5 + 0.000001;
Xi6_im(1:siy,2:six+1) = Image;
Xi7_im = q1*p_7 + p_8 + p_4 + p_5 + 0.000001;
Xi8_im(2:siy+1,3:six+2) = Image;

X_im = (Xi4_im>=X_im)+2*(Xi5_im>=X_im)+4*(Xi6_im>=X_im)+8*(Xi7_im>=X_im)+16*(Xi8_im>=X_im)+32*(Xi1_im>=X_im)+64*(Xi2_im>=X_im)+128*(Xi3_im>=X_im);

X1_image = X_im(3:siy,3:six);
end
