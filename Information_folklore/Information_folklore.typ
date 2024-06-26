#import "../Template/pset.typ": pset
#import "@preview/cuti:0.2.1": show-cn-fakebold
// #show: show-cn-fakebold
#set text(12pt, font: ("Times New Roman", "寒蟬錦書宋"))

#show: pset.with(
  class: "Statistics",
  student: "Yabusame",
  title: "Information Critierion",
  date: datetime.today(),
)

#let xb = $bold(x)$
#let yb = $bold(y)$

= 信息熵的基础知识

定义随机变量x的熵(#text(red,"离散情况"))：
$ H[x] = - sum_x p(x)log_2p(x) $
(*Noiseless Coding Theorem*) 熵是传输随机变量状态的比特数的下界

(*Maximum Entropy*)
$ tilde(H) = - sum_i p(x_i)ln p(x_i) + lambda (sum_i p(x_i) - 1) attach(=>, t: "maximize") p(x_i) = 1/M ; H = ln M \
"where M is the total number of the state" $

(*Differential Entropy*) 在(#text(red,"连续分布")) $p(x)$下，观测到随机变量$x_i$的概率 $ => p(x_i)Delta$

$ lim_(Delta->0){-sum_i p(x_i)Delta ln p(x_i)} = - integral p(x) ln p(x) dif x = H[x] $

(*Kullback-Leibler Divergence*)
$ "KL"(p||q) & = - integral p(xb) ln q(xb) dif xb - (- integral p(xb) ln p(xb) dif xb) \
           & = - integral p(xb) ln q(xb)/p(xb) dif xb $
注意 $"KL"(p||q) != "KL"(q||p)$，所以它并不是metric (Jensen 不等式证明等号成立的条件是$forall xb : p(xb)=q(xb)$)

(*Conditional Entropy*) 考虑联合分布，在已知x的情况下确定y值所需要的信息是 $-ln p(y|x) => text("所对应的信息熵",font:"寒蟬錦書宋")  H[y|x] = - integral.double p(xb,yb) ln p(yb|xb)dif yb dif xb  $ 
$ H[x,y] = H[y|x] + H[x] $

(*Mutual Information*) $xb$和$yb$之间的相互信息
$ I[xb,yb] = "KL"[p(xb,yb)||p(xb)p(yb)] = - integral.double p(xb,yb) ln ((p(xb)p(yb))/p(xb,yb)) dif xb dif yb $

= (Bouns) 信息准则的几个谣传
AIC和BIC的原始形式如下:
$ text("AIC")_m=-2 sum_(i=1)^n log(p_(hat(theta))(y_i)) + 2d_m $
$ text("BIC")_m=-2 sum_(i=1)^n log(p_(hat(theta))(y_i))+ d_m log(n) $

== AIC适合预测, BIC适合解释 ?
这种看法忽略了参数化和非参数化情形, AIC可能在$n arrow infinity$时也不能取到最好模型，在非参数情况下,
BIC选择生成数据模型的一致性也不是良好定义的。

== 应该使用AIC, 因为现实情况更常见到非参数化的情形 ?
在实际情况中信息准则也会受到样本数的影响，例如：
#enum(
  indent: 4em,
  [在样本少非参数的情况下， BIC可以察觉到突出的模型 ],
  [在参数化的情况下，系数在不同的数量级上很小，并且样本数不足以 估计它们，在这种情况下选择模型使用AIC更加适合],
  [主要有部分参数化、部分非参数化的两种情况],
)
== penlity $l_0$ 不如 penlity (LASSO, SCAD, MCP), 因为它是离散的 ?
信息准则相当于带有$l_0$ penlity的回归， penlity 是否正确取决于计算的目的
#list(
  indent: 4em,
  [即使是对于固定调整参数(fixed tuning parameter)，选择模型的能力与penlity function 的连续与否没有直接关系],
  [固定调整参数(fixed tuning parameter)的选择基于数据，其他penlity 不一定会给出更好结果],
  [事实上$l_0$ penlity 方式以最少的约束条件得到了minimax rate最佳值 ],
)

复杂的理论看不懂...直接到建议部分：
+ 当选择模型是为了预测的时候：
  - 依据参数化指标或者交叉验证选择AIC-Type 或 BIC-Type 方法
  - 使用适应性的信息准则(例如BC) 结合AIC和BIC的方式
+ 当希望从后随观测的相似的样本大小中重新得到选择参数时(选择变量用以解释模型)---使用BIC-Type 防止引入不重要的变量
+ 如果保护最坏情况预测精度非常重要，首选AIC --- 极小极大速率(minmax rate)最优性
  此外对于寻找可能相关变量的探索性研究，尽管AIC型方法可能会过度选择，但不会遗漏重要变量，这些变量可以在大样本量的后续研究中验证
+ 当预测变量的数量 d 与样本大小 n 相比并不小，并且考虑 d 变量的所有子集时，最好使用高维 AIC 或 BIC 来解决潜在的严重选择偏差
+ 当模型选择不稳定性较高时，出于预测目的，可以考虑模型平均