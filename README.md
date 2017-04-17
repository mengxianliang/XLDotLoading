# XLDotLoading
仿新浪微博的红包加载动画，过年在家里抢红包看到这个效果，就顺手仿照着写了一下。主要还是利用余弦函数曲线的特性实现的。具体原理是圆球在从左向右移动时时先缩小再放大，圆球从右向左移动时先放大在缩小；然后再加上另一个圆球就实现了这样远近交换的效果。

### 显示效果如下

<img src="https://github.com/mengxianliang/XLDotLoading/blob/master/1.gif" width=300 height=534 />

### 使用方法

**显示：**

```objc
[XLDotLoading showInView:self.view];
```
**隐藏：**
```objc
[XLDotLoading hideInView:self.view];
```

### 实现原理请参考[我的博文](http://blog.csdn.net/u013282507/article/details/54907724)
