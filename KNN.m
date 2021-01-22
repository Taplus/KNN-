clc;
clear;
matrix = [];
for delta = 0:9%����ѵ���������ľ��󣬷�ͼ��
  label_path = strcat('D:\GIT\handwitten_recognition\train\',int2str(delta),'\');
  disp(length(dir([label_path '*.png'])));
  for i = 1:length(dir([label_path '*.png']))
        im = imread(strcat(label_path,'\',int2str(delta),'_',int2str(i-1),'.png'));
        %imshow(im);
        im = imbinarize(im);
        temp = [];
        for j = 1:size(im,1)
            temp = [temp,im(j,:)];
        end
        matrix = [matrix;temp];
  end
end

label = [];%�ڱ�ǩ�������ӱ�ǩ������
 for i = 0:9
    tem = ones(length(dir([label_path '*.png'])),1) * i;
    label = [label;tem];
end
matrix = horzcat(matrix,label);

%���Զ�������
for delta = 0:9%��������ͼ�������
    test_path = strcat('D:\GIT\handwitten_recognition\test\',int2str(delta),'\');
    len = (length(dir([test_path '*.png'])));
    disp(len);
    p = 0;
    for i = 1:len
        vec = [];        
        test_im = imread(strcat('test\',int2str(delta),'\',int2str(delta),'_',int2str(i-1),'.png'));
        imshow(test_im);
        test_im = imbinarize(test_im);
        for j = 1:size(test_im,1)
            vec = [vec,test_im(j,:)];
        end

        dis = [];
        for count = 1:length(dir([label_path '*.png'])) * 10 
            row = matrix(count,1:end-1);
            distance = norm(row(1,:)-vec(1,:));
            dis = [dis;distance(1,1)];
        end
        test_matrix = horzcat(matrix,dis);


        %����
        test_matrix = sortrows(test_matrix,size(test_matrix,2));
        %����Kֵ��ǰK����������ǩ��������Ϊ������
        K = 5;
        result = mode(test_matrix(1:K,end-1));
        disp(strcat('ͼ��',int2str(delta),'_',int2str(i),'.png','��ʶ�����ǣ�',int2str(result)));

        if(delta == result)
            p = p + 1;
        end
        
        
    end
    pi = p/len;
    disp(strcat('ʶ�𾫶�Ϊ��',num2str(pi)));
    disp('Finished!'); 
end



