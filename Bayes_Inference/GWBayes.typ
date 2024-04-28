#import "../Template/pset.typ": pset
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
#set text(12pt, font: ("Times New Roman", "寒蟬錦書宋"))
#set math.equation(numbering: "(1)", supplement: [ 公式: ])
#show: pset.with(
  class: "Statistics",
  student: "Yabusame",
  title: "Bayesian Inference",
  date: datetime.today(),
)

= 概念介绍
#figure(
  image("/Bayes_Inference/graph/GW示意.png", width: 60%),
  caption: [ GW 示意图 ],
)

== 参数估计&&假设检验
事件和概率定义(不同的概率诠释)，数学书上有要(Ω,F,P)---样本空间 Ω 、事件空间 F 和概率测度 P\。Kolmogorov axiom: 考虑集合 $SS$ 和它的子集
A,B...概率公理如下：
#enum(
  indent: 4em,
  [$forall A subset SS, P(A) >= 0 $ 非负性],
  [$P(SS) = 1$ 归一化],
  [$A sect B = emptyset, P(A union B)=P(A)+P(B)$ 可加性],
)

#h(2em)贝叶斯定理
$ P(A|B) = (P(B|A)P(A))/P(B) $

#h(2em)全概率公式
$ P(A|B) &= (P(B|A)P(A))/P(B) \
       &= (P(B|A)P(A))/display(sum_i P(B|A_i)P(A_i)) $

#h(2em) GW detection:
$ d(t)=cases(n(t) "if signal not present", n(t)+h(t;theta) "if signal " h" present") $

$ P(h|d) &= (P(d|h)pi(h))/P(d) = (P(d|h)pi(h))/(P(d|h)pi(h)+p(d|0)pi(0)) \
       &= Lambda[Lambda+pi(0)/pi(h)]^(-1) "where " Lambda = (P(d|h))/(P(d|0))=P(d-h|0)/P(d|0) ("Finn 1992") \
       & "最后分子变换的解释： 把引力波的信号去除剩下的是噪声" \
       & "假设噪声是稳态高斯白噪声，可以对噪声的概率分布写出表达式" \
       & "用噪声的分布模拟引力波信号 ？"$

不可排除的假信息： glich (e.g. 风、地震等等，人为消除、关联已知数据消除)\
Stationary, Gaussian white noise:
$ P(n|0) = NN e^(-1/2(n|n)) = NN e^(-1/2(n^TT dot C^(-1) dot n)) $
log-likelihood ratio:
$ ln(Lambda) = -1/2(d-h|d-h)+1/2(d|d) = (d|h)-1/2(h|h) $
对其求导得到SNR的平方$arrow Lambda$会有一个阈值(90%，$1.645 sigma$)对应着:SNR=8\
log-likelihood ratio 很大$arrow$探测到引力波

The Law of Large Number && The Central Limit Theorem

Bayesian Inference
- Parameter estimation : #text(red)[Posterior]
  - Find the Posterior probability density $P(theta|d,HH)$

- Model Selection : #text(red)[Evidence]
  - compare different hypotheses through an odds ratio ($HH_1 "is perfer when" > 1 $)
    $ O^(HH_1)_(HH_2) = P(HH_1|d)/P(HH_2|d) = (P(d|HH_1)P(HH_1))/(P(d|HH_2)P(HH_2)) prop Z_1/Z_2 ("Evidence ratio") $


== Bayesian Computation method
Bayes-factor(Zimmerman et al. 2019)


#figure(
  image("/Bayes_Inference/graph/采样器.png", width: 70%),
  caption: [
    采样器列表
  ],
)
=== MCMC
+ Direct Sampling
+ Rejection Sampling (要能包起来，heavy tail分布用这种方法不行)
Detail Balance Condition : $pi(i)P(i,j)=pi(j)P(j,i)$

Limitation of MCMC:
+ 收敛到极值点
+ 采样结果不收敛
+ 结束条件

Burn-in && Thin-in && Auto-correlation Statistics && Gelman-Rubin Statistics\
多峰结构：可能被困在局域极值上\
可以用PTMCMC(parallel-tempering)并行退火算法（多个温度）\
(MCMC不能计算Evdience, 但2019年时Maturana-Russel 提出将MCMC与Stepping-stone联合使用 $arrow$Evdience)

=== Nest-Sampling
(Ashton et al 2022)

- Well-defined stopping criteria
- Calculate the Evdience
- Solve multimodal problem

K-L divergence 之类的数据处理方法用进来啊啊啊啊啊啊啊

#figure(
  image("/Bayes_Inference/graph/坐标转换.png", width: 80%),
  caption: [先验和坐标参数有关($r^2 ,cos theta,phi$)一般对体积元平权],
)

