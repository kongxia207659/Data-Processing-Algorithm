import random
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import xlrd
import os



#使用方法：将主函数中dataset设置为自己想要输入的数据矩阵
#        k为自己想要分类的集群个数
#该算法可以找出聚类中心的位置
# 计算欧拉距离
def calcDis(dataSet, centroids, k):
    clalist = []
    for data in dataSet:
        diff = np.tile(data, (k,1)) - centroids  # 相减   (np.tile(a,(2,1))就是把a先沿x轴复制1倍，即没有复制，仍然是 [0,1,2]。 再把结果沿y方向复制2倍得到array([[0,1,2],[0,1,2]]))
        squaredDiff = diff ** 2  # 平方
        squaredDist = np.sum(squaredDiff, axis=1)  # 和  (axis=1表示行)
        distance = squaredDist ** 0.5  # 开根号
        clalist.append(distance)
    clalist = np.array(clalist)  # 返回一个每个点到质点的距离len(dateSet)*k的数组
    return clalist


# 计算质心
def classify(dataSet, centroids, k):
    # 计算样本到质心的距离
    clalist = calcDis(dataSet, centroids, k)
    # 分组并计算新的质心
    minDistIndices = np.argmin(clalist, axis=1)  # axis=1 表示求出每行的最小值的下标
    newCentroids = pd.DataFrame(dataSet).groupby(
        minDistIndices).mean()  # DataFramte(dataSet)对DataSet分组，groupby(min)按照min进行统计分类，mean()对分类结果求均值
    newCentroids = newCentroids.values
    # 计算变化量
    changed = newCentroids - centroids
    return changed, newCentroids


# 使用k-means分类
def kmeans(dataSet, k):  #dataset是需要输入的数据
    # 随机取质心
    centroids = random.sample(dataSet, k)
    # 更新质心 直到变化量全为0
    changed, newCentroids = classify(dataSet, centroids, k)
    while np.any(changed != 0):
        changed, newCentroids = classify(dataSet, newCentroids, k)
    centroids = sorted(newCentroids.tolist())  # tolist()将矩阵转换成列表 sorted()排序

    # 根据质心计算每个集群
    cluster = []
    clalist = calcDis(dataSet, centroids, k)  # 调用欧拉距离
    minDistIndices = np.argmin(clalist, axis=1)
    for i in range(k):
        cluster.append([])
    for i, j in enumerate(minDistIndices):  # enymerate()可同时遍历索引和遍历元素
        cluster[j].append(dataSet[i])
    return centroids, cluster   #返回质心和对应的集群


def readExcelDataByName(fileName, sheetName):
    data = xlrd.open_workbook(r'C:\Users\32374\Desktop\MIM_matlab\火点经纬度.xlsx')
    x_data = []
    y_data = []
    data = xlrd.open_workbook(r'文件存储位置+文件名')
    table = data.sheets()[0]
    x_data = list(range(5301))
    cap = table.col_values(2)
    # print(cap)  #打印出来检验是否正确读取
    for i in range(1, 5302):
        y_data.append(cap[i])
    return y_data


if __name__ == '__main__':
    #输入dataset和k
    table = xlrd.open_workbook('C:/Users/32374/Desktop/MIM_matlab/火点经纬度.xlsx').sheets()[0]  # 获取第一个sheet表
    row = table.nrows  # 行数
    col = table.ncols  # 列数
    datamatrix = np.zeros((row, col))  # 生成一个nrows行*ncols列的初始矩阵
    for i in range(col):  # 对列进行遍历
        cols = np.matrix(table.col_values(i))  # 把list转换为矩阵进行矩阵操作
        datamatrix[:, i] = cols  # 按列把数据存进矩阵中
    dataset = datamatrix.tolist()
    k=10
    centroids, cluster = kmeans(dataset, k)
    print('质心为：%s' % centroids)
    # print('集群为：%s' % cluster)
    for i in range(len(dataset)):
        plt.scatter(dataset[i][0], dataset[i][1], marker='x', color='green', s=40, label='原始点')
        #  记号形状       颜色      点的大小      设置标签
    for j in range(len(centroids)):
        plt.scatter(centroids[j][0], centroids[j][1], marker='o', color='red', s=50, label='质心')
    plt.show()
