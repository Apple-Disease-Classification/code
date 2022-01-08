function f = Color_Coherence_Vector(image)

Image_processing = image;
[m,n,t] = size(Image_processing);

%%Image Based Rendering
Image_processing_1(:,n,:) = Image_processing(:,1,:);
Image_processing_2(:,2:n,:) = Image_processing(:,1:n-1,:);
Image_processing_3(m,:,:) = Image_processing(1,:,:);
Image_processing_4(2:m,:,:) = Image_processing(1:m-1,:,:);

%Convert from uint8 to double
Image_processing = double(Image_processing);
Image_processing_1 = double(Image_processing_1);
Image_processing_2 = double(Image_processing_2);
Image_processing_3 = double(Image_processing_3);
Image_processing_4 = double(Image_processing_4);

%Average correlation for each channels for image
ImageBR = (Image_processing_1+Image_processing_2+Image_processing_3+Image_processing_4+Image_processing) / 5;

Rosso = [255,0,0];
Verde = [0,255,0];
Blu = [0,0,255];
RossoVerde = Rosso + Verde;
RossoBlu = Rosso + Blu;
VerdeBlu = Verde + Blu;
Bianco = Rosso + Verde +Blu;
Nero = Bianco * 0;

%% Matrix of combination RGB colors 
Colore = [Rosso;Verde;Blu;RossoVerde;RossoBlu;VerdeBlu;Bianco;Nero];

%In order to remove the minute variations between the neighboring pixels
%% the image is operated by the blurring and discretization steps

for p=1:m
    for q=1:n
        Image_pq = [ImageBR(p,q,1),ImageBR(p,q,2),ImageBR(p,q,3)];
        distanza_1 = norm(Rosso-Image_pq);  %Euclidean norm for Compute the distance between pixels image
        distanza_2 = norm(Verde-Image_pq);
        distanza_3 = norm(Blu-Image_pq);
        distanza_4 = norm(RossoVerde-Image_pq);
        distanza_5 = norm(RossoBlu-Image_pq);
        distanza_6 = norm(VerdeBlu-Image_pq);
        distanza_7 = norm(Bianco-Image_pq);
        distanza_8 = norm(Nero-Image_pq);
        Distanza = [distanza_1,distanza_2,distanza_3,distanza_4,distanza_5,distanza_6,distanza_7,distanza_8];
        distanza = min(Distanza);  %the minimum is mean the size(Color) : 8
        [m1,n1] = find(Distanza == distanza);
        Imagec(p,q,:) = Colore(n1,:);
    end
end

MaskMat = zeros(m,n);

k = 1;
for p=1:m
    for q=1:n
        if MaskMat(p,q) == 0
            MaskMat(p,q) = k;
            k = k + 1;
        end
        % 1
        if p-1>0 && p-1<m && q-1>0 && q-1<n
            if Imagec(p-1,q-1,:) == Imagec(p,q,:)
                if MaskMat(p-1,q-1) == 0
                    MaskMat(p-1,q-1) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p-1,q-1),MaskMat(p,q));
                end
            end
        end
        % 2
        if p-1>0 && p-1<m && q>0 && q<n
            if Imagec(p-1,q,:) == Imagec(p,q,:)
                if MaskMat(p-1,q) == 0
                    MaskMat(p-1,q) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p-1,q),MaskMat(p,q));
                end
            end
        end
        % 3
        if p-1>0 && p-1<m && q+1>0 && q+1<n
            if Imagec(p-1,q+1,:) == Imagec(p,q,:)
                if MaskMat(p-1,q+1) == 0
                    MaskMat(p-1,q+1) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p-1,q+1),MaskMat(p,q));
                end
            end
        end
        % 4
        if p>0 && p<m && q-1>0 && q-1<n
            if Imagec(p,q-1,:) == Imagec(p,q,:)
                if MaskMat(p,q-1) == 0
                    MaskMat(p,q-1) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p,q-1),MaskMat(p,q));
                end
            end
        end
        % 5
        if p>0 && p<m && q+1>0 && q+1<n
            if Imagec(p,q+1,:) == Imagec(p,q,:)
                if MaskMat(p,q+1) == 0
                    MaskMat(p,q+1) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p,q+1),MaskMat(p,q));
                end
            end
        end
        % 6
        if p+1>0 && p+1<m && q-1>0 && q-1<n
            if Imagec(p+1,q-1,:) == Imagec(p,q,:)
                if MaskMat(p+1,q-1) == 0
                    MaskMat(p+1,q-1) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p+1,q-1),MaskMat(p,q));
                end
            end
        end
        % 7
        if p+1>0 && p+1<m && q>0 && q<n
            if Imagec(p+1,q,:) == Imagec(p,q,:)
                if MaskMat(p+1,q) == 0
                    MaskMat(p+1,q) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p+1,q),MaskMat(p,q));
                end
            end
        end
        % 8
        if p+1>0 && p+1<m && q+1>0 && q+1<n
            if Imagec(p+1,q+1,:) == Imagec(p,q,:)
                if MaskMat(p+1,q+1) == 0
                    MaskMat(p+1,q+1) = MaskMat(p,q);
                else
                    MaskMat(p,q) = min(MaskMat(p+1,q+1),MaskMat(p,q));
                end
            end
        end
    end
end

%% The connected components are further classified as either coherent or incoherent regions.

RossoV = [];
VerdeV = [];
BluV = [];
RossoVerdeV = [];
RossoBluV = [];
VerdeBluV = [];
BiancoV = [];
NeroV = [];
flag = 0;
for kc=1:k
    flag = 0;
    for p=1:m
        for q=1:n
            if MaskMat(p,q)==kc
                Colore = [Imagec(p,q,1),Imagec(p,q,2),Imagec(p,q,3)];
                if Rosso == Colore
                    RossoV = [RossoV, kc];
                elseif Verde == Colore
                    VerdeV = [VerdeV, kc];
                elseif Blu == Colore
                    BluV = [BluV, kc];
                elseif RossoVerde == Colore
                    RossoVerdeV = [RossoVerdeV, kc];
                elseif RossoBlu == Colore
                    RossoBluV = [RossoBluV, kc];
                elseif VerdeBlu == Colore
                    VerdeBluV = [VerdeBluV, kc];
                elseif Bianco == Colore
                    BiancoV = [BiancoV, kc];
                elseif Nero == Colore
                    NeroV = [NeroV, kc];
                end
                flag = 1;
                break;
            end
        end
        if flag == 1
            break;
        end
    end
end

%% For each color will get two values (C & I)(Coherent and Incoherent)
%% C is the number of coherent pixels.
%% I is the number of incoherent pixels.

Kv = zeros(1,k-1);
for p=1:m
    for q=1:n
        Kv(MaskMat(p,q)) = Kv(MaskMat(p,q)) +1;
    end
end

threshold = (m*n) / 15;

%% for red color(c & i)
RossoC = 0;
RossoI = 0;
[m1,n1] = size(RossoV);
for p=1:n1
    if Kv(RossoV(p)) > threshold
        RossoC = RossoC + Kv(RossoV(p));
    else
        RossoI = RossoI + Kv(RossoV(p));
    end
end

%% for green color(c & i)
VerdeC = 0;
VerdeI = 0;
[m1,n1] = size(VerdeV);
for p=1:n1
    if Kv(VerdeV(p)) > threshold
        VerdeC = VerdeC + Kv(VerdeV(p));
    else
        VerdeI = VerdeI + Kv(VerdeV(p));
    end
end

%% for blue color(c & i)    
BluC = 0;
BluI = 0;
[m1,n1] = size(BluV);
for p=1:n1
    if Kv(BluV(p)) > threshold
        BluC = BluC + Kv(BluV(p));
    else
        BluI = BluI + Kv(BluV(p));
    end
end

%% for red%green color(c & i)
RossoVerdeC = 0;
RossoVerdeI = 0;
[m1,n1] = size(RossoVerdeV);
for p=1:n1
    if Kv(RossoVerdeV(p)) > threshold
        RossoVerdeC = RossoVerdeC + Kv(RossoVerdeV(p));
    else
        RossoVerdeI = RossoVerdeI + Kv(RossoVerdeV(p));
    end
end

%% for red&Blue color(c & i)
RossoBluC = 0;
RossoBluI = 0;
[m1,n1] = size(RossoBluV);
for p=1:n1
    if Kv(RossoBluV(p)) > threshold
        RossoBluC = RossoBluC + Kv(RossoBluV(p));
    else
        RossoBluI = RossoBluI + Kv(RossoBluV(p));
    end
end

%% for Green&Blue color(c & i)
VerdeBluC = 0;
VerdeBluI = 0;
[m1,n1] = size(VerdeBluV);
for p=1:n1
    if Kv(VerdeBluV(p)) > threshold
        VerdeBluC = VerdeBluC + Kv(VerdeBluV(p));
    else
        VerdeBluI = VerdeBluI + Kv(VerdeBluV(p));
    end
end

%% for white color(c & i)
BiancoC = 0;
BiancoI = 0;
[m1,n1] = size(BiancoV);
for p=1:n1
    if Kv(BiancoV(p)) > threshold
        BiancoC = BiancoC + Kv(BiancoV(p));
    else
        BiancoI = BiancoI + Kv(BiancoV(p));
    end
end

%% for black color(c & i)
NeroC = 0;
NeroI = 0;
[m1,n1] = size(NeroV);
for p=1:n1
    if Kv(NeroV(p)) > threshold
        NeroC = NeroC + Kv(NeroV(p));
    else
        NeroI = NeroI + Kv(NeroV(p));
    end
end

Color_Coherence_Vector = [RossoC,RossoI,VerdeC,VerdeI,BluC,BluI,RossoVerdeC,RossoVerdeI,RossoBluC,RossoBluI,VerdeBluC,VerdeBluI,BiancoC,BiancoI,NeroC,NeroI];
f = Color_Coherence_Vector;
