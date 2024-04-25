#import "../Template/pset.typ":pset
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
#set text(12pt,font:("Times New Roman","SimSun"))

#show: pset.with(
  class: "Statistics",
  student: "Yabusame",
  title: "Information Critierion",
  date: datetime.today()
)

#let deriv(num, dnm)=[$ (d num) / (d dnm) $]

= 信息准则的几个谣传
AIC和BIC的原始形式如下:
$ text("AIC")_m=-2 sum_(i=1)^n log(p_(hat(theta))(y_i)) + 2d_m $
$ text("BIC")_m=-2 sum_(i=1)^n log(p_(hat(theta))(y_i)) + d_m log(n) $

== AIC适合预测, BIC适合解释 ?
这种看法忽略了参数化和非参数化情形, AIC可能在$n arrow infinity$时也不能取到最好模型，
在非参数情况下, BIC选择生成数据模型的一致性也不是良好定义的。

== 应该使用AIC, 因为现实情况更常见到非参数化的情形 ?
We can nest subproblems!

== $l_0$ 不如LASSO, SCAD, MCP, 因为它是离散的 ?
As far as we want!


