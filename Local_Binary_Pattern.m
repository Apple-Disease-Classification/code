function  X1_image = Local_Binary_Pattern(Image)

% la dimensione dell'immagine X deve essere di almeno 3x3 pixel

q1 = (1/sqrt(2))^2;
q2 = (1-1/sqrt(2))*(1/sqrt(2));

[siy six] = size(Image);

%%xii(5*5) & pi(5*5) are a variable to generate a matrix of zeros to process an image

X_im = zeros(siy+2,six+2);

% center pixel
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

% neighboring pixels  5*5 
p_1(3:siy+2,3:six+2) = Image;
p_2(3:siy+2,2:six+1) = q2*double(Image);
p_3(3:siy+2,1:six) = Image;

p_4(2:siy+1,3:six+2) = q2*double(Image);
p_5(2:siy+1,2:six+1) = (1-1/sqrt(2))^2*double(Image);
p_6(2:siy+1,1:six) = q2*double(Image);

p_7(1:siy,3:six+2) = Image;
p_8(1:siy,2:six+1) = q2*double(Image);
p_9(1:siy,1:six) = Image;

Xi1_im = q1*p_1+ p_2+p_4 + p_5 + 0.000001;     %Xi1 is the right-down(3*3) side from the pixel 
Xi2_im(3:siy+2,2:six+1) = Image;               %Xi2 is the center-down(3*3) side from the pixel
Xi3_im = q1*p_3 + p_2 + p_6 + p_5 + 0.000001;  %Xi3 is the left-down(3*3) side from the pixel 
Xi4_im(2:siy+1,1:six) = Image;                 %Xi4 is the center-left(3*3) side from the pixel 
Xi5_im = q1*p_9 + p_8 + p_6 + p_5 + 0.000001;  %Xi5 is the right-up(3*3) side from the pixel
Xi6_im(1:siy,2:six+1) = Image;                 %Xi6 is the center-up(3*3) side from the pixel 
Xi7_im = q1*p_7 + p_8 + p_4 + p_5 + 0.000001;  %Xi7 to the left-up(3*3) side from the pixel 
Xi8_im(2:siy+1,3:six+2) = Image;

X_im = (Xi4_im>=X_im)+2*(Xi5_im>=X_im)+4*(Xi6_im>=X_im)+8*(Xi7_im>=X_im)+16*(Xi8_im>=X_im)+32*(Xi1_im>=X_im)+64*(Xi2_im>=X_im)+128*(Xi3_im>=X_im);

X1_image = X_im(3:siy,3:six);
end
