> 要开发一个quicklook, 然后在ai的指导下一通瞎鸡儿操作, 用了一周才搞出来. 这玩意其实是: 开发一小时, 傻等两三天. 
> 只要不瞎鸡儿操作, 还是很轻松容易的. 但是, 奈何苹果不做人, 文档拉的一塌糊涂. 为了不让后来人像我一样遭罪, 搞了这个样例项目: github.com:lornally/helloQL

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
2. 这个项目会在finder有一个目录, 这个目录随便操作, 删除移动都是自由的. 曾经在开着xcode的时候不小心删除了文件夹(不过, 还是不建议大家这么干). 

###### 打包分发 耗时: 20分钟
> 这里有一个注意的点, 这个时间很神奇的和build的值正相关, 因此, 保持build为1吧, 如果不信, 你改成200试试就知道了.
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
| **UTTypeIdentifier**        | 主app(或扩展)  | 全局唯一uti          | com.example.demohello |
| **QLSupportedContentTypes** | 扩展           | 我能预览这个uti      | [uti必须一致]         |
| **LSItemContentTypes**          | 主app          | 我能处理这个uti      | [uti必须一致]         |
| **UTTypeTagSpecification**  | 主app(或扩展)  | 声明后缀             | demohello             |
| **LSHandlerRank**           | 主app          | 声明对文件的负责程度 | Owner / Default       |

* 具体内容参考我这个样例代码.
* 这里面关键是每个扩展都搞且只搞: QLSupportedContentTypes

#### 不要瞎鸡儿操作 耗时: 0秒
* scheme是xcode自动控制, 不要进行任何scheme操作. 任何scheme相关操作都是对xcode的干扰,  Scheme ▸ Edit Scheme… → Executable 默认就是 Ask on Launch。 这些都不要动.
* ⌘R 运行，如果弹出 Choose an app to run → 选 Finder → Replace。

### 大功告成 耗时: 20分钟

此时, 再做一遍打包流程, 你就拥有人生中第一个quicklook了.

> 全流程, 操作时长40分钟, 等待时长2天, 每次打包等待时长20分钟.

###### scheme有什么用?
* 你如果要跟踪调试设置断点, 那么你要选择一下scheme, 其他时候不要碰他.
* 选择scheme的位置在主面板顶部

## 爬坑 - quicklook不生效 - 苹果的智熄设计还在C
### 无法理解的脑残设计

* 为什么minimum deployment macos这个要逐个设置? 
* 灵魂问题: 什么情况下, 主app和扩展要不同的系统兼容性?

### 莫名奇妙的系统特性: 

* debug一般不会生效

1. 要打包为app
2. 要等待, 等一下才能好

#### 脑花清奇 UTI 
* UTI别用${uti}这种参数化形式, 实测不支持(macos15.6 xcode 16.4)
* 如果要改UTI, 那么要同步主app和所有扩展
* 不禁要发出灵魂拷问: 主app为什么要使用和扩展不一样的UTI?

#### 脑子进水了, 莫名的必填字段

* 还有一个不生效的原因(非常扯淡, 垃圾苹果): 主程序 info, 有两个描述字段必填:
  1. document type 的 name
  2. exported type identifier 的 discription

#### 不生效自查内容: 

* 是不是在debug, debug不生效很正常, 打包之后再测
* 一定要保证主程序和扩展的兼容macos版本一致性: general -> minimum deployment : macos 12
* 保证主app和扩展的UTI一致性, 并且要使用正常字符(只有: 26个小写字母和小数点), 不能有任何符号
  * 主app至少有两个UTI要一致, 一个是document type, 一个是exported type(定义扩展名的那个)
  * 如果是quicklook扩展, 要检查QLSupportedContentTypes,  同样要保持一致的UTI
* 确保两个必填字段有内容: 
   1. document type 的 name
   2. exported type identifier 的 discription
* 是否修改代码过ql代码, 如果不改代码, ql部分会默认调用父类, 也就是啥也不做, 这又是苹果逆天的地方, 一般情况下, 开源框架在此时好歹会显示一个hello world, 修改位置:
    1. PreviewProvider.swift 决定“要不要提供预览”以及“用哪个 ViewController 来展示”。
    2. PreviewViewController.swift 负责“真正把预览内容画出来”。
    * 代码参见样例代码


#### 如果不生效
* 清理缓存, 参见下一个段落
如果不行, 多清几次, 然后, 等等时间

## 对抗系统注册/设置的缓存问题

### 管理(正常操作)
系统设置-> 通用 -> 登录项与管理 -> 这里有几乎所有的管理内容.

### 改名
1. 改扩展名, UTTypeTagSpecification

2. 改UTI,  至少要改三个地方

   主app的doccument type和exported type

   ql扩展的QLsupportContentType

3. 直接把项目换个 Bundle ID（比如 cn.isuyu.hello2.hql），重新签名运行——系统会当作全新扩展注册，几乎 100% 立即生效。

### 清理缓存
```sh
# 0. 重置 Quick Look 服务器
qlmanage -r cache

# 1. 刷新你的扩展
pluginkit -a /Applications/YourApp.app/Contents/PlugIns/*.qlgenerator
pluginkit -a /Applications/YourApp.app/Contents/PlugIns/*.appex

# 2. 杀死 Quick Look 守护进程, 系统服务缓存
pkill -f quicklookd
killall Finder
killall QuickLookUIService
# 这里是全系统的缓存, 所以系统重建索引要十几分钟
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
-kill：注销所有缓存
-r：递归扫描并重建
三个 -domain：把本地/系统/用户三个域全部清掉
```
