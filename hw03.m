function hw3()

close all
format compact

data = load('line_data_2.txt');
% one plot for all lines and points
figure, plot(data(:,1),data(:,2), 'r*');
hold on;
%____________Points Plotting Ends_____________________%

%nonhomo
y = data(:,2);
U = data(:,1);
U(:,2) = 1;
Ut = transpose(U);
mult = Ut * U;
multinv = inv(mult);
Ucross = multinv * Ut;
nonhomoLeast = Ucross * y; % m and b (slope and y intercept)
f1 = @(x) nonhomoLeast(1) * x + nonhomoLeast(2);
fplot(f1, 'b*-');
hold on;

% homo part
bigY = Ut * U;
eigenV = eig(bigY);
[V1, D1] = eig(bigY);
%different way to get the same thing%
[U1,S,V] = svd(U,0);
homoX = V(:,1); % end(instead of 1) for 2nd vector

%means for d%
M = mean(data);
d = homoX(1) * M(1) + homoX(2) * M(2);

f2 = @(x) (d - homoX(1) * x) / homoX(2);
fplot(f2, 'g*-');
hold off;

% slopes, intercepts, and RMS errors under both models (4 numbers per fit,
% 8 total) @35 on piazza

%RMSs
%rms nonhomo
%_______vertical_______%
funcYs = arrayfun(f1, data(:,1));
diffMat = data(:,2) - funcYs;
squaredMat = diffMat.^2;
nonhomosum = sum(squaredMat, 'all');
nonhomodivision = nonhomosum/300;
nonhomovertrms = sqrt(nonhomodivision);
nonhomovertrms

%_______perpendicular_______%
distMat = sqrt( (data(:,1) - data(:,1)).^2 + (data(:,2) - funcYs).^2);
squaredMat2 = distMat.^2;
nonhomosum2 = sum(squaredMat2, 'all');
nonhomodivision2 = nonhomosum2/300;
nonhomoperprms = sqrt(nonhomodivision2);
nonhomoperprms


%THIS COMMENT STUB STATES THAT 
%THIS CODE IS THE PROPERTY OF OMAR R.G. (UofA Student)

%rms homo
%_______vertical_______%
func2Ys = arrayfun(f2, data(:,1));
diffMathomo = data(:,2) - func2Ys;
squaredMathomo = diffMathomo.^2;
homosum = sum(squaredMathomo, 'all');
homodivision = homosum/300;
homovertrms = sqrt(homodivision);
homovertrms

%_______perpendicular_______%
distMat2 = sqrt( (data(:,1) - data(:,1)).^2 + (data(:,2) - func2Ys).^2);
squaredMathomo2 = distMat2.^2;
homosum2 = sum(squaredMathomo2, 'all');
homodivision2 = homosum2/300;
homoperprms = sqrt(homodivision2);
homoperprms

%________slopes and intercepts________%
%__NONHOMO__%
nonhomoSnI = polyfit(data(:,1),funcYs,1);
nonhomoslope = nonhomoSnI(1);
nonhomointercept = nonhomoSnI(2);
nonhomoslope
nonhomointercept

%__HOMO__%
homoSnI = polyfit(data(:,1),func2Ys,1);
%[func2Ys data(:,1)] for manual checking
homoslope = homoSnI(1);
homointercept = homoSnI(2);
homoslope
homointercept

end