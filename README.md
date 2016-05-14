发现有很多人搞了个xxxtips，所以就也搞一个lua的。
随便写写，记录一下知识点。


# 2016/5/14 lua函数的变参用法

使用...代表多个参数
>function test(...)

使用select获取参数，当arg为#时，返回参数个数；当arg为int时，返回对应的参数
>result = select(arg, ...)
