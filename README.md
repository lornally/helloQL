> 要开发一个quicklook, 然后在ai的指导下一通瞎鸡儿操作, 用了一周才搞出来. 这玩意其实是: 开发一小时, 傻等两三天. 
> 只要不瞎鸡儿操作, 还是很轻松容易的. 但是, 奈何苹果不做人, 文档拉的一塌糊涂. 为了不让后来人像我一样遭罪, 搞了这个样例项目.

本项目验证环境:

		macstudio m1max 32G, 
		macos sequoia 15.6
		xcode 16.4
		编译目标 macos 12
		已经购买了苹果开发者账号

# macos的xcode开发要点: '不要瞎鸡儿操作' 具体内容如下:

1. dev网站, 只要付钱, 不要搞任何的证书, appid等等, 这些都是xcode自动搞的. 你只要付好钱, 然后在xcode -> setting里面把account加进去, 这个世界就清净了.
2. 不要搞scheme, 这个也是xcode自动维护的. 你不要碰他, 任何对他的操作都会干扰xcode正常执行.


实际操作步骤
###### 第一步: 账号 耗时: 2天
1. 买一个苹果开发账号666元.
2. 等待, 等到收到账号正常的邮件. 注意是账号正常, 不是苹果收钱. 苹果收钱很快, 账号正常很慢. 2天都是正常的. 等吧, 等待期间不要瞎鸡儿操作. 可以周边游玩2天.
3. xcode里面setting->account 添加这个账号. 为了后面正常, 重启一次macos吧.

###### 第二步: 新建app 耗时: 1分钟
1. 随便新建mac app项目, 记得把test和storage选项选为none.
2. 这个项目会在finder有一个目录, 这个目录随便操作, 删除移动都是自由的. 不过你干这事得时候最好关了xcode, 我没在开着xcode的时候干过, 所以不清楚是不是会有问题.

###### 打包分发 耗时: 20分钟

1. product->archive 打包, 
2. 此时会出现新的一行, 选择这一行, 
3. 右侧distribute app, 面板选择 direct distribution
4. 此时那一行条目会变成: in progress, 同样等待, 可以去玩一把游戏.
5. 等到状态变成: ready to distribute, 此时鼠标上去这一行, 会看到按钮出现[export], 点击这个按钮, 你的第一个可以分发的软件就做好了.

###### 第三步: 新建quicklook 耗时: 1分钟

1. 左上角file -> new -> target
2. 选择quicklook, 名字随便取, 其他都默认

###### 第四步: 修改plist 耗时: 5分钟

| 字段                        | Info.plist位置 | 职责                 | 示例                  |
| --------------------------- | -------------- | -------------------- | --------------------- |
| **UTTypeIdentifier**        | 主app或扩展    | 全局唯一uti          | com.example.demohello |
| **QLSupportedContentTypes** | 扩展           | 我能预览这个uti      | [uti必须一致]         |
| LSItemContentTypes          | 主app          | 我能处理这个uti      | [uti必须一致]         |
| **UTTypeTagSpecification**  | 主app或扩展    | 声明后缀             | demohello             |
| **LSHandlerRank**           | 主app          | 声明对文件的负责程度 | Owner / Default       |

* 具体内容参考我这个样例代码.

#### 不要瞎鸡儿操作 耗时: 0秒
* scheme是xcode自动控制, 不要进行任何scheme操作. 任何scheme相关操作都是对xcode的干扰,  Scheme ▸ Edit Scheme… → Executable 默认就是 Ask on Launch。 这些都不要动.
* ⌘R 运行，如果弹出 Choose an app to run → 选 Finder → Replace。

### 大功告成 耗时: 20分钟

此时, 再做一遍打包流程, 你就拥有人生中第一个quicklook了.

> 全流程, 操作时长40分钟, 等待时长2天, 每次打包等待时长20分钟.
