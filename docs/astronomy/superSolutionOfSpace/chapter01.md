---
layout: default_with_math
title: 第１章 現代天文学の基礎概念
nav_order: 1
parent: 超・宇宙を解く
grand_parent: Astronomy
---

# 1 宇宙のスケール

### 問 1.3

- 水素原子（陽子 + 電子）$m_H$
- 中性水素ガスの質量密度 $\rho$
- 中性水素ガスの個数密度 $N$

とするとき、以下の関係がある。

$$
\rho = m_H N
$$

### 問 1.4

星間空間には平均$1\mathrm{cm^2}$に 1 個の水素原子がある。
よって、星間空間での平均的な個数密度$\bar{N}_H$は、

$$
\bar{N}_H = 1 \mathrm{個/cm^3}
$$

質量密度は$\bar{\rho}_H$は、

$$
\begin{align*}
\bar{\rho}_H &= N_H m_H \\
&= N_H (m_p + m_e) \\
&= 1 \times (1.6726 \times 10^{-24} +  9.1094 \times 10^{-28}) \\
&= (1.6726 + 9.1094 \times 10^{-4}) \times 10^{-24} \\
&\simeq 1.673 \times 10^{-24} \quad \mathrm{[g/cm^3]}
\end{align*}
$$

### 問 1.5

平熱を 36.5℃ とすると、絶対温度では

$$
\begin{align*}
T \enspace \mathrm{[^\circ K]} &= 36.5 \enspace \mathrm{[^\circ C]} + 273.16 \\
&= 309.66 \enspace \mathrm{[^\circ K]}
\end{align*}
$$

### 問 1.6

$$
\begin{align*}
1 \enspace \mathrm{[arcsec]} &= \frac{1}{3600} \enspace \mathrm{[^\circ]} \\
&= \frac{1}{3600} \enspace \mathrm{[^\circ]} \times \frac{2 \pi}{360} \enspace \mathrm{[\frac{rad}{^\circ}]} \\
&\simeq 4.8 \enspace \mathrm{[rad]}
\end{align*}
$$

### 演習１：対数スケール

#### 宇宙の階層構造とサイズ

省略

<!-- ![宇宙の階層構造とサイズ](./images/exercise01-01.png) -->

#### 宇宙の歴史と時間

省略

<!-- ![宇宙の歴史と時間](./images/exercise01-02.png) -->

### 演習２：サイズと質量

省略

### 研究：次元解析とプランク時間

- 速度  
  $[c] = LT^{-1}$
- 万有引力  
  $[G] = L^3T^{-2}M^{-1}$
- プランク定数  
  $[h] = L^2T^{-1}M$

上記基本定数から$L$, $M$を消去する。

$$
\begin{align*}
[G] &= L^3T^{-2}M^{-1} \\
&= ([c]T)^3 T^{-2} ([h]L^{-2}T)^{-1} \\
&= [c]^3 [h]^{-1}L^2 \\
&= [c]^3 [h]^{-1} ([c]T)^2 \\
&= [c]^5 [h]^{-1} T^2 \\
\Leftrightarrow T &= \sqrt{[G][h][c]^{-5}}
\end{align*}
$$

このように基本定数の組み合わせで導くことができる時間の次元を持った量を **プランク時間(planck time)** と呼ぶ。プランク時間は時間の最小単位であり、宇宙開闢の最初の時刻でもある。
同様に **プランク長さ(planck length** は以下のように表される。

$$
\begin{align*}
[G][h] &= L^5 T^{-3} \\
&= L^5 ([c]^{-1}L)^{-3} \\
&=[c]^3 L^2 \\
\Leftrightarrow L &= \sqrt{[G][h][c]^{-3}}
\end{align*}
$$

具体的な値は以下の通り。

- プランク時間 $t_p$

  $$
  \begin{align*}
  t_p &= \sqrt{Ghc^{-5}} \\
  &= \sqrt{(6.6743 \times 10^{-11})(6.6261 \times 10^{-34})(2.9979 \times 10^8)^{-5}} \\
  &= \sqrt{6.6743 \times 6.6261 \times 2.9979^{-5} \times 10^3} \times 10^{-44} \\
  &= 1.3514 \times 10^{-43}  \enspace \mathrm{[s]}
  \end{align*}
  $$

- プランク長さ $l_p$

  $$
  \begin{align*}
  t_l &= \sqrt{Ghc^{-3}} \\
  &= \sqrt{(6.6743 \times 10^{-11})(6.6261 \times 10^{-34})(2.9979 \times 10^8)^{-3}} \\
  &= \sqrt{6.6743 \times 6.6261 \times 2.9979^{-3} \times 10} \times 10^{-35} \\
  &= 4.0514 \times 10^{-35}  \enspace \mathrm{[m]}
  \end{align*}
  $$

# 2 重力と重力エネルギー

## 2.1 重力と重力加速度

質量 $m$ と $M$ の 2 つの物体が距離 $r$ だけ離れているとき、この 2 つの物体の間にはたらく引き合う力を **重力** という。
重力の大きさ F は、以下のように表される。
ここで、 $G$ は **重力定数** である。
距離の正の方向とは逆向きの力（引き合う力）であることがわかる。

$$
F = - \frac{GmM}{r^2}
$$

また、$m = 1$ とし、単位質量当たりの重力すなわち重力加速度は以下のように表される。

$$
g = - \frac{GM}{r^2}
$$

### 問 2.1

- 地球－太陽 の間にはたらく重力

  $$
  F_{Earth-Sun} = - \frac{G m_{Earth} m_{Sun}}{r_{Earth-Sun}^2}
  $$

- 地球－月 の間にはたらく重力

  $$
  F_{Earth-Moon} = - \frac{G m_{Earth} m_{Moon}}{r_{Earth-Moon}^2}
  $$

地球にはたらく太陽と月の重力の大きさの比は、

$$
\begin{align*}
\frac{F_{Earth-Sun}}{F_{Earth-Moon}} &= \frac{m_{Sun}}{m_{Moon}} \frac{r_{Earth-Moon}^2}{r_{Earth-Sun}^2} \\
&= \frac{m_{Sun}}{m_{Sun} \times 3.6943 \times 10^{-8}} \frac{(3.8440 \times 10^{8})^2}{(1.4960 \times 10^{11})^2} \\
&= \frac{3.8440^2 \times 10^{16}}{3.6943 \times 1.4960^2 \times 10^{14}} \\
&= 1.787 \times 10^2
\end{align*}
$$

月が地球の軌道上にあるとき、月にはたらく太陽と地球の重力の比は、

$$
\begin{align*}
\frac{F_{Moon-Sun}}{F_{Moon-Earth}} &= - \frac{G m_{Moon} m_{Sun}}{r_{Moon-Sun}^2} / - \frac{G m_{Moon} m_{Earth}}{r_{Moon-Earth}^2} \\
&= \frac{m_{Sun}}{m_{Earth}} \frac{r_{Moon-Earth}^2}{r_{Moon-Sun}^2} \\
&= \frac{m_{Sun}}{m_{Earth}} \frac{r_{Moon-Earth}^2}{r_{Earth-Sun}^2} \\
&= \frac{m_{Sun}}{m_{Sun} \times 3.0404 \times 10^{-6}} \frac{(3.8440 \times 10^{8})^2}{(1.4960 \times 10^{11})^2} \\
&= \frac{3.8440^2 \times 10^{16}}{3.0404 \times 1,4960^2 \times 10^{-16}} \\
&= 2.178
\end{align*}
$$

### 問 2.2

距離 $50 \mathrm{cm}$ をあけて、体重 $60 \mathrm{kg}$ と $40 \mathrm{kg}$ の人がいるとき、両者にかかる重力の大きさ $F$ は、

$$
\begin{align*}
F &= \frac{G \times 60 \times 40}{0.5^2} \\
&= \frac{6.67 \times 10^{-11} \times 60 \times 40}{0.5^2} \\
&= 6.40 \times 10^{-7} \enspace \mathrm{[N]}
\end{align*}
$$

この力と同じ大きさの地球の重力がはたらく物体の質量 $m$ は、

$$
\begin{align*}
F &= mg \\
F &= m\frac{GM_{Earth}}{R_{Earth}^2} \\
\Leftrightarrow m &= F \frac{R_{Earth}^2}{GM_{Earth}} \\
&= \frac{G \times 60 \times 40}{0.5^2} \frac{R_{Earth}^2}{GM_{Earth}} \\
&= \frac{60 \times 40}{0.5^2} \frac{(6.3781 \times 10^6)^2}{5.9722 \times 10^{24}} \\
&= 6.5 \times 10^{-8}  \enspace \mathrm{[kg]}
\end{align*}
$$

### 問 2.3

水素原子において、陽子の周りを電子がボーア半径 $a_0$ で円運動していると考えると、
陽子－電子間にはたらく重力の大きさ $F$ とクーロン力の大きさ $F_q$ は次の通り。

$$
\begin{align*}
F &= \frac{G m_p m_e}{a_0^2} \\
&= \frac{6.67 \times 10^{-11} \times 1.6726 \times 10^{-27} \times 9.1094 \times 10^{-31}}{(5.2918 \times 10^{-11})^2} \\
&= 3.62 \times 10^{-47} \enspace \mathrm{[N]} \\
\\
F_q &= \frac{1}{4 \pi \epsilon_0} \frac{q_p q_e}{a_0^2} \\
&= \frac{1}{4 \pi \times 8.8542 \times 10^{-12}} \frac{(1.6022 \times 10^{-19})^2}{(5.2918 \times 10^{-11})^2} \\
&= 8.24 \times 10^{-8} \enspace \mathrm{[N]}
\end{align*}
$$

陽子－電子間にはたらく重力の大きさ $F$ とクーロン力の大きさ $F_q$ の比は以下の通り。

$$
\begin{align*}
F/F_q &= 4.39 \times 10^{-40}
\end{align*}
$$

重力に比べてクーロン力が圧倒的に大きいことが分かる。しかし、宇宙では多くの物体は電気的に中性であるため、クーロン力が働かないため重力が重要となる。

## 2.2 位置（重力, ポテンシャル）エネルギー

物体に力 $F$ が働いており、力の方向に微小距離 $dr$ だけ物体を移動させたとき、この力がなした仕事 $dW$ は次のように表現できる。

$$
dW = F dr
$$

質量 $M$ の物体から距離 $r$ の位置にある質量 $m$ の物体を 距離 $r_1$ から $r_2$ に移動させたとき、質量 $m$ の物体にかかる重力がなした仕事 $W$ は、

$$
\begin{align*}
W &= \int_{r_1}^{r_2} \left( - \frac{GmM}{r^2} \right) dr \\
&= GmM \left( \frac{1}{r_2} - \frac{1}{r_1} \right)
\end{align*}
$$

一般に物体の位置エネルギー(ポテンシャルエネルギー)は、 **物体がその位置から基準点に移動したときに力がなす仕事** に等しい。

例えば、高さ $0$ を基準としたとき、重力加速度 $g$ がかかっていて、高さ $h$ にある質量 $m$ の質点がもつ位置エネルギーは $mgh$ となるが、これはつまり、この質点が基準点に移動するために $mgh$ の仕事が必要であるということ。
（ $mgh$ の仕事がなされる可能性（ポテンシャル）というイメージだろうか）

質点による重力の場合は、この基準点を **無限遠の距離** とする習慣がある。
よって、 **質量 $M$ の物体から距離 $r$ だけ離れた質量 $m$ の物体のもつ位置エネルギー** は、

$$
\Phi = - \frac{GmM}{r}
$$

となる。  
また、単位質量当たりの場合は、

$$
\phi = - \frac{GM}{r}
$$

となる。

一般的には、ポテンシャル $\Phi$ と力 $F$ の間には以下の関係が成り立つ（ここで $x_0$ はポテンシャルの基準点）

$$
F(x) = - \frac{d\Phi(x)}{dx} \\
\Phi(x) = \int_{x}^{x_0} F(x)dx
$$

### 問 2.4

質量 $M$ の物体の周りを半径 $r$ で円運動する質量 $m$の物体の位置エネルギーを $\Phi$ 、運動エネルギーを $T$ とする。

質量 $M$ の物体を座標原点にとり、 $(r, \phi)$ の二次元極座標を考える。
動径方向の運動方程式から、

$$
\begin{align*}
m ( \ddot{r} - r \dot{\phi}^2 ) &= - \frac{GmM}{r^2} \\
\Leftrightarrow m r \dot{\phi}^2 &= \frac{GmM}{r^2} \enspace ( \because \dot{r} = 0 （円運動）)\\
\Leftrightarrow m (r \dot{\phi})^2 &= \frac{GmM}{r} \\
\Leftrightarrow 2 \left( \frac{1}{2} m (r \dot{\phi})^2 \right) &= \frac{GmM}{r} \\
\Leftrightarrow 2T + \Phi &= 0
\end{align*}
$$

### 問 2.4

重力によるポテンシャルエネルギー $\Phi$ を微分する。

$$
\begin{align*}
\frac{d\Phi}{dr} &= - \left( - \frac{GmM}{r^2} \right) \\
&= - F(r) \\
\Leftrightarrow F(r) &= - \frac{d\Phi(r)}{dr}
\end{align*}
$$

単位質量あたりの重力によるポテンシャルエネルギー $\phi$ を微分する。

$$
\begin{align*}
\frac{d\phi}{dr} &= - \left( - \frac{GM}{r^2} \right) \\
&= - g(r) \\
\Leftrightarrow g(r) &= - \frac{d\phi(r)}{dr}
\end{align*}
$$

## 2.3 球殻内部の重力と位置エネルギー

下図より、

$$
\begin{align*}
\frac{dS \cos{\theta_A}}{r_A^2} &= \frac{d\Omega}{1^2} \\
dS \cos{\theta_A} &= d\Omega r_A^2
\end{align*}
$$

![図2.2 球殻内部の重力(補足)](../assets/img02_02.png)

よって、 $d \Omega $ 内の球殻の質量 $d m_A$ は、

$$
\begin{align*}
dm_A &= \sigma dS \\
&= \frac{\sigma r_A^2 d\Omega}{\cos{\theta_A}}
\end{align*}
$$

同様に、

$$
\begin{align*}
dm_B &= \frac{\sigma r_B^2 d\Omega}{\cos{\theta_B}}
\end{align*}
$$

よって、これら球殻の質量が点 P におよぼす重力の大きさ $dF_A$ と $dF_B$ の比は、

$$
\begin{align*}
\frac{dF_A}{dF_B} &= \frac{ \frac{G m dm_A}{r_A^2} }{ \frac{G m dm_B}{r_B^2} } \\
&= \frac{ \frac{G m}{r_A^2} \frac{\sigma  r_A^2 d\Omega}{\cos{\theta_A}} }{ \frac{G m}{r_B^2} \frac{\sigma r_B^2 d\Omega}{\cos{\theta_B}} } \\
&= 1 \enspace ( \because \theta_A = \theta_B )
\end{align*}
$$
