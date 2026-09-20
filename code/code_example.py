"""排版示例：用数字 1、2、3、4 枚举不含重复数字的三位数。

改编自 CUMCM 模板 code/code_example.py；仅使用 Python 标准语法。
"""

for i in range(1, 5):
    for j in range(1, 5):
        for k in range(1, 5):
            if i != j and i != k and j != k:
                print(i, j, k)
