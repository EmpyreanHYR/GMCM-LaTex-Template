% 排版示例：合并等高线与梯度方向图。
% 改编自 CUMCM 模板 code/code_example.m，补全原示例的输入变量。

[X, Y] = meshgrid(-2:0.2:2);
Z = X.^2 + Y.^2;
[U, V] = gradient(Z, 0.2, 0.2);

figure;
contour(X, Y, Z);
hold on;
quiver(X, Y, U, V);
hold off;
axis equal;
xlabel('x');
ylabel('y');
