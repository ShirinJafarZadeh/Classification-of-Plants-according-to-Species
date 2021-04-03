function programm()
	fileID = fopen('iris2D.txt','r');
	names = fgets(fileID);
	Data = textscan(fileID, '%f %f %s');
	x1 = Data{1};   %data is cell
	x2 = Data{2};
	label = Data{3};
	fclose(fileID);
    
    n = length(x1);
    
	indxSetosa = strcmp(label, 'setosa');
	indxVersicolor = strcmp(label, 'versicolor');
	indxVirginica = strcmp(label, 'virginica');
	x1Setosa = x1(indxSetosa);
	x1Versicolor = x1(indxVersicolor);
	x1Virginica = x1(indxVirginica);
	x2Setosa = x2(indxSetosa);
	x2Versicolor = x2(indxVersicolor);
	x2Virginica = x2(indxVirginica);
    figure;
	hold on;
	scatter(x1Setosa, x2Setosa, 20, '*', 'blue');       %‰„Êœ«— y »—Õ”» x —« „?ò‘œ
	scatter(x1Versicolor, x2Versicolor, 20, '*', 'black');
	scatter(x1Virginica, x2Virginica, 20, '*', 'red');
	xlabel({'X1','(petal length)'});
	ylabel({'X2','(petal width)'})
	axis equal;     %„ﬁ?«”‘«‰ ?ò”«‰ »«‘œ
	axis([0 7 0 3]);
    
    smallLen = zeros(n, 1);
    mediumLen = zeros(n, 1);
    largeLen = zeros(n, 1);
    smallWid = zeros(n, 1);
    mediumWid = zeros(n, 1);
    largeWid = zeros(n, 1);
    for i=1:n
        smallLen(i) = smallLength(x1(i));
        mediumLen(i) = mediumLength(x1(i));
        largeLen(i) = largeLength(x1(i));
        smallWid(i) = smallWidth(x2(i));
        mediumWid(i) = mediumWidth(x2(i));
        largeWid(i) = largeWidth(x2(i));
    end
    
    SetosaValue = zeros(n, 1);
    VersicolorValue = zeros(n, 1);
    VirginicaValue = zeros(n, 1);
    for i=1:n
        SetosaValue(i) = FuzzyAND(smallLen(i), smallWid(i));
        VersicolorValue(i) = FuzzyAND(mediumLen(i), mediumWid(i));
        VirginicaValue(i) = FuzzyAND(largeLen(i), largeWid(i));
    end
    
    allValue = [SetosaValue, VersicolorValue, VirginicaValue];
    [maxValues, maxIndex] = max(allValue, [], 2);
    estimateIndxSetosa = (maxIndex == 1);       
    estimateIndxVersicolor = (maxIndex == 2);
    estimateIndxVirginica = (maxIndex == 3);
    x1Setosa = x1(estimateIndxSetosa);      %ÿÊ· ê·»—ê ” Ê”«
	x1Versicolor = x1(estimateIndxVersicolor);
	x1Virginica = x1(estimateIndxVirginica);
	x2Setosa = x2(estimateIndxSetosa);      %⁄—÷ ê·»—ê ” Ê”«
	x2Versicolor = x2(estimateIndxVersicolor);
	x2Virginica = x2(estimateIndxVirginica);
	scatter(x1Setosa, x2Setosa, 70, 'o', 'blue');
	scatter(x1Versicolor, x2Versicolor, 70, 'o', 'black');
	scatter(x1Virginica, x2Virginica, 70, 'o', 'red');
	hold off;
    
    estimateLabel = cell(n, 1);
    estimateLabel(estimateIndxSetosa) = {'setosa'};
    estimateLabel(estimateIndxVersicolor) = {'versicolor'};
    estimateLabel(estimateIndxVirginica) = {'virginica'};
    error = n - sum(strcmp(estimateLabel, label));      %?ò«—Ê »«Â„ Ã„⁄ ò—œ?„ «“ n ò„ ò—œ?„  ⁄œ«œ Œÿ«Â« »œ”  «Ê„œ
    fprintf('error is : %d\n', error);
end

function A = smallLength(x)
    if x < 2
        A = 1;
    elseif x < 3
        A = 3 - x;
    else
        A = 0;
    end
end

function A = mediumLength(x)
    if x < 2
        A = 0;
    elseif x < 4
        A = 0.5 * x - 1;
    elseif x < 6
        A = 3 - 0.5 * x;
    else
        A = 0;
    end
end

function A = largeLength(x)
    if x < 4
        A = 0;
    elseif x < 6
        A = 0.5 * x - 2;
    else
        A = 1;
    end
end

function A = smallWidth(x)
    if x < 0.5
        A = 1;
    elseif x < 1
        A = (1 - x) / 0.5;
    else
        A = 0;
    end
end

function A = mediumWidth(x)
    if x < 0.5
        A = 0;
    elseif x < 1.25
        A = (x - 0.5) / 0.75;
    elseif x < 2
        A = (2 - x) / 0.75;
    else
        A = 0;
    end
end

function A = largeWidth(x)
    if x < 1.25
        A = 0;
    elseif x < 2
        A = (x - 1.25) / 0.75;
    else
        A = 1;
    end
end

function z = FuzzyAND(x, y)
    z = min(x,y);
end